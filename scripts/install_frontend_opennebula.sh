#!/bin/bash

apt install opennebula opennebula-sunstone opennebula-gate opennebula-flow -y

yes | /usr/share/one/install_gems

su oneadmin
echo "oneadmin:!Passe123?" > /var/lib/one/.one/one_auth
echo "oneuser:!Passe123" | chpasswd

systemctl start opennebula opennebula-sunstone
systemctl enable opennebula opennebula-sunstone

