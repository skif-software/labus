#
# Cookbook Name:: labinar
# Recipe:: ffmpeg
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash 'get ffmpeg source' do
  user 'root'
  cwd '/usr/local/src'
  code <<-EOH
  wget 'http://ffmpeg.org/releases/ffmpeg-#{node['labinar']['ffmpeg']['version']}.tar.bz2'
  tar -xjf ffmpeg-#{node['labinar']['ffmpeg']['version']}.tar.bz2
  EOH
  creates "/usr/local/src/ffmpeg-#{node['labinar']['ffmpeg']['version']}"
end


bash 'compile and install ffmpeg' do
  user 'root'
  cwd "/usr/local/src/ffmpeg-#{node['labinar']['ffmpeg']['version']}"
  code <<-EOH
  ./configure --enable-version3 --enable-postproc --enable-libvorbis --enable-libvpx
  make
  checkinstall --pkgname=ffmpeg --pkgversion='5:#{node['labinar']['ffmpeg']['version']}' --backup=no --deldoc=yes --default
  EOH
end

execute "check ffmpeg installed" do
  command "ffmpeg -version | grep #{node['labinar']['ffmpeg']['version']}"
  action :run
end

