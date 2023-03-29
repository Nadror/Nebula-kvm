#!/bin/bash
YELLOW='\033[0;33m'
NC='\033[0m' # reset
RED='\033[0;31m'

echo -e "⌛${YELLOW}install_frontend_opennebula.sh ${NC}"

function check_return_code() {
    if [ $? -eq 0 ]; then
        echo -e "✔️ ${YELLOW} $1 ${NC}"
    else
        echo -e "❌ ${YELLOW} $1 ${NC}"
    fi
}


# Installation d'OpenNebula et des dépendances
if ! dpkg -s opennebula > /dev/null 2>&1; then
    apt update
    apt install -y opennebula opennebula-sunstone opennebula-gate opennebula-flow
    yes | sudo /usr/share/one/install_gems 
fi
check_return_code "Install OpenNebula-frontend"

# Configuration de l'authentification
if ! grep -q "^oneadmin:!Passe123\?$" /var/lib/one/.one/one_auth; then
    echo "oneadmin:!Passe123?" > /var/lib/one/.one/one_auth
    echo "oneadmin:!Passe123?" | sudo chpasswd
fi

check_return_code "oneadmin password initialization"

# Démarrage et activation des services

sudo systemctl start opennebula opennebula-sunstone && sudo systemctl enable opennebula opennebula-sunstone

check_return_code "Enabling and starting OpenNebula services"
