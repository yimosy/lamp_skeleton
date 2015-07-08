cat << _EOT_ > /etc/httpd/conf.d/vhost.conf
EnableSendfile Off
EnableMMAP Off
_EOT_

cat << _EOT_ > /etc/php.d/xdebug.ini
zend_extension="/usr/lib64/php/modules/xdebug.so"
xdebug.remote_enable=1
xdebug.remote_connect_back = on
xdebug.remote_handler=dbgp
xdebug.remote_mode=req
xdebug.remote_port=9000
xdebug.collect_params = On
xdebug.dump.GET = *
xdebug.dump.POST = *
_EOT_

sed -i -e "/AddType text\/html \.php/i\AddType application\/x-httpd-php \.php \.html" /etc/httpd/conf.d/php.conf

service httpd start
