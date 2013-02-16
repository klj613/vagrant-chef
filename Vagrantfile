# -*- mode: ruby -*-
# vi: set ft=ruby :

provision = {
  :cookbooks =>  ["common/cookbooks"],
  :roles => ["common/roles"],
  :recipes => ["recipe[foo]"]
}

boxes = [
  {
    :name => 'foo',
    :ip => '192.168.33.2',
    :box => 'centos63',
    :port_fwd => {
      9908 => 80,
      2201 => 22
    },
    :role => [
      :app
    ]
  },
  {
    :name => 'bar',
    :ip => '192.168.33.3',
    :box => 'centos63',
    :port_fwd => {
      2202 => 22,
      9981 => 3306
    },
    :role => [
      :app
    ]
  }
]

Vagrant::Config.run do |config|
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|

      config.vm.box = opts[:box]
      config.vm.box_url = opts[:box_url] if opts[:box_url]

      opts[:port_fwd].each do |origin, destination|
        config.vm.forward_port destination, origin
      end

      config.vm.boot_mode = opts[:boot_mode] if opts[:boot_mode]
      config.vm.network :hostonly, opts[:ip] if opts[:ip]

      config.vm.provision :chef_solo do |chef|

        chef.cookbooks_path = provision[:cookbooks]
        chef.roles_path = provision[:roles]

        provision[:recipes].each do |recipe|
          chef.add_recipe(recipe)
        end

        opts[:recipes].each do |recipe|
          chef.add_recipe(recipe)
        end if opts[:recipes]

        opts[:role].each do |role|
          chef.add_role(role)
        end
      end

    end
  end
end 
