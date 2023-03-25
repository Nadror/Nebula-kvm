#!/bin/bash

# Vérifier si le fichier de configuration SSH existe
if [ -f /etc/ssh/sshd_config ]; then
    sudo sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    sudo systemctl restart sshd.service
    echo "SERVEUR SSH OK "
else
    echo "Le fichier de configuration SSH (/etc/ssh/sshd_config) n'existe pas."
fi
