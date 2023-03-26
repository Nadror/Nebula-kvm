#!/bin/bash
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}ENABLE OPENNEBULA KVM NODE...${NC}"

# Vérifier si le paquet opennebula-node-kvm est déjà installé
if ! dpkg -s opennebula-node-kvm &> /dev/null
then
    # Mettre à jour les paquets et installer opennebula-node-kvm si nécessaire
    sudo apt update -y
    sudo apt install opennebula-node-kvm -y
fi

# Modifier le fichier de configuration libvirtd.conf si nécessaire
if ! grep -q 'unix_sock_group = "oneadmin"' /etc/libvirt/libvirtd.conf || ! grep -q 'unix_sock_rw_perms = "0777"' /etc/libvirt/libvirtd.conf
then
    sudo sed -i 's/unix_sock_group = "libvirt"/unix_sock_group = "oneadmin"/g' /etc/libvirt/libvirtd.conf
    sudo sed -i 's/unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0777"/g' /etc/libvirt/libvirtd.conf
    sudo systemctl restart libvirtd.service
fi

echo "oneadmin:!Passe123?" | sudo chpasswd