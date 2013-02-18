# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'config'

Vagrant::Config.run do |config|
  @boxes.each do |opts|
    config.vm.define opts[:name] do |config|

      config.vm.box = opts[:box]
      config.vm.box_url = opts[:box_url] if opts[:box_url]

      if opts[:port_fwd]
        opts[:port_fwd].each do |origin, destination|
          config.vm.forward_port destination, origin
        end
      end

      config.vm.boot_mode = opts[:boot_mode] if opts[:boot_mode]
      config.vm.network :hostonly, opts[:ip] if opts[:ip]

      config.vm.provision :chef_solo do |chef|

        chef.cookbooks_path = @provision[:cookbooks] if @provision[:cookbooks]
        chef.roles_path = @provision[:roles] if @provision[:roles]

        if @provision[:recipes]
          @provision[:recipes].each do |recipe|
            chef.add_recipe(recipe)
          end
        end

        if opts[:recipes]
          opts[:recipes].each do |recipe|
            chef.add_recipe(recipe)
          end
        end

        if opts[:role]
          opts[:role].each do |role|
            chef.add_role(role)
          end
        end

        if opts[:directories]
          opts[:directories].each do |dir|
            config.vm.share_folder dir[:name], dir[:guest_path], dir[:host_path], { :create => true }
          end
        end

        chef.json = opts[:node_vars] if opts[:node_vars]

      end

      config.vm.provision :shell, :inline => "yum -y upgrade"
    end
  end
end 
