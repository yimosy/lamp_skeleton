#!/bin/sh

rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm > /dev/null 2>&1
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm > /dev/null 2>&1

sed -i -e "s/#baseurl=http/baseurl=http/g" /etc/yum.repos.d/epel.repo
sed -i -e "s/mirrorlist/#mirrorlist/g" /etc/yum.repos.d/epel.repo
sed -i -e "s/enabled=1/enabled=0/g" /etc/yum.repos.d/epel.repo

yum install -y --enablerepo=epel,remi,remi-php55 php php-cli php-common php-devel php-gd \
php-intl php-mbstring php-pdo php-mysqlnd php-pear.noarch php-xml php-mcrypt

sed -i 's/display_errors = Off/display_errors = On/' /etc/php.ini

pecl install xdebug > /dev/null 2>&1

curl -sS https://getcomposer.org/installer | php > /dev/null 2>&1
mv composer.phar /usr/local/bin/composer > /dev/null 2>&1

