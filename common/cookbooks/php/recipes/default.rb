packages = ["php", "php-cli"]

packages.each do |pkg|
  package pkg do
    action :install
  end
end
