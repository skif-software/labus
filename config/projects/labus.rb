#
## Copyright:: Copyright (c) 2013, 2014 GitLab.com
## License:: Apache License, Version 2.0
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
##
#

require "#{Omnibus::Config.project_root}/lib/labus/build_iteration"

ee = system("#{Omnibus::Config.project_root}/support/is_gitlab_ee.sh")

if ee
  name "gitlab-ee"
  description "GitLab Enterprise Edition and GitLab CI "\
    "(including NGINX, Postgres, Redis)"
  replace        "gitlab-ce"
  conflict        "gitlab-ce"
else
  name "labus"
  description "GitLab Community Edition and GitLab CI "\
    "(including NGINX, Postgres, Redis)"
  replace        "labus"
  conflict        "labus"
end

maintainer "SKIF-Software Inc."
homepage "https://grid.basnet.by"

# Replace older omnibus-labus packages
replace         "labus"
conflict        "labus"

install_dir     "/opt/labus"
#build_version   Omnibus::BuildVersion.new.semver
build_version   "0.3.0"
build_iteration Labus::BuildIteration.new.build_iteration

#override :ruby, version: '2.2.4',  source: { md5: "9a5e15f9d5255ba37ace18771b0a8dd2" }
override :ruby, version: '2.1.6',  source: { md5: "6e5564364be085c45576787b48eeb75f" }
#override :ruby, version: '2.1.7'
override :rubygems, version: '2.2.5', source: { md5: "7701b5bc348d8da41a511ac012a092a8" }
#override :rubygems, version: 'ccfafdc2c52c5c605ff69ed3a772d83eb19ef55a' # 2.2.5
#override :chef, version: '12.4.0.rc.0'
#override :chef, version: '12.5.0.current.0'
#override :chef, version: '12.6-release'
#override :chef-gem, version: '12.5.1'
override :'omnibus-ctl', version: '0.3.4'
override :zlib, version: '1.2.8'
override :cacerts, version: '2015.10.28', source: { md5: '6f41fb0f0c4b4695c2a6296892278141' }
override :redis, version: '2.8.20', source: { md5: 'a2588909eb497719bbbf664e6364962a' }
override :openssl, version: '1.0.1o', source: { url: 'https://www.openssl.org/source/openssl-1.0.1o.tar.gz', md5: 'af1096f500a612e2e2adacb958d7eab1' }
override :setuptools, version: '17.1.1', source: { md5: '7edec6cc30aca5518fa9bad42ff0179b' }

# Openssh needs to be installed
runtime_dependency "openssh-server"

# creates required build directories
dependency "preparation"
dependency "package-scripts"

dependency "git"
dependency "redis"
dependency "nginx"
dependency "chef-gem"
#dependency "chef"
dependency "remote-syslog" if ee
dependency "logrotate"
dependency "runit"
dependency "nodejs"
#dependency "gitlab-ci"
#dependency "gitlab-rails"
#dependency "gitlab-shell"
#dependency "gitlab-ctl"
dependency "cookbooks"
#dependency "gitlab-selinux"
#dependency "gitlab-scripts"
#dependency "gitlab-config-template"
dependency "ldap"
dependency "redmine"
dependency "indico"
dependency "simplesamlphp"
#dependency "ejabberd"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"

# Our package scripts are generated from .erb files,
# so we will grab them from an excluded folder
package_scripts_path "#{install_dir}/.package_util/package-scripts"
exclude '.package_util'

package_user 'root'
package_group 'root'
