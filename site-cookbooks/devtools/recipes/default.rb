#
# Cookbook Name:: devtools
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Common Install
%w[vim expect].each do|pkg|
  package pkg do
    action :install
  end
end

case node["platform_family"]
when "debian"
  # do things on debian-ish platforms (debian, ubuntu, linuxmint)
  %w[devscripts libreadline6-dev libssl-dev git git-core].each do|pkg|
    package pkg do
      action :install
    end
  end
when "rhel"
  # Initial installs.
  #
  # "build-essential" of Chef does not use it.
  # It is because an error occurs.

  %w[gcc-c++ zlib tmux openssl-devel perl-IO-Compress].each do |pkg|
    package pkg do
      action :install
    end
  end

  # do things on RHEL platforms (redhat, centos, scientific, etc)
  execute "devtools" do
    user "root"
    command 'yum -y groupinstall "Development Tools"'
    action "run"
  end
end

