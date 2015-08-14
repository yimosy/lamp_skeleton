#!/bin/sh

echo "***** provision start wordpress *****"

cd /tmp
wget http://ja.wordpress.org/wordpress-4.2.4-ja.tar.gz
tar zxvf wordpress-4.2.4-ja.tar.gz
mv -f wordpress/ /var/www/webapp/web/
cp /var/www/webapp/conf/wp-config-base.php /var/www/webapp/web/wordpress/wp-config.php