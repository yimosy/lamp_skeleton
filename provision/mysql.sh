#!/bin/sh

# 設定
MYSQL_DBNAME=mydb
MYSQL_USER=mydbuser
MYSQL_PASS=mydbpass1234

# 接続情報をファイルに一時出力
MYSQL_CLIENT_CNF=`mktemp`
echo "[client]" >> ${MYSQL_CLIENT_CNF}
echo "user = root" >> ${MYSQL_CLIENT_CNF}
echo "password = ${MYSQL_PASS}" >> ${MYSQL_CLIENT_CNF}
echo "host = localhost" >> ${MYSQL_CLIENT_CNF}

yum -y install http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
yum -y install mysql-community-server

sed -i '/mysqld\]/a character-set-server = utf8' /etc/my.cnf
sed -i '/mysqld\]/a explicit_defaults_for_timestamp = true' /etc/my.cnf

chkconfig mysqld on
service mysqld start

# rootユーザのパスワード変更
mysql -u root -e "UPDATE mysql.user SET Password=PASSWORD('${MYSQL_PASS}') WHERE User='root';"
mysql -u root -e "FLUSH PRIVILEGES;"

mysql --defaults-extra-file=${MYSQL_CLIENT_CNF} -e "DELETE FROM mysql.user WHERE host <> 'localhost' or user <> 'root';"

mysql --defaults-extra-file=${MYSQL_CLIENT_CNF} -e "CREATE DATABASE ${MYSQL_DBNAME} CHARACTER SET utf8;"
mysql --defaults-extra-file=${MYSQL_CLIENT_CNF} -e "GRANT ALL ON ${MYSQL_DBNAME}.* TO '${MYSQL_USER}'@'localhost' IDENTIFIED BY '${MYSQL_PASS}'";

mysql --defaults-extra-file=${MYSQL_CLIENT_CNF} -e "FLUSH PRIVILEGES;"

# 接続情報を削除
rm -rf ${MYSQL_CLIENT_CNF}
