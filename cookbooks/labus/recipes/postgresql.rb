#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# Copyright:: Copyright (c) 2014 GitLab.com
# Copyright:: Copyright (c) 2015 SKIF-Software Inc.
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

# This file is a modified version of postgresql.rb recipe file from omnibus-gitlab

postgresql_dir = node['labus']['postgresql']['dir']
postgresql_data_dir = node['labus']['postgresql']['data_dir']
postgresql_data_dir_symlink = File.join(postgresql_dir, "data")
postgresql_log_dir = node['labus']['postgresql']['log_directory']
postgresql_user = node['labus']['postgresql']['username']

group postgresql_user do
  gid node['labus']['postgresql']['gid']
  system true
end

user postgresql_user do
  uid  node['labus']['postgresql']['uid']
  gid postgresql_user
  system true
  shell node['labus']['postgresql']['shell']
  home node['labus']['postgresql']['home']
end

[
  postgresql_dir,
  postgresql_data_dir,
  postgresql_log_dir
].each do |dir|
  directory dir do
    owner node['labus']['postgresql']['username']
    mode "0700"
    recursive true
  end
end

link postgresql_data_dir_symlink do
  to postgresql_data_dir
  not_if { postgresql_data_dir == postgresql_data_dir_symlink }
end

file File.join(node['labus']['postgresql']['home'], ".profile") do
  owner node['labus']['postgresql']['username']
  mode "0644"
  content <<-EOH
PATH=#{node['labus']['postgresql']['user_path']}
EOH
end

if File.directory?("/etc/sysctl.d") && File.exists?("/etc/init.d/procps")
  # smells like ubuntu...
  service "procps" do
    action :nothing
  end

  template "/etc/sysctl.d/90-postgresql.conf" do
    source "90-postgresql.conf.sysctl.erb"
    owner "root"
    mode  "0644"
    variables(node['labus']['postgresql'].to_hash)
    notifies :start, 'service[procps]', :immediately
  end
else
  # hope this works...
  execute "sysctl" do
    command "/sbin/sysctl -p /etc/sysctl.conf"
    action :nothing
  end

  bash "add shm settings" do
    user "root"
    code <<-EOF
      echo 'kernel.shmmax = #{node['labus']['postgresql']['shmmax']}' >> /etc/sysctl.conf
      echo 'kernel.shmall = #{node['labus']['postgresql']['shmall']}' >> /etc/sysctl.conf
    EOF
    notifies :run, 'execute[sysctl]', :immediately
    not_if "egrep '^kernel.shmmax = ' /etc/sysctl.conf"
  end
end

execute "/opt/gitlab/embedded/bin/initdb -D #{postgresql_data_dir} -E UTF8" do
  user node['labus']['postgresql']['username']
  not_if { File.exists?(File.join(postgresql_data_dir, "PG_VERSION")) }
end

postgresql_config = File.join(postgresql_data_dir, "postgresql.conf")

template postgresql_config do
  source "postgresql.conf.erb"
  owner node['labus']['postgresql']['username']
  mode "0644"
  variables(node['labus']['postgresql'].to_hash)
  notifies :restart, 'service[postgresql]', :immediately if OmnibusHelper.should_notify?("postgresql")
end

pg_hba_config = File.join(postgresql_data_dir, "pg_hba.conf")

template pg_hba_config do
  source "pg_hba.conf.erb"
  owner node['labus']['postgresql']['username']
  mode "0644"
  variables(node['labus']['postgresql'].to_hash)
  notifies :restart, 'service[postgresql]', :immediately if OmnibusHelper.should_notify?("postgresql")
end

template File.join(postgresql_data_dir, "pg_ident.conf") do
  owner node['labus']['postgresql']['username']
  mode "0644"
  variables(node['labus']['postgresql'].to_hash)
  notifies :restart, 'service[postgresql]' if OmnibusHelper.should_notify?("postgresql")
end

should_notify = OmnibusHelper.should_notify?("postgresql")

runit_service "postgresql" do
  down node['labus']['postgresql']['ha']
  control(['t'])
  options({
    :log_directory => postgresql_log_dir
  }.merge(params))
  log_options node['labus']['logging'].to_hash.merge(node['labus']['postgresql'].to_hash)
end

if node['labus']['bootstrap']['enable']
  execute "/opt/gitlab/bin/gitlab-ctl start postgresql" do
    retries 20
  end
end

###
# Create the database, migrate it, and create the users we need, and grant them
# privileges.
###
pg_helper = PgHelper.new(node)
pg_port = node['labus']['postgresql']['port']
pg_user = node['labus']['postgresql']['username']
bin_dir = "/opt/gitlab/embedded/bin"
gitlab_database_name = node['gitlab']['gitlab-rails']['db_database']
ci_database_name = node['gitlab']['gitlab-ci']['db_database']
redmine_database_name = node['labus']['labus-redmine']['db_database']
indico_database_name = node['labus']['labus-indico']['db_database']

databases = []
if node['labus']['labus-gitlab']['enable']
  databases << ['gitlab-rails', gitlab_database_name, node['labus']['postgresql']['sql_gitlab_user']]
end

if node['labus']['labus-ci']['enable']
  databases << ['gitlab-ci', ci_database_name, node['labus']['postgresql']['sql_ci_user']]
end

if node['labus']['labus-redmine']['enable']
  databases << ['labus-redmine', redmine_database_name, node['labus']['postgresql']['sql_redmine_user']]
end

if node['labus']['labus-indico']['enable']
  databases << ['labus-indico', indico_database_name, node['labus']['postgresql']['sql_indico_user']]
end

user_exists = pg_helper.user_exists?("gitlab")

databases.each do |labus_app, db_name, sql_user|
  execute "create #{sql_user} database user" do
    command "#{bin_dir}/psql --port #{pg_port} -d template1 -c \"CREATE USER #{sql_user}\""
    user pg_user
    not_if { !pg_helper.is_running? || pg_helper.user_exists?(sql_user) }
  end

  execute "create #{db_name} database" do
    command "#{bin_dir}/createdb --port #{pg_port} -O #{sql_user} #{db_name}"
    user pg_user
    not_if { !pg_helper.is_running? || pg_helper.database_exists?(db_name) }
    retries 30
    notifies :run, "execute[initialize #{labus_app} database]", :immediately
  end
end
