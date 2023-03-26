#!/bin/bash
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}DISABLE IPV6...${NC}"


# Vérifier si IPv6 est déjà désactivé
grep -q -F 'net.ipv6.conf.all.disable_ipv6 = 1' /etc/sysctl.conf
ipv6_disabled=$?

if [[ $ipv6_disabled -eq 0 ]]; then
  echo "IPv6 already disabled. Skipping..."
else
  echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
  echo "Disabling IPv6 on boot..."
  cat >> /etc/sysctl.conf << EOF
  #disable ipv6 on boot
  net.ipv6.conf.all.disable_ipv6 = 1
  net.ipv6.conf.default.disable_ipv6 = 1
  net.ipv6.conf.lo.disable_ipv6 = 1
EOF
fi
