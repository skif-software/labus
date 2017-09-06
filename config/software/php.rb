#
# Copyright 2014 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
name "php"
default_version "5.6.13"

dependency "zlib"
dependency "pcre"
dependency "libxslt"
dependency "libxml2"
dependency "libiconv"
dependency "openssl"
dependency "libmcrypt"
dependency "ldap"
dependency "postgresql"

version("5.6.13") { source md5: "349f183c0f8e2567772e2eb3dee84504" }

source url: "http://php.net/distributions/php-#{version}.tar.gz"

relative_path "php-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  copy 'php.ini-production', '/opt/gitlab/embedded/etc/php.ini'
  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --with-config-file-path=#{install_dir}/embedded/etc" \
          " --enable-fpm" \
          " --without-pear" \
          " --with-zlib" \
          " --with-zlib-dir=#{install_dir}/embedded" \
          " --enable-zip" \
          " --with-pcre-dir=#{install_dir}/embedded" \
          " --with-xsl=#{install_dir}/embedded" \
          " --with-libxml-dir=#{install_dir}/embedded" \
          " --with-iconv=#{install_dir}/embedded" \
          " --with-openssl=#{install_dir}/embedded" \
          " --with-ldap=#{install_dir}/embedded" \
          " --with-pgsql=#{install_dir}/embedded" \
          " --with-pdo-pgsql=#{install_dir}/embedded" \
          " --with-curl=#{install_dir}/embedded" \
          " --with-mcrypt=#{install_dir}/embedded", env: env

  make "-j #{workers}", env: env
  make "install", env: env
end

