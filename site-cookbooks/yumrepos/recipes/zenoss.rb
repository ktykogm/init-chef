include_recipe "yum"

# add the Zenoss repository
yum_repository 'zenoss' do
  description "Zenoss Stable repo"
  baseurl "http://dev.zenoss.com/yum/stable/"
  gpgkey 'http://dev.zenoss.com/yum/RPM-GPG-KEY-zenoss'
  action :create
end
