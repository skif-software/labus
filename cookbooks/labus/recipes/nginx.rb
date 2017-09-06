#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# Copyright:: Copyright (c) 2014 GitLab.com
# Copyright:: Copyright (c) 2015 SKIF Software Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#salsa: you may wish to review some doc on NGINX settings
# https://gitlab.com/gitlab-org/omnibus-gitlab/blob/629def0a7a26e7c2326566f0758d4a27857b52a3/doc/settings/nginx.md#using-a-non-bundled-web-server

nginx_dir = node['labus']['nginx']['dir']
nginx_conf_dir = File.join(nginx_dir, "conf")
nginx_log_dir = node['labus']['nginx']['log_directory']

# These directories do not need to be writable for labus-www
[
  nginx_dir,
  nginx_conf_dir,
  nginx_log_dir,
].each do |dir_name|
  directory dir_name do
    owner 'root'
    group node['labus']['web-server']['group']
    mode '0750'
    recursive true
  end
end

link File.join(nginx_dir, "logs") do
  to nginx_log_dir
end

nginx_config = File.join(nginx_conf_dir, "nginx.conf")

nginx_gitlab_http_conf = File.join(nginx_conf_dir, "gitlab-http.conf")
nginx_ci_http_conf = File.join(nginx_conf_dir, "ci-http.conf")
nginx_redmine_http_conf = File.join(nginx_conf_dir, "redmine-http.conf")
nginx_account_http_conf = File.join(nginx_conf_dir, "account-http.conf")
nginx_indico_http_conf = File.join(nginx_conf_dir, "indico-http.conf")

# If the service is enabled, check if we are using internal nginx
nginx_gitlab_enabled = if node['labus']['labus-gitlab']['enable']
                         node['labus']['gitlab-nginx']['enable']
                       else
                         false
                       end

nginx_ci_enabled = if node['labus']['labus-ci']['enable']
                      node['labus']['ci-nginx']['enable']
                    else
                      false
                    end

nginx_redmine_enabled = if node['labus']['labus-redmine']['enable']
                      node['labus']['redmine-nginx']['enable']
                    else
                      false
                    end

nginx_account_enabled = if node['labus']['labus-account']['enable']
                      node['labus']['account-nginx']['enable']
                    else
                      false
                    end

nginx_indico_enabled = if node['labus']['labus-indico']['enable']
                      node['labus']['indico-nginx']['enable']
                    else
                      false
                    end

# Include the config file for labus-gitlab in nginx.conf later
nginx_vars = node['labus']['nginx'].to_hash.merge({
               :gitlab_http_config => nginx_gitlab_enabled ? nginx_gitlab_http_conf : nil
             })

# Include the config file for labus-ci in nginx.conf later
nginx_vars =  nginx_vars.merge!(
                :ci_http_config => nginx_ci_enabled ? nginx_ci_http_conf : nil
              )

# Include the config file for labus-redmine in nginx.conf later
nginx_vars =  nginx_vars.merge!(
                :redmine_http_config => nginx_redmine_enabled ? nginx_redmine_http_conf : nil
              )

# Include the config file for labus-account in nginx.conf later
nginx_vars =  nginx_vars.merge!(
                :account_http_config => nginx_account_enabled ? nginx_account_http_conf : nil
              )

# Include the config file for labus-indico in nginx.conf later
nginx_vars =  nginx_vars.merge!(
                :indico_http_config => nginx_indico_enabled ? nginx_indico_http_conf : nil
              )

if nginx_vars['listen_https'].nil?
  nginx_vars['https'] = node['gitlab']['gitlab-rails']['gitlab_https']
else
  nginx_vars['https'] = nginx_vars['listen_https']
end

template nginx_gitlab_http_conf do
  source "nginx-gitlab-http.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(nginx_vars.merge(
    {
      :fqdn => node['labus']['labus-gitlab']['labus_gitlab_host'],
      :socket => node['gitlab']['unicorn']['socket']
    }
  ))
  notifies :restart, 'service[nginx]' if OmnibusHelper.should_notify?("nginx")
  action nginx_gitlab_enabled ? :create : :delete
end

ci_nginx_vars = node['labus']['ci-nginx'].to_hash

if ci_nginx_vars['listen_https'].nil?
  ci_nginx_vars['https'] = node['gitlab']['gitlab-ci']['gitlab_ci_https']
else
  ci_nginx_vars['https'] = ci_nginx_vars['listen_https']
end

template nginx_ci_http_conf do
  source "nginx-ci-http.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(ci_nginx_vars.merge(
    {
      :fqdn => node['labus']['labus-ci']['labus_ci_host'],
      :socket => node['gitlab']['ci-unicorn']['socket']
    }
  ))
  notifies :restart, 'service[nginx]' if OmnibusHelper.should_notify?("nginx")
  action nginx_ci_enabled ? :create : :delete
end

redmine_nginx_vars = node['labus']['redmine-nginx'].to_hash

if redmine_nginx_vars['listen_https'].nil?
  redmine_nginx_vars['https'] = node['labus']['labus-redmine']['labus_redmine_https']
else
  redmine_nginx_vars['https'] = redmine_nginx_vars['listen_https']
end

template nginx_redmine_http_conf do
  source "nginx-redmine-http.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(redmine_nginx_vars.merge(
    {
      :fqdn => node['labus']['labus-redmine']['labus_redmine_host'],
      :socket => node['labus']['redmine-unicorn']['socket']
    }
  ))
  notifies :restart, 'service[nginx]' if OmnibusHelper.should_notify?("nginx")
  action nginx_redmine_enabled ? :create : :delete
end

account_nginx_vars = node['labus']['account-nginx'].to_hash

if account_nginx_vars['listen_https'].nil?
  account_nginx_vars['https'] = node['labus']['labus-account']['labus_account_https']
else
  account_nginx_vars['https'] = account_nginx_vars['listen_https']
end

#todo: make this template notified by the template below
template File.join(nginx_conf_dir, "fastcgi_params") do
  source "nginx-fastcgi_params.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

#for testing create file /var/opt/labus/labus-account/www/index.php
#<?php
# 
#phpinfo();

template nginx_account_http_conf do
  source "nginx-account-http.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(account_nginx_vars.merge(
    {
      :fqdn => node['labus']['labus-account']['labus_account_host'],
      :socket => node['labus']['labus-account']['socket']
    }
  ))
  notifies :restart, 'service[nginx]' if OmnibusHelper.should_notify?("nginx")
  action nginx_account_enabled ? :create : :delete
end

#####
indico_nginx_vars = node['labus']['indico-nginx'].to_hash

if indico_nginx_vars['listen_https'].nil?
  indico_nginx_vars['https'] = node['labus']['labus-indico']['labus_indico_https']
else
  indico_nginx_vars['https'] = indico_nginx_vars['listen_https']
end

#todo: make this template notified by the template below
template File.join(nginx_conf_dir, "uwsgi_params") do
  source "nginx-uwsgi_params.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

template nginx_indico_http_conf do
  source "nginx-indico-http.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(account_nginx_vars.merge(
    {
      :fqdn => node['labus']['labus-indico']['labus_indico_host'],
      :socket => node['labus']['labus-indico']['socket']
    }
  ))
  notifies :restart, 'service[nginx]' if OmnibusHelper.should_notify?("nginx")
  action nginx_indico_enabled ? :create : :delete
end
#####

template nginx_config do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables nginx_vars
  notifies :restart, 'service[nginx]' if OmnibusHelper.should_notify?("nginx")
end

runit_service "nginx" do
  down node['labus']['nginx']['ha']
  options({
    :log_directory => nginx_log_dir
  }.merge(params))
  log_options node['labus']['logging'].to_hash.merge(node['labus']['nginx'].to_hash)
end

if node['labus']['bootstrap']['enable']
  execute "/opt/gitlab/bin/gitlab-ctl start nginx" do
    retries 20
  end
end
