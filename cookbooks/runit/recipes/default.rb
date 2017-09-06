#
# Cookbook Name:: runit
# Recipe:: default
#
# Copyright 2008-2010, Opscode, Inc.
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

case node["platform_family"]
when "debian"
  case node["platform"]
  when "debian", "raspbian", "devuan"
    if File.exist?("/sbin/init")
       if File.symlink?("/sbin/init")
         if File.basename(File.readlink("/sbin/init")) == "systemd"
           include_recipe "runit::systemd"
         else
           include_recipe "runit::upstart"
         end
       else
         include_recipe "runit::sysvinit"
       end
    else
      if node["platform_version"] =~ /^8/
        include_recipe "runit::systemd"
      else
        include_recipe "runit::sysvinit"
      end
    end
  else
    include_recipe "runit::upstart"
  end
when "rhel"
  case node["platform"]
  when "amazon", "xenserver"
    # TODO: platform_version check for old distro without upstart
    include_recipe "runit::upstart"
  else
    if node['platform_version'] =~ /^5/
      include_recipe "runit::sysvinit"
    elsif node['platform_version'] =~ /^6/
      include_recipe "runit::upstart"
    elsif node['platform_version'] =~ /^7/
      include_recipe "runit::systemd"
    end
  end
when "fedora"
  include_recipe "runit::systemd"
else
  include_recipe "runit::sysvinit"
end
