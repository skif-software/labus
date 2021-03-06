#
# Copyright 2015 SKIF Software, Inc.
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
name "libmcrypt"
default_version "2.5.8"

version("2.5.8") { source md5: "0821830d930a86a5c69110837c55b7da" }

source url: "http://uiip.grid.basnet.by/pub/soft/mcrypt/libmcrypt-#{version}.tar.gz"

relative_path "libmcrypt-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --disable-posix-threads", env: env
  make "-j #{workers}", env: env
  make "install", env: env
end

