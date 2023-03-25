Vagrant.configure("2") do |config|

  # Definition du tableau de machines
  machines = [
    { name: "panel", ip: "192.168.50.10", cpus: 1, memory: 1024},
    { name: "kvm-1", ip: "192.168.50.21", cpus: 1, memory: 1024},
    { name: "kvm-2", ip: "192.168.50.22", cpus: 1, memory: 1024},
    { name: "storage-1", ip: "192.168.50.31", cpus: 1, memory: 256},
    { name: "storage-2", ip: "192.168.50.32", cpus: 1, memory: 256}
  ]

  # Configuration de chaque machine dans le tableau
  machines.each do |machine|

    config.vm.define machine[:name] do |node|
      
      # Configuration de la machine
      node.vm.box = "ubuntu/focal64"
      node.vm.hostname = machine[:name]
      node.vm.network "private_network", ip: machine[:ip]

      # Configuration du CPU, de la RAM et du disque dur
      node.vm.provider "virtualbox" do |vb|
        vb.memory = machine[:memory]
        vb.cpus = machine[:cpus]
      end

      if machine[:name] == "panel" || machine[:name] == "kvm-1" || machine[:name] == "kvm-2" || machine[:name] == "storage-1" || machine[:name] == "storage-2"
        node.vm.provision "shell", path: "scripts/disable_ipv6.sh"
      end

      if machine[:name] == "panel" || machine[:name] == "kvm-1" || machine[:name] == "kvm-2"
        node.vm.provision "shell", path: "scripts/enable_opennebula_repo.sh"
      end

      if machine[:name] == "panel"
        node.vm.provision "shell", path: "scripts/install_frontend_opennebula.sh"
#
      end

    end
  end

end
