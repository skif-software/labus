name "ldap"
default_version "2.4.42"

dependency "openssl"

#dependency "libxml2"
#dependency "libxslt"
#dependency "postgresql"

version("2.4.42") { source md5: "47c8e2f283647a6105b8b0325257e922" }

source url: "http://uiip.grid.basnet.by/pub/soft/openldap/openldap-#{version}.tgz"
#source url: "ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/openldap-#{version}.tgz"

relative_path "openldap-#{version}"

chef_dir = "#{Omnibus::Config.project_root}/#{Omnibus::Config.source_dir}"
cookbooks_dir = File.expand_path("cookbooks/#{name}", "#{Omnibus::Config.project_root}")

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --localstatedir=/var/opt/labus/ldap" \
          " --libexecdir=#{install_dir}/embedded/sbin" \
          " --sysconfdir=#{install_dir}/embedded/etc" \
          " --enable-bdb=no " \
          " --enable-hdb=no " \
          " --enable-mdb ", :env => env

  make "depend", :env => env
  make "-j #{workers}", :env => env
#  make "test", :env => env
  make "install", :env => env
end
