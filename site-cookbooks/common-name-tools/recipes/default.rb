#
# Cookbook Name:: common-name-tools
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w[ sysstat dstat ].each do|pkg|
  package pkg do
    action :install
  end
end
