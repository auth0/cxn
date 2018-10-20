# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
require 'json'

VAGRANTFILE_API_VERSION = '2'.freeze

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = 'cxn'
  config.vm.network :private_network, ip: '192.168.10.200'

  # Set the version of chef to install using the vagrant-omnibus plugin
  # NOTE: You will need to install the vagrant-omnibus plugin:
  #
  #   $ vagrant plugin install vagrant-omnibus
  #
  unless Vagrant.has_plugin?('vagrant-omnibus')
    raise 'vagrant-omnibus is required. Run:

       $ vagrant plugin install vagrant-omnibus'
  end

  config.omnibus.chef_version = 'latest'

  unless Vagrant.has_plugin?('vagrant-berkshelf')
    raise 'vagrant-berkshelf is required. Run:

           $ vagrant plugin install vagrant-berkshelf'
  end

  # Every Vagrant virtual environment requires a box to build off of.
  # If this value is a shorthand to a box in Vagrant Cloud then
  # config.vm.box_url doesn't need to be specified.
  config.vm.box = 'bento/ubuntu-14.04'

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, type: 'dhcp'

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--memory', '2048']
  end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # The path to the Berksfile to use with Vagrant Berkshelf
  config.berkshelf.berksfile_path = './Berksfile'

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  # only when the box is too old.
  # config.vm.provision "shell", inline: 'rm -rf /var/lib/apt/lists/* ; apt-get update'

  cxn_config = JSON.parse(File.read(File.dirname(__FILE__) + '/environments/vagrant.json'))

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      'ohai' => {
        'plugin_path' => '/var/lib/chef/ohai_plugins',
        'plugins' => {}
      },
      'cxn' => cxn_config['cxn']
    }

    chef.add_recipe 'cxn::default'
  end
end
