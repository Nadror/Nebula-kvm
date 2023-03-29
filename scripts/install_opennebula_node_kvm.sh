#!/bin/bash
YELLOW='\033[0;33m'
NC='\033[0m' # reset
RED_LIGHT='\033[101m'

echo -e "⌛${YELLOW}install_opennebula_node_kvm.sh ${NC}"


function check_return_code() {
    if [ $? -eq 0 ]; then
        echo -e "✔️ ${YELLOW} $1 ${NC}"
    else
        echo -e "❌ ${YELLOW} $1 ${NC}"
    fi
}

# Vérifier si le paquet opennebula-node-kvm est déjà installé
if ! dpkg -s opennebula-node-kvm &> /dev/null
then
    # Mettre à jour les paquets et installer opennebula-node-kvm si nécessaire
    sudo apt update -y
    sudo apt install opennebula-node-kvm -y
    echo "oneadmin:!Passe123?" | sudo chpasswd
fi

check_return_code "Install OpenNebula-kvm-node"

# Modifier le fichier de configuration libvirtd.conf si nécessaire
if ! grep -q 'unix_sock_group = "oneadmin"' /etc/libvirt/libvirtd.conf || ! grep -q 'unix_sock_rw_perms = "0777"' /etc/libvirt/libvirtd.conf
then
    sudo sed -i 's/unix_sock_group = "libvirt"/unix_sock_group = "oneadmin"/g' /etc/libvirt/libvirtd.conf
    sudo sed -i 's/unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0777"/g' /etc/libvirt/libvirtd.conf
    sudo systemctl restart libvirtd.service
fi

check_return_code "Libvirt configuration"