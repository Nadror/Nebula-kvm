#!/bin/bash

# Installation d'OpenNebula et des dépendances
if ! dpkg -s opennebula > /dev/null 2>&1; then
    apt update
    apt install -y opennebula opennebula-sunstone opennebula-gate opennebula-flow
    yes | sudo /usr/share/one/install_gems
fi

# Configuration de l'authentification
if ! grep -q "^oneadmin:!Passe123\?$" /var/lib/one/.one/one_auth; then
    echo "oneadmin:!Passe123?" > /var/lib/one/.one/one_auth
fi

echo "oneadmin:!Passe123?" | sudo chpasswd

# Démarrage et activation des services
sudo systemctl start opennebula opennebula-sunstone
sudo systemctl enable opennebula opennebula-sunstone
