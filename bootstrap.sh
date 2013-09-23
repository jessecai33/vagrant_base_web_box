#!/usr/bin/env bash

# Ubuntu box provision

apt-get -y update

# local time
ln -sf /usr/share/zoneinfo/Australia/Sydney /etc/localtime
# ln -sf /usr/share/zoneinfo/Asia/Singapore /etc/localtime

# git
apt-get -y install git-core

# php-fpm
apt-get -y install php5-fpm

# php extensions
apt-get -y install php-pear php5-cli php5-mysql php5-imap php5-gd php5-curl php5-mcrypt

# php-apc
apt-get -y install php-apc

# nginx
apt-get -y install nginx

# link vagrant folder to hosting folder
rm -rf /var/www
ln -sf /vagrant /var/www

# copy over configuration file (micro instance)
cp -f /vagrant/conf/nginx.conf /etc/nginx/
cp -f /vagrant/conf/virtual.conf /etc/nginx/conf.d/
cp -f /vagrant/conf/php-fpm.conf /etc/php5/fpm/
cp -f /vagrant/conf/www.conf /etc/php5/fpm/pool.d/

# install sysv-rc-conf (Ubuntu version of chkconfig)
apt-get -y install sysv-rc-conf

# autostart php-fpm & nginx
sysv-rc-conf nginx on
sysv-rc-conf php5-fpm on

# start php-fpm & nginx
service nginx start
service php5-fpm start
service php5-fpm restart