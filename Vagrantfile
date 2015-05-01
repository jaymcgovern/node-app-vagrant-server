require 'yaml'

module VagrantPlugins
	module WebServerConfig
		class Config < Vagrant.plugin( 2, :config )
			attr_accessor :guest_port
			attr_accessor :host_port
			attr_accessor :private_ip
			attr_accessor :proxy_port
			attr_accessor :synced_folder

			def initialize
				settings = YAML::load_file( "settings.yml" )

				@guest_port = settings["web"]["guest_port"] ? settings["web"]["guest_port"] : 80
				@host_port = settings["web"]["host_port"] ? settings["web"]["host_port"] : 3100
				@private_ip = settings["web"]["private_ip"] ? settings["web"]["private_ip"] : nil
				@proxy_port = settings["web"]["proxy_port"] ? settings["web"]["proxy_port"] : 3000
				@synced_folder = settings["web"]["synced_folder"] ? settings["web"]["synced_folder"] : "./"
			end
		end

		class Plugin < Vagrant.plugin( "2" )
			name "web config class"
			config "web" do
				require Vagrant.source_root.join( "lib/vagrant/config" )
				Config
			end
		end
	end
end

Vagrant.configure( "2" ) do |config|
	# Tell Vagrant where the VM box is
	config.vm.box_url = "https://dl.dropboxusercontent.com/u/14662951/Vagrant/ubuntu-app-server.box"

	# Set up web server machine
	config.vm.define :web do |web|
		# Tell Vagrant what the box is named
		web.vm.box = "ubuntu-app-server"

		# Set up communication with the VM
		web.vm.network :forwarded_port, guest: config.web.guest_port, host: config.web.host_port, auto_correct: true
		if config.web.private_ip
			web.vm.network :private_network, ip: config.web.private_ip
		end

		# Sync code file to VM
		web.vm.synced_folder config.web.synced_folder, "/var/www", create: true

		# Modify virtualbox VM settings
		web.vm.provider "virtualbox" do |v|
			v.name = "Node App Server"
		end

		# Set up provisioning
		web.vm.provision :shell, :path => "provision/shell/puppet-setup.sh"

		web.vm.provision "puppet" do |puppet|
			puppet.facter = {
				"nginx_proxy_port" => config.web.proxy_port
			}

			puppet.manifests_path = "provision/puppet/manifests"
			puppet.module_path = "provision/puppet/modules"
			puppet.manifest_file = "init.pp"
		end
	end
end