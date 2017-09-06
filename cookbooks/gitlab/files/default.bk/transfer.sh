#!/bin/bash

# rm -rf /var/opt/gitlab/; rm -rf /var/log/gitlab/; rm -rf /opt/gitlab/

cp database_migrations.rb /opt/gitlab/embedded/cookbooks/gitlab/recipes/database_migrations.rb
rm -rf /opt/gitlab/embedded/service/gitlab-ci
cp -r gitlab-ci /opt/gitlab/embedded/service/ 
cp gitlab-ci.rb /opt/gitlab/embedded/cookbooks/gitlab/recipes/gitlab-ci.rb
cp nginx.conf.erb /opt/gitlab/embedded/cookbooks/gitlab/templates/default/nginx.conf.erb
cp secret_token.erb /opt/gitlab/embedded/cookbooks/gitlab/templates/default/secret_token.erb
