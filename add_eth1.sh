#!/bin/sh

#### add network adapter

# temp
# sudo ip addr add 192.168.56.80/24 dev eth1
# sudo ip link set dev eth1 up


# permanent
sudo echo #add eth1 on dhcp>> /etc/network/interfaces
sudo echo auto eth1>> /etc/network/interfaces
sudo echo iface eth1 inet dhcp>> /etc/network/interfaces

# auto eth1
# iface eth1 inet static
# address 192.168.56.10
# netmask 255.255.255.0

sudo ifdown eth1 && ifup eth1
