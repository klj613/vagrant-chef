package "nginx" do
  action :install
end

directory "/etc/nginx/conf.d" do
  action :delete
  recursive true
end

directory "/etc/nginx/conf.d" do
  action :create
end

template "/etc/nginx/conf.d/app.conf" do
    source "config.erb"
    mode 0644
    owner "root"
    group "root"
    variables({
      :app => node[:app_path],
      :controller => 'app_dev'
    });
end

service "nginx" do
  action :start
end
