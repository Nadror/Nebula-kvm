#!/bin/bash

# Test de présence de la clé
if ! apt-key list | grep -q "OpenNebula"; then
    wget -q -O- https://downloads.opennebula.org/repo/repo.key | apt-key add -
fi

# Test de présence du fichier sources.list.d
if [ ! -f "/etc/apt/sources.list.d/opennebula.list" ]; then
    echo "deb https://downloads.opennebula.org/repo/6.6/Ubuntu/20.04 stable opennebula" | tee /etc/apt/sources.list.d/opennebula.list
    apt-get update 2>&1 | sed -ne 's?^.*NO_PUBKEY ??p' | xargs -r -- sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys
    apt-get update
fi
