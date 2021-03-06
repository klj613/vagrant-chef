rpm_url = "https://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"
rpm = "epel-release-6-8.noarch"
key = "https://fedoraproject.org/static/0608B895.txt" 
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
