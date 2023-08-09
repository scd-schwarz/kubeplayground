# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box_check_update = "false"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  (1..3).each do |id|
    config.vm.define "kube-0#{id}" do |kube|
      kube.vm.box = "ubuntu/jammy64"
      kube.vm.hostname = "kube-0#{id}"
      kube.vm.network "private_network", ip: "192.168.56.1#{id}"

      kube.vm.provision "ansible" do |ansible|
        ansible.playbook = "playbook.yml"
        ansible.groups = {
          "control_plane" => ["kube-01"],
          "worker_nodes" => ["kube-0[2:3]"]
        }
      end
    end
  end
end
