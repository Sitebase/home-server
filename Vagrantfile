Vagrant.configure("2") do |config|
	config.vm.box     = "ubuntu_14_04_x64"
	config.vm.box_url = "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"
	config.vm.network :private_network, ip: "192.168.33.12"
	
	config.vm.provision "shell",
    	inline: "apt-get update"

	config.vm.provision "puppet" do |puppet|
		puppet.manifests_path = "puppet/manifests"
		puppet.module_path    = "puppet/modules"
		puppet.manifest_file  = "default.pp"
		puppet.options        = ['--verbose --debug']
	end

end