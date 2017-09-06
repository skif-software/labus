name "simplesamlphp"
default_version "7dd87de192bcc60db880889927e18bd710fe134d" #latest commit tested

dependency "php"

source :git => "https://github.com/simplesamlphp/simplesamlphp.git"

relative_path "simplesamlphp"

build do
  command 'cp -r config-templates/ config/'
  command 'cp -r metadata-templates/ metadata/'
  env = with_standard_compiler_flags(with_embedded_path)
  command "curl -sS https://getcomposer.org/installer | php", env: env
  command "php composer.phar install", env: env
  command "#{install_dir}/embedded/bin/rsync -a --delete --exclude=.git/*** --exclude=.gitignore ./ #{install_dir}/embedded/service/labus-#{name}/"
end
