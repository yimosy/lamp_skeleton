#!/bin/sh

yum -y install httpd
yum -y install mod_ssl

if [ ! -f /etc/httpd/conf/httpd.conf.org ]; then
  cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.org
fi
cp /etc/httpd/conf/httpd.conf.org /etc/httpd/conf/httpd.conf

sed -i -e "s/#ServerName www.example.com:80/ServerName localhost:80/g" /etc/httpd/conf/httpd.conf

cat << _EOT_ >> /etc/httpd/conf/httpd.conf
DocumentRoot "/var/www/htdocs"
<Directory "/var/www/htdocs">
  Options Indexes FollowSymLinks
  AllowOverride None
  Order allow,deny
  Allow from all
</Directory>
_EOT_

ln -snf /var/www/webapp/web /var/www/htdocs