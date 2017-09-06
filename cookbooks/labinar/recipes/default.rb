#
# Cookbook Name:: labinar
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "language-pack-en" do
  action :install
end

execute "Set locale to LANG=en_US.UTF-8" do
  command "update-locale LANG=en_US.UTF-8"
  action :run
end

# check "cat /etc/default/locale" to return LANG="en_US.UTF-8"
# if you see an additional line LC_ALL=en_US.UTF-8,
# then remove the setting for LC_ALL before continuing.

# check 'uname -m' to return x86_64

# check the version of Ubuntu is Ubuntu 14.04

# cat /etc/lsb-release
#DISTRIB_ID=Ubuntu
#DISTRIB_RELEASE=14.04
#DISTRIB_CODENAME=trusty
#DISTRIB_DESCRIPTION="Ubuntu 14.04.X LTS"

# ensure that you have trusty multiverse in your sources.list
# grep "multiverse" /etc/apt/sources.list

execute "update" do
  command "apt-get update"
  action :run
end

execute "upgrade" do
  command "apt-get -y dist-upgrade"
  action :run
end

package "software-properties-common" do
  action :install
end

execute "add the repository for LibreOffice 4.3" do
  command "add-apt-repository ppa:libreoffice/libreoffice-4-3"
  action :run
end

# give your server access to the BigBlueButton package repository
execute "add the BigBlueButton key" do
  command "wget http://ubuntu.bigbluebutton.org/bigbluebutton.asc -O- | apt-key add -"
  action :run
end

execute "add the BigBlueButton repository URL" do
  command %[echo "deb http://ubuntu.bigbluebutton.org/trusty-090/ bigbluebutton-trusty main" | tee /etc/apt/sources.list.d/bigbluebutton.list]
  action :run
end

execute "update" do
  command "apt-get update"
end

%w{build-essential git-core checkinstall yasm texi2html libvorbis-dev libx11-dev libvpx-dev libxfixes-dev zlib1g-dev pkg-config netcat libncurses5-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

include_recipe 'labinar::ffmpeg'

package 'bigbluebutton' do
  action :install
end

package 'bbb-demo' do
  action :install
end

package 'bbb-check' do
  action :install
end

execute "enable WebRTC audio" do
  user 'root'
  command "bbb-conf --enablewebrtc"
  action :run
end

execute "do a clean restart" do
  user 'root'
  command "bbb-conf --clean"
  action :run
end

execute "ensure BigBlueButton has started cleanly" do
  user 'root'
  command "bbb-conf --check"
  action :run
end
