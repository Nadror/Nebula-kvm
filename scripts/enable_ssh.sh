#!/bin/bash
YELLOW='\033[0;33m'
NC='\033[0m' # reset
RED='\033[0;31m'

echo -e "⌛${YELLOW}enable_ssh.sh ${NC}"

function check_return_code() {
    if [ $? -eq 0 ]; then
        echo -e "✔️ ${YELLOW} $1 ${NC}"
    else
        echo -e "❌ ${YELLOW} $1 ${NC}"
    fi
}

# Vérifier si le fichier de configuration SSH existe
if [ -f /etc/ssh/sshd_config ]; then
    sudo sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart sshd.service
fi

check_return_code "SSH Server Setup"
