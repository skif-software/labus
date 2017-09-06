http://askubuntu.com/questions/470982/how-to-add-a-python-module-to-syspath

export PATH=$PATH:/opt/gitlab/embedded/bin

mkdir -p /run/uwsgi/app/indico
chown -R www-data:gitlab-www /run/uwsgi/app/indico

chmod -R 0766 /opt/gitlab/embedded/lib/python2.7/site-packages/zc.queue-1.3-py2.7.egg/EGG-INFO/
chmod -R 0766 /opt/gitlab/embedded/lib/python2.7/site-packages/bcrypt-1.0.2-py2.7.egg/bcrypt

indico_initial_setup --existing-config=/opt/gitlab/embedded/cookbooks/gitlab/files/default/indico.conf --www-uid=www-data --www-gid=www-data
# www-data should be integer

indico_initial_setup

zdaemon -C /opt/gitlab/embedded/service/indico/etc/zdctl.conf start


uwsgi --ini /opt/gitlab/embedded/cookbooks/gitlab/files/default/indico.ini

uwsgi --ini indico.ini --http :8080


apt-get install build-essential python-dev python-pip libxslt-dev libxml2-dev libffi-dev postgresql postgresql-server-dev-all

easy_install https://github.com/indico/indico/releases/download/v1.2.0/indico-1.2-py2.7.egg

