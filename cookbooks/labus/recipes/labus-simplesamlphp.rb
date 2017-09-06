#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# Copyright:: Copyright (c) 2014 GitLab B.V.
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

# This file is a modified version of labus-redmine.rb recipe file from omnibus-labus

######## for labus-account recepie ############
labus_account_dir = node['labus']['labus-account']['dir']
labus_account_www_dir = File.join(labus_account_dir, "www")

directory labus_account_www_dir do
  owner node['labus']['web-server']['username']
  group node['labus']['php-fpm']['user']
  mode '0750'
  recursive true
end

cookbook_file File.join(labus_account_www_dir, "favicon.ico") do
  source 'uiip-favicon.ico'
  owner node['labus']['web-server']['username']
  group node['labus']['php-fpm']['user']
  mode '0750'
  action :create
end

cookbook_file File.join(labus_account_www_dir, "index.html") do
  source 'account-index.html'
  owner node['labus']['web-server']['username']
  group node['labus']['php-fpm']['user']
  mode '0750'
  action :create
end

###############################################

labus_simplesamlphp_source_dir = "/opt/gitlab/embedded/service/labus-simplesamlphp"
labus_simplesamlphp_dir = node['labus']['labus-simplesamlphp']['dir']
labus_simplesamlphp_home_dir = File.join(labus_simplesamlphp_dir, "home")
labus_simplesamlphp_etc_dir = File.join(labus_simplesamlphp_dir, "etc")
labus_simplesamlphp_static_etc_dir = "/opt/gitlab/etc/labus-simplesamlphp"
labus_simplesamlphp_working_dir = File.join(labus_simplesamlphp_dir, "working")
labus_simplesamlphp_tmp_dir = File.join(labus_simplesamlphp_dir, "tmp")
labus_simplesamlphp_log_dir = node['labus']['labus-simplesamlphp']['log_directory']
labus_simplesamlphp_baseurlpath = node['labus']['labus-simplesamlphp']['baseurlpath']
labus_account_simplesamlphp_dir = File.join(labus_account_www_dir, labus_simplesamlphp_baseurlpath)
labus_simplesamlphp_source_www_dir = "/opt/gitlab/embedded/service/labus-simplesamlphp/www"
labus_simplesamlphp_source_dir = "/opt/gitlab/embedded/service/labus-simplesamlphp"

{
  labus_account_simplesamlphp_dir => labus_simplesamlphp_source_www_dir
}.each do |link_dir, target_dir|
  link link_dir do
    to target_dir
  end
end

template File.join(labus_simplesamlphp_source_dir, "/config/config.php") do
  source "simplesamlphp.config.php.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(node['labus']['labus-simplesamlphp'].to_hash)
end


#labus_redmine_user = node['labus']['labus-redmine']['username']
#labus_app = "labus-redmine"

#group labus_redmine_user do
#  gid node['labus']['labus-redmine']['gid']
#  system true
#end

#user labus_redmine_user do
#  uid node['labus']['labus-redmine']['uid']
#  gid labus_redmine_user
#  system true
#  shell node['labus']['labus-redmine']['shell']
#  home labus_redmine_home_dir
#end
#
#[
#  labus_redmine_etc_dir,
#  labus_redmine_static_etc_dir,
#  labus_redmine_home_dir,
#  labus_redmine_working_dir,
#  node['labus']['labus-redmine']['backup_path'],
#].compact.each do |dir_name|
#  directory dir_name do
#    owner labus_redmine_user
#    mode '0700'
#    recursive true
#  end
#end
#
#directory labus_redmine_dir do
#  owner labus_redmine_user
#  mode '0755'
#  recursive true
#end
#
#[
#  labus_redmine_files_dir,
#  labus_redmine_tmp_dir,
#  labus_redmine_tmp_pdf_dir,
#  labus_redmine_log_dir,
#  labus_redmine_plugin_assets_dir
#].compact.each do |dir_name|
#  directory dir_name do
#    owner labus_redmine_user
#    group labus_redmine_user
#    mode '0755'
#    recursive true
#  end
#end
#
#template File.join(labus_redmine_static_etc_dir, "labus-redmine-rc")
#
#dependent_services = []
#dependent_services << "service[redmine-unicorn]" if OmnibusHelper.should_notify?("redmine-unicorn")
#
#postgresql_not_listening = OmnibusHelper.not_listening?("postgresql")
#
#template_symlink File.join(labus_redmine_etc_dir, "secrets.yml") do
#  link_from File.join(labus_redmine_source_dir, "/config/secrets.yml")
#  source "labus-redmine-secret_token.erb"
#  owner "root"
#  group "root"
#  mode "0644"
#  variables(node['labus']['labus-redmine'].to_hash)
#  restarts dependent_services
#end
#
##template File.join(gitlab_ci_source_dir, "/config/initializers/secret_token.rb") do
##  source "secret_token_old.erb"
##  owner "root"
##  group "root"
##  mode "0644"
##  variables(node['gitlab']['gitlab-ci'].to_hash)
##end
#
#template_symlink File.join(labus_redmine_etc_dir, "database.yml") do
#  link_from File.join(labus_redmine_source_dir, "config/database.yml")
#  source "labus-redmine-database.yml.erb"
#  owner "root"
#  group "root"
#  mode "0644"
#  variables node['labus']['labus-redmine'].to_hash
#  helpers SingleQuoteHelper
#  restarts dependent_services
#end
#
## salsa: do we need this ???????????????
##template_symlink File.join(gitlab_ci_etc_dir, "smtp_settings.rb") do
##  link_from File.join(gitlab_ci_source_dir, "config/initializers/smtp_settings.rb")
##  owner "root"
##  group "root"
##  mode "0644"
##  variables(
##    node['gitlab']['gitlab-ci'].to_hash.merge(
##      :app => gitlab_app
##    )
##  )
##  restarts dependent_services
##
##  unless node['gitlab']['gitlab-ci']['smtp_enable']
##    action :delete
##  end
##end
#
## salsa: this var seems to be a legacy as it is the only one here.
##unicorn_url = "http://#{node['gitlab']['unicorn']['listen']}:#{node['gitlab']['unicorn']['port']}"
#
## salsa: this should be investigated how we create database
##pg_helper = PgHelper.new(node)
##database_ready = pg_helper.is_running? && pg_helper.database_exists?(node['labus']['labus-redmine']['db_database'])
#
## salsa: do we need this ??????????????
#env_dir File.join(labus_redmine_static_etc_dir, 'env') do
#  variables(
#    {
#      'HOME' => labus_redmine_home_dir,
#      'RAILS_ENV' => node['labus']['labus-redmine']['environment'],
#      'REDMINE_LANG' => 'ru',
#    }.merge(node['labus']['labus-redmine']['env'])
#  )
#  restarts dependent_services
#end
#
## salsa: we need to do this by more intlelligent way
## replace empty directories in the Git repo with symlinks to /var/opt/labus
#{
#  "/opt/gitlab/embedded/service/labus-redmine/tmp" => labus_redmine_tmp_dir,
#  "/opt/gitlab/embedded/service/labus-redmine/log" => labus_redmine_log_dir,
#  "/opt/gitlab/embedded/service/labus-redmine/files" => labus_redmine_files_dir,
#  "/opt/gitlab/embedded/service/labus-redmine/public/plugin_assets" => labus_redmine_plugin_assets_dir
#}.each do |link_dir, target_dir|
#  link link_dir do
#    to target_dir
#  end
#end
#
## Create tmp/cache to make 'rake cache:clear' work
#directory File.join(labus_redmine_tmp_dir, 'cache') do
#  user labus_redmine_user
#end
#
## Make schema.rb writable for when we run `rake db:migrate`
#file "/opt/gitlab/embedded/service/labus-redmine/db/schema.rb" do
#  owner labus_redmine_user
#end
#
## salsa: check how we can use this
### Only run `rake db:migrate` when the gitlab-ci version has changed
##remote_file File.join(gitlab_ci_dir, 'VERSION') do
##  source "file:///opt/gitlab/embedded/service/gitlab-ci/VERSION"
##  notifies :run, 'bash[migrate gitlab-ci database]' unless postgresql_not_listening
###  notifies :run, 'execute[clear the gitlab-ci cache]' unless redis_not_listening
##  dependent_services.each do |sv|
##    notifies :restart, sv
##  end
##end
#
## salsa: this was already commented
##execute "clear the gitlab-ci cache" do
##  command "/opt/gitlab/bin/gitlab-ci-rake cache:clear"
##  action :nothing
##end

