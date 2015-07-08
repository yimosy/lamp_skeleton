VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.box = "centos66"
	config.vm.network :private_network, ip: "192.168.14.10"
	config.vm.synced_folder "htdocs", "/var/www/html"
	config.vm.provider :virtualbox do |vb|
		vb.name = "lamp_skeleton"
	end
	config.vm.provision :shell, :path => "provision/base.sh"
	config.vm.provision :shell, :path => "provision/apache.sh"
	config.vm.provision :shell, :path => "provision/mysql.sh"
	config.vm.provision :shell, :path => "provision/php.sh"
end