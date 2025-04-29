#!/bin/sh

FTP_PASS=$(cat /run/secrets/ftp_server_pass)


service vsftpd start
useradd -m -d /home/$FTP_USER -s /bin/bash $FTP_USER

echo "$FTP_USER:$FTP_PASS" | chpasswd

mkdir -p /home/${FTP_USER}/files

chown -R $FTP_USER:$FTP_USER /home/$FTP_USER

service vsftpd stop

exec /usr/sbin/vsftpd /etc/vsftpd.conf