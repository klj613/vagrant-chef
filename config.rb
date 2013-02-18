@provision = {
  :cookbooks =>  ["common/cookbooks"],
  :roles => ["common/roles"],
  :recipes => ["recipe[epel]", "recipe[nginx]", "recipe[nginx::firewall]"]
}

@boxes = [
  {
    :name => 'foo',
    :ip => '192.168.33.2',
    :box => 'centos63',
    :port_fwd => {
      8081 => 80,
      2201 => 22
    },
    :role => [:app],
    :directories => [
      {
        :name => 'source',
        :guest_path => '/opt/klj613/source',
        :host_path => './data/source'
      }
    ],
    :node_vars => {
      :app_path => '/opt/klj613/source'
    }
  }
]
