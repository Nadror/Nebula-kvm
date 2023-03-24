#!/bin/bash

apt-get update -y

wget -q -O- https://downloads.opennebula.org/repo/repo.key | apt-key add -
sudo echo "deb https://downloads.opennebula.org/repo/6.6/Ubuntu/20.04 stable opennebula" | tee /etc/apt/sources.list.d/opennebula.list

apt-get update 2>&1 | 
sed -ne 's?^.*NO_PUBKEY ??p' |
xargs -r -- sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys
apt install opennebula-node -y
sed -i 's/unix_sock_group = "libvirt"/unix_sock_group = "oneadmin"/g' /etc/libvirt/libvirtd.conf
sed -i 's/unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0777"/g' /etc/libvirt/libvirtd.conf
systemctl restart libvirtd.service