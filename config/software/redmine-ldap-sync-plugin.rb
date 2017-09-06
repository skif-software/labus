name "redmine-ldap-sync-plugin"
default_version "f831737c23afd557566e57a9670603e1c8cb78e7" #latest commit
#default_version "ba84cac44e3feed6e4f6ed6fc3a062f72e2c206a" #Fix test does not work with dynamic bind setup (#155)

source :git => "https://github.com/thorin/redmine_ldap_sync.git"

relative_path "redmine_ldap_sync"

build do
  command %[echo 'Here we only get the source code of the plugin.']
end
