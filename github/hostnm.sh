#!/bin/sh

# change hostname for security

echo change hostname - start

old_hostnm=ubuntupreseed
new_hostnm=ubuntupreseed

#sudo cp /etc/hostname /etc/hostname.org
#sudo chmod 666 /etc/hostname
#sudo echo ${new_hostnm}>/etc/hostname
#sudo chmod 644 /etc/hostname

sudo sed -i.org 's/${old_hostnm}/${new_hostnm}/g' /etc/hostname

sudo sed -i.org 's/${old_hostnm}/${new_hostnm}/g' /etc/hosts

echo change hostname - end

