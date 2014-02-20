#
# Cookbook Name:: apts
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if node["platform"] == "ubuntu"
  %w[sysstat dstat bind9utils].each do|pkg|
    package pkg do
      action :install
    end
  end
end
