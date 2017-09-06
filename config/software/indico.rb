name "indico"
#default_version "1.2.1rc1"
#default_version "88a55a686fb4e6c3e326cd5f269b2ea147c37adf" # 1.9.4 merged with branch v1.9.3
#default_version "master"


dependency "python"
dependency "setuptools"
dependency "pip"
dependency "libxml2"
dependency "libxslt"
dependency "libffi"
dependency "postgresql"
# additionaly we need libjpeg-dev zlib1g-dev
# these should be installed by apt-get
# later we will install them as dependencies

whitelist_file 'lib'
whitelist_file 'bin'
whitelist_file 'gem'

version("1.2.1rc1") { source md5: "d8fe8f082865958e7fcd845928d141f6" }

#source url: "https://github.com/indico/indico/releases/download/v1.2.1rc1/indico-#{version}-py2.7.egg"
#source url: "https://github.com/indico/indico/archive/v#{version}.zip"
#source :git => "https://github.com/indico/indico.git"

relative_path "indico-#{version}"

SRC_DIR = "#{Omnibus::Config.source_dir}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

#  command "#{install_dir}/embedded/bin/easy_install http://uiip.grid.basnet.by/pub/soft/indico/indico-1.9.6-py2.7.egg", env: env
#  command "#{install_dir}/embedded/bin/pip install uwsgi", env: env

#####
  # dependency nodeenv installed to the main bin because fab under virtualenv cannot find it
#  command "#{install_dir}/embedded/bin/pip install nodeenv", env: env
  command "#{install_dir}/embedded/bin/pip install virtualenv", env: env

  command "rm -rf #{install_dir}/embedded/service/indico"
  command "#{install_dir}/embedded/bin/virtualenv #{install_dir}/embedded/service/indico"

  command "#{install_dir}/embedded/service/indico/bin/easy_install indico", env: env
  command "#{install_dir}/embedded/service/indico/bin/pip install uwsgi", env: env

  command "#{install_dir}/embedded/service/indico/bin/python -c 'import bcrypt'", env: env

#  dev_requirements = "fabric sphinx repoze.sphinx.autointerface pygments sqlparse"
#####
#  dev_requirements = "nodeenv fabric sphinx repoze.sphinx.autointerface pygments sqlparse"
#  command "#{install_dir}/embedded/bin/pip install uwsgi #{dev_requirements} -r ./requirements.txt", env: env
#  command "#{install_dir}/embedded/bin/fab setup_deps", env: env
#  command "#{install_dir}/embedded/bin/python setup.py install", env: env
####

#
#  mkdir "#{install_dir}/embedded/service/redmine-rails"
#  command "#{install_dir}/embedded/bin/rsync -a --delete --exclude=.git/*** --exclude=.gitignore ./ #{install_dir}/embedded/service/indico/"
end
