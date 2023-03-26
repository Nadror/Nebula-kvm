#!/bin/bash
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}INSTALL ONEADMIN KEYS...${NC}"

# Se connecter en tant que utilisateur "oneadmin"

ssh-keyscan 192.168.50.10 192.168.50.21 192.168.50.22 >> /var/lib/one/.ssh/known_hosts
sshpass -p '!Passe123?' scp -rp /var/lib/one/.ssh oneadmin@192.168.50.21:/var/lib/one/
#sshpass -p '!Passe123?' scp -rp /var/lib/one/.ssh oneadmin@192.168.50.22:/var/lib/one/
