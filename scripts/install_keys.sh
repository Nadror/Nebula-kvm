#!/bin/bash

# Définir les adresses IP des hôtes
HOSTS="192.168.50.10 192.168.50.21 192.168.50.22"

# Se connecter en tant que utilisateur "oneadmin"
sudo su oneadmin
ssh-keyscan $HOSTS >> /var/lib/one/.ssh/known_hosts
scp -rp /var/lib/one/.ssh 192.168.50.21:/var/lib/one/
scp -rp /var/lib/one/.ssh 192.168.50.22:/var/lib/one/