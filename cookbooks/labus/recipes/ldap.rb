#
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

ldap_database_dir = node['labus']['ldap']['database_dir']
ldap_log_dir = node['labus']['ldap']['log_dir']
ldap_conf_dir = node['labus']['ldap']['conf_dir']
ldap_slapd_conf = node['labus']['ldap']['slapd_conf']
ldap_slapd_ldif = node['labus']['ldap']['slapd_ldif']
ldap_slapd_user = node['labus']['ldap']['slapd_user']
ldap_slapd_group = node['labus']['ldap']['slapd_group']
labus_ldap_home_dir = ldap_database_dir
ldap_slapd_options = [
          "-d 3",
          "-f", ldap_slapd_conf,
          "-u", ldap_slapd_user,
          "-g", ldap_slapd_group
        ].join(" ")

group ldap_slapd_group do
  gid node['labus']['ldap']['gid']
  system true
end

user ldap_slapd_user do
  uid node['labus']['ldap']['uid']
  gid ldap_slapd_group
  system true
  shell node['labus']['ldap']['shell']
  home labus_ldap_home_dir
end

[
  ldap_log_dir,
  ldap_conf_dir,
  ldap_database_dir
].each do |dir_name|
  directory dir_name do
    owner ldap_slapd_user
    group ldap_slapd_group
    mode '0750'
    recursive true
  end
end

template ldap_slapd_conf do
  source "slapd.conf.erb"
  owner ldap_slapd_user
  group ldap_slapd_group
  mode "0600"
  action :create
end

# create LDAP database template with Admin account
template ldap_slapd_ldif do
  source "slapd.ldif.erb"
  owner ldap_slapd_user
  group ldap_slapd_group
  mode "0600"
  action :create
  notifies :run, "execute[create LDAP database]", :immediately
end

execute "create LDAP database" do
  command "#{node['labus']['ldap']['slapadd']} -l #{ldap_slapd_ldif} -f #{ldap_slapd_conf}"
  user ldap_slapd_user
  action :nothing
end 

runit_service "ldap" do
  options({
    :log_directory => ldap_log_dir,
    :slapd_options => ldap_slapd_options
  }.merge(params))
  log_options node['labus']['logging'].to_hash.merge(node['labus']['ldap'].to_hash)
end

if node['labus']['bootstrap']['enable']
  execute "/opt/gitlab/bin/gitlab-ctl start ldap" do
    retries 20
  end
end

