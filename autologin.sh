#!/bin/sh

echo change auto login to user : `whoami` - start

sudo echo exec /sbin/agetty -a `whoami` tty1 >> /etc/init/tty1.conf

echo change auto login to user : `whoami` - end
