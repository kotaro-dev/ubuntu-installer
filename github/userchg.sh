#!/bin/sh

# add new user for change ubuntu operation

echo adduser and del first user - start

new_user=sasaki
new_pswd=sasaki

sudo apt-get install -y whois

sudo useradd -m -s /bin/bash -p `echo ${new_pswd}|mkpasswd -s -m sha-512` -G adm,cdrom,sudo,dip,plugdev,sambashare,lpadmin ${new_user}

#if you used samba
#sudo echo -e "${new_pswd}\n${new_pswd}\n"|sudo pdbedit -t -a ${new_user}

echo adduser and del first user - end

