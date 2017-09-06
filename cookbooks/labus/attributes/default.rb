#
# Copyright:: Copyright (c) 2012 Opscode, Inc.
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

# notice: do not use names with dashes "-" in third parameter
#ruby is complaining when we use to_hash

####
# omnibus options
####
default['labus']['bootstrap']['enable'] = true
# salsa: ???
#default['gitlab']['omnibus-gitconfig']['system'] = {
#  "receive" => ["fsckObjects = true"]
# }


default['labus']['labus-gitlab']['enable'] = false
default['labus']['labus-ci']['enable'] = false
default['labus']['labus-ldap']['enable'] = true
default['labus']['labus-account']['enable'] = true
default['labus']['labus-indico']['enable'] = true
default['labus']['labus-redmine']['labus_redmine_host'] = node['fqdn']
default['labus']['labus-gitlab']['labus_gitlab_host'] = "git." + node['fqdn']
default['labus']['labus-ci']['labus_ci_host'] = "ci." + node['fqdn']
default['labus']['labus-ldap']['labus_ldap_host'] = node['fqdn']
default['labus']['labus-account']['labus_account_host'] = "my." + node['fqdn']
default['labus']['labus-indico']['labus_indico_host'] = "org." + node['fqdn']

####
# The Git User that services run as
####
# The username for the chef services user
#default['gitlab']['user']['username'] = "git"
#default['gitlab']['user']['group'] = "git"
#default['gitlab']['user']['uid'] = nil
#default['gitlab']['user']['gid'] = nil
# The shell for the chef services user
#default['gitlab']['user']['shell'] = "/bin/sh"
# The home directory for the chef services user
#default['gitlab']['user']['home'] = "/var/opt/gitlab"

####
# GitLab Rails app
####
#default['gitlab']['gitlab-rails']['enable'] = true
#default['gitlab']['gitlab-rails']['dir'] = "/var/opt/gitlab/gitlab-rails"
#default['gitlab']['gitlab-rails']['log_directory'] = "/var/log/gitlab/gitlab-rails"
#default['gitlab']['gitlab-rails']['environment'] = 'production'
#default['gitlab']['gitlab-rails']['env'] = {
#  'SIDEKIQ_MEMORY_KILLER_MAX_RSS' => '1000000',
  # Path to the Gemfile
  # defaults to /opt/gitlab/embedded/service/gitlab-rails/Gemfile. The install-dir path is set at build time
#  'BUNDLE_GEMFILE' => "#{node['package']['install-dir']}/embedded/service/gitlab-rails/Gemfile",
  # PATH to set on the environment
  # defaults to /opt/gitlab/embedded/bin:/bin:/usr/bin. The install-dir path is set at build time
#  'PATH' => "#{node['package']['install-dir']}/bin:#{node['package']['install-dir']}/embedded/bin:/bin:/usr/bin"
#}

#default['gitlab']['gitlab-rails']['internal_api_url'] = nil
#default['gitlab']['gitlab-rails']['uploads_directory'] = "/var/opt/gitlab/gitlab-rails/uploads"
#default['gitlab']['gitlab-rails']['rate_limit_requests_per_period'] = 10
#default['gitlab']['gitlab-rails']['rate_limit_period'] = 60

#default['gitlab']['gitlab-rails']['gitlab_host'] = node['fqdn']
#default['gitlab']['gitlab-rails']['gitlab_port'] = 80
#default['gitlab']['gitlab-rails']['gitlab_https'] = false
#default['gitlab']['gitlab-rails']['gitlab_ssh_host'] = nil
#default['gitlab']['gitlab-rails']['time_zone'] = nil
#default['gitlab']['gitlab-rails']['gitlab_email_from'] = nil
#default['gitlab']['gitlab-rails']['gitlab_email_display_name'] = nil
#default['gitlab']['gitlab-rails']['gitlab_default_can_create_group'] = nil
#default['gitlab']['gitlab-rails']['gitlab_username_changing_enabled'] = nil
#default['gitlab']['gitlab-rails']['gitlab_default_theme'] = nil
#default['gitlab']['gitlab-rails']['gitlab_restricted_visibility_levels'] = nil
#default['gitlab']['gitlab-rails']['gitlab_default_projects_features_issues'] = nil
#default['gitlab']['gitlab-rails']['gitlab_default_projects_features_merge_requests'] = nil
#default['gitlab']['gitlab-rails']['gitlab_default_projects_features_wiki'] = nil
#default['gitlab']['gitlab-rails']['gitlab_default_projects_features_wall'] = nil
#default['gitlab']['gitlab-rails']['gitlab_default_projects_features_snippets'] = nil
#default['gitlab']['gitlab-rails']['gitlab_default_projects_features_visibility_level'] = nil
#default['gitlab']['gitlab-rails']['gitlab_repository_downloads_path'] = nil
#default['gitlab']['gitlab-rails']['gravatar_plain_url'] = nil
#default['gitlab']['gitlab-rails']['gravatar_ssl_url'] = nil
#default['gitlab']['gitlab-rails']['ldap_enabled'] = false
#default['gitlab']['gitlab-rails']['ldap_servers'] = []

####
# These LDAP settings are deprecated in favor of the new syntax. They are kept here for backwards compatibility.
# Check
# https://gitlab.com/gitlab-org/omnibus-gitlab/blob/935ab9e1700bfe8db6ba084e3687658d8921716f/README.md#setting-up-ldap-sign-in
# for the new syntax.
#default['gitlab']['gitlab-rails']['ldap_host'] = nil
#default['gitlab']['gitlab-rails']['ldap_base'] = nil
#default['gitlab']['gitlab-rails']['ldap_port'] = nil
#default['gitlab']['gitlab-rails']['ldap_uid'] = nil
#default['gitlab']['gitlab-rails']['ldap_method'] = nil
#default['gitlab']['gitlab-rails']['ldap_bind_dn'] = nil
#default['gitlab']['gitlab-rails']['ldap_password'] = nil
#default['gitlab']['gitlab-rails']['ldap_allow_username_or_email_login'] = nil
#default['gitlab']['gitlab-rails']['ldap_user_filter'] = nil
#default['gitlab']['gitlab-rails']['ldap_group_base'] = nil
#default['gitlab']['gitlab-rails']['ldap_admin_group'] = nil
#default['gitlab']['gitlab-rails']['ldap_sync_ssh_keys'] = nil
#default['gitlab']['gitlab-rails']['ldap_sync_time'] = nil
#default['gitlab']['gitlab-rails']['ldap_active_directory'] = nil
####

#default['gitlab']['gitlab-rails']['omniauth_enabled'] = false
#default['gitlab']['gitlab-rails']['omniauth_allow_single_sign_on'] = nil
#default['gitlab']['gitlab-rails']['omniauth_block_auto_created_users'] = nil
#default['gitlab']['gitlab-rails']['omniauth_providers'] = []
#default['gitlab']['gitlab-rails']['bitbucket'] = nil
#default['gitlab']['gitlab-rails']['satellites_path'] = "/var/opt/gitlab/git-data/gitlab-satellites"
#default['gitlab']['gitlab-rails']['satellites_timeout'] = nil
#default['gitlab']['gitlab-rails']['backup_path'] = "/var/opt/gitlab/backups"
#default['gitlab']['gitlab-rails']['backup_keep_time'] = nil
#default['gitlab']['gitlab-rails']['backup_upload_connection'] = nil
#default['gitlab']['gitlab-rails']['backup_upload_remote_directory'] = nil
#default['gitlab']['gitlab-rails']['backup_multipart_chunk_size'] = nil
# Path to the GitLab Shell installation
# defaults to /opt/gitlab/embedded/service/gitlab-shell/. The install-dir path is set at build time
#default['gitlab']['gitlab-rails']['gitlab_shell_path'] = "#{node['package']['install-dir']}/embedded/service/gitlab-shell/"
#default['gitlab']['gitlab-rails']['gitlab_shell_repos_path'] = "/var/opt/gitlab/git-data/repositories"
# Path to the git hooks used by GitLab Shell
# defaults to /opt/gitlab/embedded/service/gitlab-shell/hooks/. The install-dir path is set at build time
#default['gitlab']['gitlab-rails']['gitlab_shell_hooks_path'] = "#{node['package']['install-dir']}/embedded/service/gitlab-shell/hooks/"
#default['gitlab']['gitlab-rails']['gitlab_shell_upload_pack'] = nil
#default['gitlab']['gitlab-rails']['gitlab_shell_receive_pack'] = nil
#default['gitlab']['gitlab-rails']['gitlab_shell_ssh_port'] = nil
# Path to the Git Executable
# defaults to /opt/gitlab/embedded/bin/git. The install-dir path is set at build time
#default['gitlab']['gitlab-rails']['git_bin_path'] = "#{node['package']['install-dir']}/embedded/bin/git"
#default['gitlab']['gitlab-rails']['git_max_size'] = nil
#default['gitlab']['gitlab-rails']['git_timeout'] = nil
#default['gitlab']['gitlab-rails']['extra_google_analytics_id'] = nil
#default['gitlab']['gitlab-rails']['extra_piwik_url'] = nil
#default['gitlab']['gitlab-rails']['extra_piwik_site_id'] = nil
#default['gitlab']['gitlab-rails']['extra_sign_in_text'] = nil
#default['gitlab']['gitlab-rails']['rack_attack_git_basic_auth'] = nil
#
#default['gitlab']['gitlab-rails']['aws_enable'] = false
#default['gitlab']['gitlab-rails']['aws_access_key_id'] = nil
#default['gitlab']['gitlab-rails']['aws_secret_access_key'] = nil
#default['gitlab']['gitlab-rails']['aws_bucket'] = nil
#default['gitlab']['gitlab-rails']['aws_region'] = nil
#
#default['gitlab']['gitlab-rails']['db_adapter'] = "postgresql"
#default['gitlab']['gitlab-rails']['db_encoding'] = "unicode"
#default['gitlab']['gitlab-rails']['db_database'] = "gitlabhq_production"
#default['gitlab']['gitlab-rails']['db_pool'] = 10
#default['gitlab']['gitlab-rails']['db_username'] = "gitlab"
#default['gitlab']['gitlab-rails']['db_password'] = nil
#default['gitlab']['gitlab-rails']['db_host'] = nil
#default['gitlab']['gitlab-rails']['db_port'] = 5432
#default['gitlab']['gitlab-rails']['db_socket'] = nil
#default['gitlab']['gitlab-rails']['db_sslmode'] = nil
#default['gitlab']['gitlab-rails']['db_sslrootcert'] = nil
#
#default['gitlab']['gitlab-rails']['redis_host'] = "127.0.0.1"
#default['gitlab']['gitlab-rails']['redis_port'] = nil
#default['gitlab']['gitlab-rails']['redis_socket'] = "/var/opt/gitlab/redis/redis.socket"
#
#default['gitlab']['gitlab-rails']['smtp_enable'] = false
#default['gitlab']['gitlab-rails']['smtp_address'] = nil
#default['gitlab']['gitlab-rails']['smtp_port'] = nil
#default['gitlab']['gitlab-rails']['smtp_user_name'] = nil
#default['gitlab']['gitlab-rails']['smtp_password'] = nil
#default['gitlab']['gitlab-rails']['smtp_domain'] = nil
#default['gitlab']['gitlab-rails']['smtp_authentication'] = nil
#default['gitlab']['gitlab-rails']['smtp_enable_starttls_auto'] = nil
#default['gitlab']['gitlab-rails']['smtp_tls'] = nil
#default['gitlab']['gitlab-rails']['smtp_openssl_verify_mode'] = nil
#default['gitlab']['gitlab-rails']['smtp_ca_path'] = nil
### Path to the public Certificate Authority file
### defaults to /opt/gitlab/embedded/ssl/certs/cacert.pem. The install-dir path is set at build time
#default['gitlab']['gitlab-rails']['smtp_ca_file'] = "#{node['package']['install-dir']}/embedded/ssl/certs/cacert.pem"
#
#default['gitlab']['gitlab-rails']['webhook_timeout'] = nil
#
#default['gitlab']['gitlab-rails']['initial_root_password'] = nil
#
#####
## Unicorn
#####
default['labus']['redmine-unicorn']['enable'] = true
default['labus']['redmine-unicorn']['ha'] = false
default['labus']['redmine-unicorn']['log_directory'] = "/var/log/labus/unicorn"
default['labus']['redmine-unicorn']['worker_processes'] = node['cpu']['total'].to_i + 1
default['labus']['redmine-unicorn']['listen'] = '127.0.0.1'
default['labus']['redmine-unicorn']['port'] = 8282
default['labus']['redmine-unicorn']['socket'] = '/var/opt/labus/labus-rails/sockets/labus.socket'
## Path to the unicorn server Process ID file
## defaults to /opt/gitlab/var/unicorn/unicorn.pid. The install-dir path is set at build time
default['labus']['redmine-unicorn']['pidfile'] = "#{node['package']['install-dir']}/var/unicorn/unicorn.pid"
default['labus']['redmine-unicorn']['tcp_nopush'] = true
default['labus']['redmine-unicorn']['backlog_socket'] = 1024
default['labus']['redmine-unicorn']['worker_timeout'] = 60
#
#####
## Sidekiq
####
#default['gitlab']['sidekiq']['enable'] = true
#default['gitlab']['sidekiq']['ha'] = false
#default['gitlab']['sidekiq']['log_directory'] = "/var/log/gitlab/sidekiq"
#default['gitlab']['sidekiq']['shutdown_timeout'] = 4
#
#
####
## gitlab-shell
####
#default['gitlab']['gitlab-shell']['log_directory'] = "/var/log/gitlab/gitlab-shell/"
#default['gitlab']['gitlab-shell']['log_level'] = nil
#default['gitlab']['gitlab-shell']['audit_usernames'] = nil
#default['gitlab']['gitlab-shell']['git_data_directory'] = "/var/opt/gitlab/git-data"
#default['gitlab']['gitlab-shell']['http_settings'] = nil
#default['gitlab']['gitlab-shell']['git_annex_enabled'] = nil
#
#
####
# PostgreSQL
####
default['labus']['postgresql']['enable'] = true
default['labus']['postgresql']['ha'] = false
default['labus']['postgresql']['dir'] = "/var/opt/labus/postgresql"
default['labus']['postgresql']['data_dir'] = "/var/opt/labus/postgresql/data"
default['labus']['postgresql']['log_directory'] = "/var/log/labus/postgresql"
default['labus']['postgresql']['username'] = "labus-psql"
default['labus']['postgresql']['uid'] = nil
default['labus']['postgresql']['gid'] = nil
default['labus']['postgresql']['shell'] = "/bin/sh"
default['labus']['postgresql']['home'] = "/var/opt/labus/postgresql"
## Postgres User's Environment Path
# defaults to /opt/gitlab/embedded/bin:/opt/gitlab/bin/$PATH. The install-dir path is set at build time
default['labus']['postgresql']['user_path'] = "#{node['package']['install-dir']}/embedded/bin:#{node['package']['install-dir']}/bin:$PATH"
default['labus']['postgresql']['sql_gitlab_user'] = "gitlab"
default['labus']['postgresql']['sql_ci_user'] = "gitlab_ci"
default['labus']['postgresql']['sql_redmine_user'] = "labus_redmine"
default['labus']['postgresql']['sql_indico_user'] = "labus_indico"
default['labus']['postgresql']['port'] = 5432
#default['labus']['postgresql']['listen_address'] = nil
default['labus']['postgresql']['listen_address'] = "localhost"
default['labus']['postgresql']['max_connections'] = 200
default['labus']['postgresql']['md5_auth_cidr_addresses'] = []
default['labus']['postgresql']['trust_auth_cidr_addresses'] = []
default['labus']['postgresql']['shmmax'] = kernel['machine'] =~ /x86_64/ ? 17179869184 : 4294967295
default['labus']['postgresql']['shmall'] = kernel['machine'] =~ /x86_64/ ? 4194304 : 1048575

# Resolves CHEF-3889
if (node['memory']['total'].to_i / 4) > ((node['labus']['postgresql']['shmmax'].to_i / 1024) - 2097152)
  # guard against setting shared_buffers > shmmax on hosts with installed RAM > 64GB
  # use 2GB less than shmmax as the default for these large memory machines
  default['labus']['postgresql']['shared_buffers'] = "14336MB"
else
  default['labus']['postgresql']['shared_buffers'] = "#{(node['memory']['total'].to_i / 4) / (1024)}MB"
end

default['labus']['postgresql']['work_mem'] = "8MB"
default['labus']['postgresql']['effective_cache_size'] = "#{(node['memory']['total'].to_i / 2) / (1024)}MB"
default['labus']['postgresql']['checkpoint_segments'] = 10
default['labus']['postgresql']['checkpoint_timeout'] = "5min"
default['labus']['postgresql']['checkpoint_completion_target'] = 0.9
default['labus']['postgresql']['checkpoint_warning'] = "30s"


#####
## Redis
#####
#default['gitlab']['redis']['enable'] = true
#default['gitlab']['redis']['ha'] = false
#default['gitlab']['redis']['dir'] = "/var/opt/gitlab/redis"
#default['gitlab']['redis']['log_directory'] = "/var/log/gitlab/redis"
#default['gitlab']['redis']['username'] = "gitlab-redis"
#default['gitlab']['redis']['uid'] = nil
#default['gitlab']['redis']['gid'] = nil
#default['gitlab']['redis']['shell'] = "/bin/nologin"
#default['gitlab']['redis']['home'] = "/var/opt/gitlab/redis"
#default['gitlab']['redis']['bind'] = '127.0.0.1'
#default['gitlab']['redis']['port'] = 0
#default['gitlab']['redis']['unixsocket'] = "/var/opt/gitlab/redis/redis.socket"
#default['gitlab']['redis']['unixsocketperm'] = "777"
#
####
# Web server
####
# Username for the webserver user
default['labus']['web-server']['username'] = 'labus-www'
default['labus']['web-server']['group'] = 'labus-www'
default['labus']['web-server']['uid'] = nil
default['labus']['web-server']['gid'] = nil
default['labus']['web-server']['shell'] = '/bin/false'
default['labus']['web-server']['home'] = '/var/opt/labus/nginx'
# When bundled nginx is disabled we need to add the external webserver user to the LABUS webserver group
default['labus']['web-server']['external_users'] = []

####
## Nginx
####
default['labus']['nginx']['enable'] = true
default['labus']['nginx']['ha'] = false
default['labus']['nginx']['dir'] = "/var/opt/labus/nginx"
default['labus']['nginx']['log_directory'] = "/var/log/labus/nginx"
default['labus']['nginx']['worker_processes'] = node['cpu']['total'].to_i
default['labus']['nginx']['worker_connections'] = 10240
default['labus']['nginx']['sendfile'] = 'on'
default['labus']['nginx']['tcp_nopush'] = 'on'
default['labus']['nginx']['tcp_nodelay'] = 'on'
default['labus']['nginx']['gzip'] = "on"
default['labus']['nginx']['gzip_http_version'] = "1.0"
default['labus']['nginx']['gzip_comp_level'] = "2"
default['labus']['nginx']['gzip_proxied'] = "any"
default['labus']['nginx']['gzip_types'] = [ "text/plain", "text/css", "application/x-javascript", "text/xml", "application/xml", "application/xml+rss", "text/javascript", "application/json" ]
default['labus']['nginx']['keepalive_timeout'] = 65
default['labus']['nginx']['client_max_body_size'] = '250m'
default['labus']['nginx']['cache_max_size'] = '5000m'
default['labus']['nginx']['redirect_http_to_https'] = false
default['labus']['nginx']['redirect_http_to_https_port'] = 80
default['labus']['nginx']['ssl_certificate'] = "/etc/labus/ssl/#{node['fqdn']}.crt"
default['labus']['nginx']['ssl_certificate_key'] = "/etc/labus/ssl/#{node['fqdn']}.key"
default['labus']['nginx']['ssl_ciphers'] = "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES128-SHA256:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-SHA:ECDHE-RSA-DES-CBC3-SHA:AES256-GCM-SHA384:AES128-GCM-SHA256:AES256-SHA256:AES128-SHA256:AES256-SHA:AES128-SHA:DES-CBC3-SHA:!aNULL:!eNULL:!EXPORT:!DES:!MD5:!PSK:!RC4"
default['labus']['nginx']['ssl_prefer_server_ciphers'] = "on"
default['labus']['nginx']['ssl_protocols'] = "TLSv1 TLSv1.1 TLSv1.2" # recommended by https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html & https://cipherli.st/
default['labus']['nginx']['ssl_session_cache'] = "builtin:1000  shared:SSL:10m" # recommended in http://nginx.org/en/docs/http/ngx_http_ssl_module.html
default['labus']['nginx']['ssl_session_timeout'] = "5m" # default according to http://nginx.org/en/docs/http/ngx_http_ssl_module.html
default['labus']['nginx']['ssl_dhparam'] = nil # Path to dhparam.pem
default['labus']['nginx']['listen_addresses'] = ['*']
#default['labus']['nginx']['listen_port'] = nil # override only if you have a reverse proxy
#salsa: we need to overide labus library function parse_nginx_listen_ports
#for now we just set value here
default['labus']['nginx']['listen_port'] = 80
default['labus']['nginx']['listen_https'] = nil # override only if your reverse proxy internally communicates over HTTP
default['labus']['nginx']['custom_gitlab_server_config'] = nil
default['labus']['nginx']['custom_nginx_config'] = nil

#####
### Logging
#####
default['labus']['logging']['svlogd_size'] = 200 * 1024 * 1024 # rotate after 200 MB of log data
default['labus']['logging']['svlogd_num'] = 30 # keep 30 rotated log files
default['labus']['logging']['svlogd_timeout'] = 24 * 60 * 60 # rotate after 24 hours
default['labus']['logging']['svlogd_filter'] = "gzip" # compress logs with gzip
default['labus']['logging']['svlogd_udp'] = nil # transmit log messages via UDP
default['labus']['logging']['svlogd_prefix'] = nil # custom prefix for log messages
default['labus']['logging']['udp_log_shipping_host'] = nil # remote host to ship log messages to via UDP
default['labus']['logging']['udp_log_shipping_port'] = 514 # remote host to ship log messages to via UDP
default['labus']['logging']['logrotate_frequency'] = "daily" # rotate logs daily
default['labus']['logging']['logrotate_size'] = nil # do not rotate by size by default
default['labus']['logging']['logrotate_rotate'] = 30 # keep 30 rotated logs
default['labus']['logging']['logrotate_compress'] = "compress" # see 'man logrotate'
default['labus']['logging']['logrotate_method'] = "copytruncate" # see 'man logrotate'
default['labus']['logging']['logrotate_postrotate'] = nil # no postrotate command by default
#
####
## Remote syslog
####
#default['gitlab']['remote-syslog']['enable'] = false
#default['gitlab']['remote-syslog']['ha'] = false
#default['gitlab']['remote-syslog']['dir'] = "/var/opt/gitlab/remote-syslog"
#default['gitlab']['remote-syslog']['log_directory'] = "/var/log/gitlab/remote-syslog"
#default['gitlab']['remote-syslog']['destination_host'] = "localhost"
#default['gitlab']['remote-syslog']['destination_port'] = 514
#default['gitlab']['remote-syslog']['services'] = %w{redis nginx unicorn gitlab-rails gitlab-shell postgresql sidekiq ci-redis ci-unicorn ci-sidekiq}
#
####
## Logrotate
####
#default['gitlab']['logrotate']['enable'] = true
#default['gitlab']['logrotate']['ha'] = false
#default['gitlab']['logrotate']['dir'] = "/var/opt/gitlab/logrotate"
#default['gitlab']['logrotate']['log_directory'] = "/var/log/gitlab/logrotate"
#default['gitlab']['logrotate']['services'] = %w{nginx unicorn gitlab-rails gitlab-shell gitlab-ci}
#default['gitlab']['logrotate']['pre_sleep'] = 600 # sleep 10 minutes before rotating after start-up
#default['gitlab']['logrotate']['post_sleep'] = 3000 # wait 50 minutes after rotating
#
#####
### High Availability
#####
default['labus']['high-availability']['mountpoint'] = nil
##
#####
## Labus Redmine Rails app
#####
default['labus']['labus-redmine']['enable'] = true
default['labus']['labus-redmine']['dir'] = "/var/opt/labus/labus-redmine"
default['labus']['labus-redmine']['log_directory'] = "/var/log/labus/labus-redmine"
default['labus']['labus-redmine']['environment'] = 'production'
default['labus']['labus-redmine']['env'] = {
  # Path the the GitLab CI Gemfile
  # defaults to /opt/gitlab/embedded/service/gitlab-ci/Gemfile. The install-dir path is set at build time
  'BUNDLE_GEMFILE' => "#{node['package']['install-dir']}/embedded/service/labus-redmine/Gemfile",
  # Path variable set in the environment for the GitLab CI processes
  # defaults to /opt/gitlab/bin:/opt/gitlab/embedded/bin:/bin:/usr/bin. The install-dir path is set at build time
  'PATH' => "#{node['package']['install-dir']}/bin:#{node['package']['install-dir']}/embedded/bin:/bin:/usr/bin"
}
#default['gitlab']['gitlab-ci']['schedule_builds_minute'] = "0"
#
default['labus']['labus-redmine']['username'] = "labus-redmine"
default['labus']['labus-redmine']['uid'] = nil
default['labus']['labus-redmine']['gid'] = nil
default['labus']['labus-redmine']['shell'] = "/bin/false"

## application.yml top-level settings
#default['gitlab']['gitlab-ci']['gitlab_server'] = nil
#
## application.yml, gitlab_ci section
#default['gitlab']['gitlab-ci']['gitlab_ci_host'] = node['fqdn']
#default['gitlab']['gitlab-ci']['gitlab_ci_port'] = 80
default['labus']['labus-redmine']['labus_redmine_https'] = false
#default['gitlab']['gitlab-ci']['gitlab_ci_email_from'] = nil
#default['gitlab']['gitlab-ci']['gitlab_ci_support_email'] = nil
#default['gitlab']['gitlab-ci']['gitlab_ci_all_broken_builds'] = nil
#default['gitlab']['gitlab-ci']['gitlab_ci_add_pusher'] = nil
#
##default['gitlab']['gitlab-ci']['gitlab_ci_add_committer'] = nil # Deprecated, will be removed in the next release
#
## application.yml, gravatar section
#default['gitlab']['gitlab-ci']['gravatar_enabled'] = true
#default['gitlab']['gitlab-ci']['gravatar_plain_url'] = nil
#default['gitlab']['gitlab-ci']['gravatar_ssl_url'] = nil
#
## application.yml, backup section
default['labus']['labus-redmine']['backup_path'] = "/var/opt/labus/backups"
#default['gitlab']['gitlab-ci']['backup_keep_time'] = nil
#default['gitlab']['gitlab-ci']['backup_upload_connection'] = nil
#default['gitlab']['gitlab-ci']['backup_upload_remote_directory'] = nil
#default['gitlab']['gitlab-ci']['backup_multipart_chunk_size'] = nil
#
## database.yml settings
default['labus']['labus-redmine']['db_adapter'] = "postgresql"
default['labus']['labus-redmine']['db_encoding'] = "utf8"
default['labus']['labus-redmine']['db_database'] = "labus_redmine_production"
default['labus']['labus-redmine']['db_pool'] = 10
default['labus']['labus-redmine']['db_username'] = "labus_redmine"
default['labus']['labus-redmine']['db_password'] = nil
default['labus']['labus-redmine']['db_host'] = nil
default['labus']['labus-redmine']['db_port'] = 5432
default['labus']['labus-redmine']['db_socket'] = nil
#
## resque.yml settings
#default['gitlab']['gitlab-ci']['redis_host'] = "127.0.0.1"
#default['gitlab']['gitlab-ci']['redis_port'] = nil
#default['gitlab']['gitlab-ci']['redis_socket'] = "/var/opt/gitlab/ci-redis/redis.socket"
#
## config/initializers/smtp_settings.rb settings
#default['gitlab']['gitlab-ci']['smtp_enable'] = false
#default['gitlab']['gitlab-ci']['smtp_address'] = nil
#default['gitlab']['gitlab-ci']['smtp_port'] = nil
#default['gitlab']['gitlab-ci']['smtp_user_name'] = nil
#default['gitlab']['gitlab-ci']['smtp_password'] = nil
#default['gitlab']['gitlab-ci']['smtp_domain'] = nil
#default['gitlab']['gitlab-ci']['smtp_authentication'] = nil
#default['gitlab']['gitlab-ci']['smtp_enable_starttls_auto'] = nil
#default['gitlab']['gitlab-ci']['smtp_tls'] = nil
#default['gitlab']['gitlab-ci']['smtp_openssl_verify_mode'] = nil
#
#####
## CI Unicorn
#####
#default['gitlab']['ci-unicorn'] = default['gitlab']['unicorn'].dup
#default['gitlab']['ci-unicorn']['enable'] = false
#default['gitlab']['ci-unicorn']['log_directory'] = "/var/log/gitlab/ci-unicorn"
#default['gitlab']['ci-unicorn']['port'] = 8181
#default['gitlab']['ci-unicorn']['socket'] = '/var/opt/gitlab/gitlab-ci/sockets/gitlab.socket'
## Path to the GitLab CI's Unicorn Process ID file
## defaults to /opt/gitlab/var/ci-unicorn/unicorn.pid. The install-dir path is set at build time
#default['gitlab']['ci-unicorn']['pidfile'] = "#{node['package']['install-dir']}/var/ci-unicorn/unicorn.pid"
#
#####
## CI Sidekiq
#####
#default['gitlab']['ci-sidekiq'] = default['gitlab']['sidekiq'].dup
#default['gitlab']['ci-sidekiq']['enable'] = false
#default['gitlab']['ci-sidekiq']['log_directory'] = "/var/log/gitlab/ci-sidekiq"
#
#####
## CI Redis
#####
#default['gitlab']['ci-redis'] = default['gitlab']['redis'].dup
#default['gitlab']['ci-redis']['enable'] = false
#default['gitlab']['ci-redis']['dir'] = "/var/opt/gitlab/ci-redis"
#default['gitlab']['ci-redis']['log_directory'] = "/var/log/gitlab/ci-redis"
#default['gitlab']['ci-redis']['unixsocket'] = "/var/opt/gitlab/ci-redis/redis.socket"
#
####
# CI NGINX
####
default['labus']['ci-nginx'] = default['labus']['nginx'].dup
default['labus']['ci-nginx']['enable'] = true

####
# Redmine NGINX
####
default['labus']['redmine-nginx'] = default['labus']['nginx'].dup
default['labus']['redmine-nginx']['enable'] = true

####
# Gitlab NGINX
####
default['labus']['gitlab-nginx'] = default['labus']['nginx'].dup
default['labus']['gitlab-nginx']['enable'] = true

####
# Labus LDAP
####
default['labus']['ldap']['enable'] = true
default['labus']['ldap']['slapd'] = "/opt/gitlab/embedded/sbin/slapd"
default['labus']['ldap']['slapadd'] = "/opt/gitlab/embedded/sbin/slapadd"
default['labus']['ldap']['log_dir'] = "/var/log/labus/ldap"
default['labus']['ldap']['conf_dir'] = "/var/opt/labus/ldap"
default['labus']['ldap']['database_dir'] = "/var/opt/labus/ldap/openldap-data"
default['labus']['ldap']['etc_dir'] = "/opt/gitlab/embedded/etc/openldap"
# if this is a directory change option from -f to -F in ldap.rb recepie
default['labus']['ldap']['slapd_conf'] = "/var/opt/labus/ldap/slapd.conf"
default['labus']['ldap']['slapd_ldif'] = "/var/opt/labus/ldap/slapd.ldif"
default['labus']['ldap']['slapd_user'] = "labus-ldap"
default['labus']['ldap']['slapd_group'] = "labus-ldap"
default['labus']['ldap']['uid'] = nil
default['labus']['ldap']['gid'] = nil
default['labus']['ldap']['shell'] = "/bin/false"
default['labus']['ldap']['admin'] = "ldap-admin"
default['labus']['ldap']['admin_password'] = "secretpassword"
#?
default['labus']['ldap']['slapd_defaults'] = "/etc/default/slapd"

####
# Labus Account app
####
default['labus']['labus-account']['labus_account_https'] = false
default['labus']['labus-account']['socket'] = "/var/opt/labus/php-fpm/sockets/account.socket"
default['labus']['labus-account']['dir'] = "/var/opt/labus/labus-account"

####
# Account NGINX
####
default['labus']['account-nginx'] = default['labus']['nginx'].dup
default['labus']['account-nginx']['enable'] = true

####
# Labus PHP-FPM
####
default['labus']['php-fpm']['enable'] = true
default['labus']['php-fpm']['executable'] = "/opt/gitlab/embedded/sbin/php-fpm"
default['labus']['php-fpm']['config'] = "/opt/gitlab/embedded/etc/php-fpm.conf"
default['labus']['php-fpm']['dir'] = "/var/opt/labus/php-fpm"
default['labus']['php-fpm']['log_dir'] = "/var/log/labus/php-fpm"
default['labus']['php-fpm']['user'] = "labus-php"
default['labus']['php-fpm']['uid'] = nil
default['labus']['php-fpm']['gid'] = nil
default['labus']['php-fpm']['shell'] = "/bin/false"
default['labus']['php-fpm']['home'] = "/var/opt/labus/php-fpm"
default['labus']['php-fpm']['sockets_dir'] = "/var/opt/labus/php-fpm/sockets"

####
# Labus SimpleSAMLPHP app
####
default['labus']['labus-simplesamlphp']['enable'] = true
default['labus']['labus-simplesamlphp']['dir'] = "/var/opt/labus/labus-simplesamlphp"
default['labus']['labus-simplesamlphp']['log_directory'] = "/var/log/labus/labus-simplesamlphp"
default['labus']['labus-simplesamlphp']['baseurlpath'] = "saml"
#default['labus']['labus-redmine']['environment'] = 'production'
#default['labus']['labus-redmine']['env'] = {
#  # Path the the GitLab CI Gemfile
#  # defaults to /opt/gitlab/embedded/service/gitlab-ci/Gemfile. The install-dir path is set at build time
#  'BUNDLE_GEMFILE' => "#{node['package']['install-dir']}/embedded/service/labus-redmine/Gemfile",
#  # Path variable set in the environment for the GitLab CI processes
#  # defaults to /opt/gitlab/bin:/opt/gitlab/embedded/bin:/bin:/usr/bin. The install-dir path is set at build time
#  'PATH' => "#{node['package']['install-dir']}/bin:#{node['package']['install-dir']}/embedded/bin:/bin:/usr/bin"
#}
##default['gitlab']['gitlab-ci']['schedule_builds_minute'] = "0"
##
#default['labus']['labus-redmine']['username'] = "labus-redmine"
#default['labus']['labus-redmine']['uid'] = nil
#default['labus']['labus-redmine']['gid'] = nil
#default['labus']['labus-redmine']['shell'] = "/bin/false"

####
# Labus Indico app
####
default['labus']['labus-indico']['home_dir'] = "/opt/gitlab/embedded/service/indico"
default['labus']['labus-indico']['source_dir'] = "/opt/gitlab/embedded/service/indico"
default['labus']['labus-indico']['work_dir'] = "/var/opt/labus/labus-indico"
default['labus']['labus-indico']['log_dir'] = "/var/log/labus/labus-indico"
default['labus']['labus-indico']['username'] = "labus-indico"
default['labus']['labus-indico']['socket'] = "/var/opt/labus/labus-indico/indico.socket"
## database settings
default['labus']['labus-indico']['db_adapter'] = "postgresql"
default['labus']['labus-indico']['db_encoding'] = "utf8"
default['labus']['labus-indico']['db_database'] = "labus_indico_production"
default['labus']['labus-indico']['db_pool'] = 10
default['labus']['labus-indico']['db_username'] = "labus_indico"
default['labus']['labus-indico']['db_password'] = nil
default['labus']['labus-indico']['db_host'] = nil
default['labus']['labus-indico']['db_port'] = 5432
default['labus']['labus-indico']['db_socket'] = nil
####
# Indico NGINX
####
default['labus']['indico-nginx'] = default['labus']['nginx'].dup
default['labus']['indico-nginx']['enable'] = true

