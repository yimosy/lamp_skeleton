#!/bin/sh

# fastestmirror
echo "prefer=ftp.jaist.ac.jp" >> /etc/yum/pluginconf.d/fastestmirror.conf

# Firewall、SELinux OFF
/etc/rc.d/init.d/iptables stop
chkconfig iptables off
chkconfig ip6tables off
cp -p /etc/selinux/config /etc/selinux/config.orig
sed -i -e "s|^SELINUX=.*|SELINUX=disabled|" /etc/selinux/config
setenforce 0

yum update > /dev/null 2>&1
yum install -y wget > /dev/null 2>&1

# 色々日本語化（man、locale、timezone）
yum install man > /dev/null 2>&1
yum -y install man-pages-ja > /dev/null 2>&1

cat << _EOT_ > /etc/sysconfig/i18n
LANG="ja_JP.utf8"
SUPPORTED="en_US:en:ja_JP.eucJP:ja_JP:ja"
SYSFONT="lat0-sun16"
SYSFONTACM="iso01"
_EOT_

cat << _EOT_ > /etc/sysconfig/clock
ZONE="Asia/Tokyo"
_EOT_
