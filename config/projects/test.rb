#
# Copyright 2015 YOUR NAME
#
# All Rights Reserved.
#

name "labus"
friendly_name   "labus"
maintainer "SKIF Software Inc."
homepage "https://grid.basnet.by"

# Defaults to C:/labus on Windows
# and /opt/labus on all other platforms
install_dir "#{default_root}/#{name}"

build_version Omnibus::BuildVersion.semver
build_iteration 1

# Creates required build directories
dependency "preparation"

# copies required cookbooks
dependency "rsync"

# specific deps
#dependency "runit"

# labus dependencies/components
#dependency "chef-gem"

dependency "redmine"
# deps for redmine app in software definition, this is just an override
#override 'libxml2', version: '2.9.2'
#override 'libxml2', source: { md5: '9c0cfef285d5c4a5c80d00904ddab380' }

#dependency "indico"
#dependency "nginx"

# include ctl scripts
#dependency "labus-ctl"

# Version manifest file
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"
