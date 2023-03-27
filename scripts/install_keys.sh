#!/bin/bash
YELLOW='\033[0;33m'
NC='\033[0m' # reset
RED_LIGHT='\033[101m'

echo -e "${YELLOW}install_keys.sh ${NC}"


function check_return_code() {
    if [ $? -eq 0 ]; then
        echo -e "✔️ ${YELLOW} $1 ${NC}"
    else
        echo -e "❌ ${YELLOW} $1 ${NC}"
    fi
}

if ! grep -q "192.168.50.10\|192.168.50.21\|192.168.50.22" /var/lib/one/.ssh/known_hosts; then 
    ssh-keyscan 192.168.50.10 192.168.50.21 192.168.50.22 >> /var/lib/one/.ssh/known_hosts
fi
check_return_code "Update known_hosts file"

if [ -z "$(ls -A /vagrant/)" ]; then 
    cp -rp /var/lib/one/.ssh/* /vagrant/
fi
check_return_code "Copy SSH files to shared folder"
