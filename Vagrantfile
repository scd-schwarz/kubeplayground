# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box_check_update = "false"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  (1..3).each do |id|
    config.vm.define "kube#{id}" do |kube|
      kube.vm.box = "ubuntu/jammy64"
      kube.vm.hostname = "kube#{id}"
      kube.vm.network "private_network", ip: "192.168.56.1#{id}", auto_config:false

      kube.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
      end
    end
  end
end
