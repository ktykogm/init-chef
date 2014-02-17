#
# Cookbook Name:: devtools
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

if %w{rhel}.include?(node["platform_family"])

	execute "devtools" do
		user "root"
		command 'yum -y groupinstall "Development Tools"'
		action "run"
	end

	%w{gcc-c++ make zlib tmux vim expect}.each do |pkg|
		package pkg do
			action :install
		end
	end

#	yum_package "hoge" do
#		arch "x86_64"
#	end

end
