rpm_url = "http://rpms.famillecollet.com/enterprise/remi-release-6.rpm"
rpm = "remi-release-6.rpm"
key = "http://rpms.famillecollet.com/RPM-GPG-KEY-remi" 
path = "#{Chef::Config[:file_cache_path]}/#{rpm}"

execute "import" do
  command "rpm --import #{key}" 
  action :run
end

remote_file path do
  action :create_if_missing
  source rpm_url
  mode 0755
  backup false
end

package rpm do
  action :install
  source path 
  provider Chef::Provider::Package::Rpm
end

execute "enable" do
  command "yum-config-manager --enable remi"
  action :run
end
