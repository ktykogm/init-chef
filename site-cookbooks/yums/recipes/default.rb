# Cookbook Name:: yums
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if %w{rhel}.include?(node["platform_family"])
  %w[bind-utils ].each do|pkg|
    package pkg do
      action :install
    end
  end
end
