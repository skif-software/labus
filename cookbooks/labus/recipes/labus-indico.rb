#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
# Copyright:: Copyright (c) 2014 GitLab B.V.
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

# This file is a modified version of labus-redmine.rb recipe file from omnibus-labus

labus_indico_home_dir = node['labus']['labus-indico']['home_dir']
labus_indico_work_dir = node['labus']['labus-indico']['work_dir']
labus_indico_log_dir = node['labus']['labus-indico']['log_dir']
labus_indico_source_dir = File.join(labus_indico_work_dir, "htdocs")
labus_indico_user = node['labus']['labus-indico']['username']

user labus_indico_user do
  system true
  home labus_indico_work_dir
end

%w{db archive tmp cache}.each do |dir_name|
  directory File.join(labus_indico_work_dir, dir_name) do
    owner labus_indico_user
    group labus_indico_user
    mode '0755'
    recursive true
  end
end

directory labus_indico_log_dir do
  owner labus_indico_user
  group labus_indico_user
  mode '0755'
  recursive true
end

directory File.join(labus_indico_home_dir, "etc") do
  owner "root"
  group "root"
  mode '0755'
  recursive true
end

# it turns out that config files should be in virtualenv etc directory
%w{indico logging zdctl zodb}.each do |file_name|
  template File.join(labus_indico_home_dir, "/etc/", "#{file_name}.conf") do
    source "indico.#{file_name}.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(node['labus']['labus-indico'].to_hash)
  end
end

indico_egg_path = "/opt/gitlab/embedded/service/indico/lib/python2.7/site-packages/indico-1.9.7-py2.7.egg"

#execute "copy htdocs" do
#  command "cp -r #{indico_egg_path}/htdocs #{labus_indico_work_dir}/"
#  action :run
#end

# ln -s /opt/gitlab/embedded/service/indico/lib/python2.7/site-packages/indico-1.9.7-py2.7.egg/indico/web/indico.wsgi /var/opt/labus/labus-indico/htdocs/indico.wsgi


%w{maintenance utils}.each do |link_name|
  link File.join(labus_indico_home_dir, "/bin/#{link_name}")  do
    to "#{indico_egg_path}/bin/#{link_name}"
  end
end

labus_indico_zdaemon_log_dir = "#{labus_indico_log_dir}/zdaemon"

directory labus_indico_zdaemon_log_dir do
  owner labus_indico_user
  group labus_indico_user
  mode '0755'
  recursive true
end

runit_service "indico-zdaemon" do
  options({
    :log_directory => labus_indico_zdaemon_log_dir,
    :work_dir => labus_indico_work_dir,
    :home_dir => labus_indico_home_dir,
    :username => labus_indico_user,
  }.merge(params))
  log_options node['labus']['logging'].to_hash.merge(node['labus']['labus-indico'].to_hash)
end
