#!/bin/sh

#### auto login
user=sasaki
dhcphost=172.27.82.33

echo change auto login to user : ${user} - start

sudo echo exec /sbin/agetty -a ${user} tty1 >> /etc/init/tty1.conf

echo change auto login to user : ${user} - end

####samba shared directory

echo samba configure shared directory - start

sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.org
sudo wget http://${dhcphost}/smb.conf -O /etc/samba/smb.conf

#sudo touch /etc/samba/smb.conf
#sudo echo [global]>>/etc/samba/smb.conf
#sudo echo unix charset=UTF-8>>/etc/samba/smb.conf
#sudo echo dos charset=CP932>>/etc/samba/smb.conf
#sudo echo workgroup=WORKGROUP>>/etc/samba/smb.conf
#sudo echo [share]>>/etc/samba/smb.conf
#sudo echo path=/mnt/samba>>/etc/samba/smb.conf
#sudo echo read only=no>>/etc/samba/smb.conf
#sudo echo browseable=yes>>/etc/samba/smb.conf
#sudo echo create mode=0777>>/etc/samba/smb.conf
#sudo echo directory mode=0777>>/etc/samba/smb.conf


sudo mkdir -p /mnt/samba
sudo chown nobody:nogroup /mnt/samba
sudo chmod 777 /mnt/samba
sudo echo -e "${user}\n${user}\n"|sudo pdbedit -t -a ${user}
#sudo service samba restart
#if you want to delete user - sudo pdbedit -x -u ${user}

echo samba configure shared directory - end

####unattended-upgrades - update/upgrade scheduled

echo unattended-upgrades configure - start

sudo apt-get install unattended-upgrades -y

sudo mv /etc/apt/apt.conf.d/50unattended-upgrades /etc/apt/apt.conf.d/50unattended-upgrades.org
sudo wget http://${dhcphost}/50unattended-upgrades -O /etc/apt/apt.conf.d/50unattended-upgrades

sudo mv /etc/apt/apt.conf.d/10periodic /etc/apt/apt.conf.d/10periodic.org
sudo wget http://${dhcphost}/10periodic -O /etc/apt/apt.conf.d/10periodic

echo unattended-upgrades configure - end
