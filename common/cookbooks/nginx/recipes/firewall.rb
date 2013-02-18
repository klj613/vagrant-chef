execute "open_port_80" do
  command "iptables -I INPUT -p tcp --dport 80 -j ACCEPT"
  action :run
end

package "iptables" do
  action :reconfig
end
