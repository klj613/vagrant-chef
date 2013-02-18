package "php-fpm" do
  action :install
end

service "php-fpm" do
  action :start
end
