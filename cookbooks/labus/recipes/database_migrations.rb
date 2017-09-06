#
# Copyright:: Copyright (c) 2014 GitLab.com
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

initial_root_password = node['gitlab']['gitlab-rails']['initial_root_password']


execute "initialize labus-redmine database" do
  command "/opt/gitlab/bin/labus-redmine-rake redmine:load_default_data; /opt/gitlab/bin/labus-redmine-rake db:migrate"
  environment 'RAILS_ENV' => 'production'
  notifies :run, "execute[initialize labus-redmine-ldap-sync-plugin database]", :immediately
  action :nothing
end

execute "initialize labus-redmine-ldap-sync-plugin database" do
  command "/opt/gitlab/bin/labus-redmine-rake redmine:plugins:migrate; /opt/gitlab/bin/labus-redmine-rake -T redmine:plugins:ldap_sync"
  environment 'RAILS_ENV' => 'production'
  action :nothing
end

execute "initialize labus-indico database" do
  command "echo passing"
  environment 'RAILS_ENV' => 'production'
  action :nothing
end

#  execute "create labus-redmine database structure" do
#    command "/opt/gitlab/bin/labus-redmine-rake db:migrate"
#    environment 'RAILS_ENV' => 'production'
#    action :run
#  end


#execute "initialize gitlab-rails database" do
#  command "/opt/gitlab/bin/gitlab-rake db:schema:load db:seed_fu"
#  environment ({'GITLAB_ROOT_PASSWORD' => initial_root_password }) if initial_root_password
#  action :nothing
#end

#execute "initialize gitlab-ci database" do
#  #command "/opt/gitlab/bin/gitlab-ci-rake setup"
#  command "echo 'pass'"
#  action :nothing
#end

#salsa: this is only used when the rails app version is changed
#
#migrate_database 'gitlab-rails' do
#  command '/opt/gitlab/bin/gitlab-rake db:migrate'
#  action :nothing
#end

#migrate_database 'gitlab-ci' do
#  command '/opt/gitlab/bin/gitlab-ci-rake db:migrate'
#  migrate_database 'gitlab-ci' do
#    command '/opt/gitlab/bin/gitlab-ci-rake redmine:load_default_data'
#    action :run
#  end
#  action :nothing
#end
