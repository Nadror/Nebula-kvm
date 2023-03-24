#!/bin/bash

apt-get update -y

wget -q -O- https://downloads.opennebula.org/repo/repo.key | apt-key add -
echo "deb https://downloads.opennebula.org/repo/6.6/Ubuntu/20.04 stable opennebula" | tee /etc/apt/sources.list.d/opennebula.list

apt-get update 2>&1 | 
sed -ne 's?^.*NO_PUBKEY ??p' |
xargs -r -- sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys

apt-get upgrade -y