#!/bin/sh

yum -y install http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum -y install mysql-community-server

sed -i '/mysqld\]/a character-set-server = utf8' /etc/my.cnf
sed -i '/mysqld\]/a explicit_defaults_for_timestamp = true' /etc/my.cnf

chkconfig mysqld on
service mysqld start

mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('') WHERE User='root';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* to user@\"%\" IDENTIFIED BY 'password' WITH GRANT OPTION;"
mysql -u root -e "FLUSH PRIVILEGES;"
