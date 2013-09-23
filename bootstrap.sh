#!/usr/bin/env bash

# Ubuntu box provision

sudo apt-get -y update

#local time
sudo ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime
# ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime

#git
sudo apt-get -y install git-core

#php-fpm
sudo apt-get -y install php5-fpm

#php extensions
sudo apt-get -y install php-pear php5-cli php5-mysql php5-imap php5-gd php5-curl php5-mcrypt

#php-apc
sudo apt-get -y install php-apc

#nginx
sudo apt-get -y install nginx

#link vagrant folder to hosting folder
rm -rf /var/www
ln -sf /vagrant /var/www

#copy over configuration file (micro instance)
sudo cp -f /vagrant/conf/nginx.conf /etc/nginx/
sudo cp -f /vagrant/conf/virtual.conf /etc/nginx/conf.d/
sudo cp -f /vagrant/conf/php-fpm.conf /etc/php5/fpm/
sudo cp -f /vagrant/conf/www.conf /etc/php5/fpm/pool.d/

#install sysv-rc-conf (Ubuntu version of chkconfig)
sudo apt-get -y install sysv-rc-conf

#autostart php-fpm & nginx
sudo sysv-rc-conf nginx on
sudo sysv-rc-conf php5-fpm on

# start php-fpm & nginx
sudo service nginx start
sudo service php5-fpm start
sudo service php5-fpm restart

