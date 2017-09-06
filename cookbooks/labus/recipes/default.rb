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

directory "/etc/labus" do
  owner "root"
  group "root"
  mode "0775"
  action :nothing
end.run_action(:create)

Labus[:node] = node
if File.exists?("/etc/labus/config.rb")
  Labus.from_file("/etc/labus/config.rb")
end
node.consume_attributes(Labus.generate_config(node['fqdn']))

# salsa: what is this for?
#if File.exists?("/var/opt/labus/bootstrapped")
#	node.set['labus']['bootstrap']['enable'] = false
#end

directory "/var/opt/labus" do
  owner "root"
  group "root"
  mode "0755"
  recursive true
  action :create
end

include_recipe "labus::web-server"

# proceed to Gitlab configuration
#include_recipe "gitlab::default"

# back to Labus specific setup tasks
include_recipe "labus::labus-redmine"
include_recipe "labus::labus-simplesamlphp"
include_recipe "labus::labus-indico"

# salsa: todo
#if node['labus']['labus-ejabber']['enable']
#  include_recipe "gitlab::users"
#  include_recipe "gitlab::gitlab-shell"
#  include_recipe "gitlab::gitlab-rails"
#end

#if node['gitlab']['gitlab-ci']['enable']
#  include_recipe "gitlab::gitlab-ci"
#end

#include_recipe "gitlab::selinux"
#include_recipe "gitlab::cron"

# Create dummy services to receive notifications, in case
# the corresponding service recipe is not loaded below.
[
  "redmine-unicorn",
  "postgresql",
  "php-fpm"
].each do |dummy|
  service dummy do
    supports []
  end
end

#configure gitlab postgresql for labus usage
#????
#include_recipe "labus::postgresql"

# salsa: disable nginx in gitlab
# Configure Services
[
  "redmine-unicorn",
  "postgresql",
  "nginx",
  "ldap",
  "php-fpm"
].each do |service|
  if node["labus"][service]["enable"]
    include_recipe "labus::#{service}"
  else
    include_recipe "labus::#{service}_disable"
  end
end

include_recipe "labus::database_migrations"
