#!/bin/bash
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}ENABLE SSH CONFIG...${NC}"

apt install sshpass -y
# Vérifier si le fichier de configuration SSH existe
if [ -f /etc/ssh/sshd_config ]; then
    sudo sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart sshd.service
    echo "SERVEUR SSH OK "
else
    echo "Le fichier de configuration SSH (/etc/ssh/sshd_config) n'existe pas."
fi
