Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2004"
  config.vm.box_version = "3.1.16"
  config.ssh.username = 'vagrant'
  config.ssh.password = 'vagrant'
  config.vm.network "forwarded_port", guest: 21, host:2121

  config.omnibus.chef_version = :latest

  if Vagrant.has_plugin?("vagrant-vbguest") then
    config.vbguest.auto_update = false
  end

  config.vm.provider "virtualbox" do |v|
    v.name = "explore_kind_argo"
    v.customize ["modifyvm", :id, "--memory", "4096"]
  end

  config.vm.network "forwarded_port", guest: 443, host: 8443, protocol: "tcp"

  config.vm.provision "chef_solo" do |chef|
    chef.install = false
    chef.arguments = "--chef-license accept"
    chef.cookbooks_path = ['.']
    chef.add_recipe "bootstrap"
  end
end
