#!/bin/bash
set -e

# Tạo thư mục cần thiết cho X11
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# Khởi động D-Bus (cần cho XFCE)
mkdir -p /var/run/dbus
service dbus start || true

# Tạo sẵn file log để tail không bị lỗi
mkdir -p /var/log/xrdp
touch /var/log/xrdp-sesman.log /var/log/xrdp.log

# Khởi động xrdp và sesman trực tiếp
/usr/sbin/xrdp-sesman --nodaemon &
/usr/sbin/xrdp --nodaemon &

# Giữ container sống và in log ra stdout để Railway xem được
tail -f /var/log/xrdp.log /var/log/xrdp-sesman.log
