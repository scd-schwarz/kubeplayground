  # -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

ip_offset = 10
current_dir = File.dirname(File.expand_path(__FILE__))
vconf = YAML.load_file("#{current_dir}/vconf.yml")

Vagrant.configure("2") do |config|
  config.vm.box_check_update = "false"

  config.vm.define "kube-master" do |master|
    master.vm.provider "virtualbox" do |vb|
      vb.memory = vconf['master_memory']
      vb.cpus = 2
    end

    master.vm.box = "ubuntu/jammy64"
    master.vm.hostname = "kube-master"
    master.vm.network "private_network", ip: "192.168.56.#{ip_offset}"

  end


  (1..vconf['workers']).each do |i|

    ip_end = ip_offset + i
    config.vm.define "kube-worker-#{i}" do |worker|
      worker.vm.provider "virtualbox" do |vb|
        vb.memory = vconf['worker_memory']
      end

      worker.vm.box = "ubuntu/jammy64"
      worker.vm.hostname = "kube-worker-#{i}"
      worker.vm.network "private_network", ip: "192.168.56.#{ip_end}"
    end
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "site.yml"
    ansible.groups = {
      "control_plane" => ["kube-master"],
      "worker_nodes" => ["kube-worker-[1:#{vconf['workers']}]"],
      "kube_cluster" => ["kube-master", "kube-worker-[1:#{vconf['workers']}]"]
    }
  end

end
