#!/bin/sh

# Postfix

echo postfix isntall - start

echo postfix postfix/mailname string $HOSTNAME | sudo debconf-set-selections
echo postfix postfix/main_mailer_type string 'Internet Site' | sudo debconf-set-selections

sudo apt-get install -y postfix
sudo service postfix reload

echo postfix isntall - end
