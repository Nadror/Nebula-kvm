#!/bin/bash
sudo apt update -y
sudo apt install opennebula-node-kvm -y
sudo sed -i 's/unix_sock_group = "libvirt"/unix_sock_group = "oneadmin"/g' /etc/libvirt/libvirtd.conf
sudo sed -i 's/unix_sock_rw_perms = "0770"/unix_sock_rw_perms = "0777"/g' /etc/libvirt/libvirtd.conf
sudo systemctl restart libvirtd.service
