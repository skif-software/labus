name "redmine"
default_version "3.3.1"

dependency "bundler"
dependency "libxml2"
dependency "libxslt"
dependency "postgresql"
dependency "redmine-ldap-sync-plugin"

version("2.6.5") { source md5: "86128cb98756246df19dd7ea145255b1" }
version("3.0.3") { source md5: "493463eff3ba9267233648536c59eb85" }
version("3.1.0") { source md5: "f322fc39d385609f842188068fdcf541" }
version("3.3.1") { source md5: "cb8aab3e03cae7d21d003a307e51c176" }

source url: "http://www.redmine.org/releases/redmine-#{version}.tar.gz"
#source url: "http://uiip.grid.basnet.by/pub/soft/redmine/redmine-#{version}.tar.gz"

relative_path "redmine-#{version}"

redmine_source_dir = "#{Omnibus::Config.source_dir}/#{relative_path}"
cookbooks_dir = File.expand_path("cookbooks/#{name}", "#{Omnibus::Config.project_root}")

build do
  copy 'config/database.yml.example', 'config/database.yml'
  command %[sed -i \"s/mysql2/postgresql/g\" config/database.yml]
  command %[echo '## Application server' >> Gemfile.local; \
            echo 'group :unicorn do' >> Gemfile.local; \
            echo '  gem "unicorn", "~> 4.6.3"' >> Gemfile.local; \
            echo '  gem "unicorn-worker-killer"' >> Gemfile.local; \
            echo 'end' >> Gemfile.local]
  env = with_standard_compiler_flags(with_embedded_path)
#  gem "update bundler", env: env
#  bundle "install --without development test rmagick", env: env

# install plugins
  redmine_ldap_sync_source_dir = "#{Omnibus::Config.source_dir}/redmine_ldap_sync"
  command "#{install_dir}/embedded/bin/rsync -a --delete --exclude=.git/*** --exclude=.gitignore #{redmine_ldap_sync_source_dir} #{redmine_source_dir}/plugins/"

  bundle_without = %w{development test rmagick}
  bundle "install --without #{bundle_without.join(" ")} --path=#{install_dir}/embedded/service/gem --jobs #{workers}", :env => env

  command 'rm -rf log'
  command 'rm -rf tmp'
  command 'rm -rf files'
  command 'rm -rf public/plugin_assets'
  command "rm -rf #{install_dir}/embedded/service/labus-redmine"
  mkdir "#{install_dir}/embedded/service/labus-redmine"
  command "#{install_dir}/embedded/bin/rsync -a --delete --exclude=.git/*** --exclude=.gitignore ./ #{install_dir}/embedded/service/labus-redmine/"
#  command "echo '7.11.0' > #{install_dir}/embedded/service/gitlab-ci/VERSION"

  # Create a wrapper for the rake tasks of the Rails app
  erb :dest => "#{install_dir}/bin/labus-redmine-rake",
    :source => "bundle_exec_wrapper.erb",
    :mode => 0755,
    :vars => {:command => 'rake "$@"', :install_dir => install_dir}

  # Create a wrapper for the rails command, useful for e.g. `rails console`
  erb :dest => "#{install_dir}/bin/labus-redmine-rails",
    :source => "bundle_exec_wrapper.erb",
    :mode => 0755,
    :vars => {:command => 'rails "$@"', :install_dir => install_dir}

end
