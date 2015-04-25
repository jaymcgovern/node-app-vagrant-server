Vagrant.configure( "2" ) do |config|
	# Tell Vagrant where the VM is and what it's named
	config.vm.box = "ubuntu-app-server"
	config.vm.box_url = "https://dl.dropboxusercontent.com/u/14662951/Vagrant/ubuntu-app-server.box"

	# Set up communication with the VM
	config.vm.network :forwarded_port, guest: 80, host: 3000, auto_correct: true

	# Sync code file to VM
	config.vm.synced_folder "./", "/var/www", create: true

	# Modify virtualbox VM settings
	config.vm.provider "virtualbox" do |v|
		v.name = "Node App Server"
	end

	# Set up provisioning
	config.vm.provision :shell, :path => "provision/shell/puppet-setup.sh"

	config.vm.provision "puppet" do |puppet|
		puppet.manifests_path = "provision/puppet/manifests"
		puppet.module_path = "provision/puppet/modules"
		puppet.manifest_file = "init.pp"
	end
end