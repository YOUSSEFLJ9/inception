#!/bin/sh

# create user of sever ftp
useradd -m "$FTP_USER"

FTP_SERVER_PASS="$(cat /run/secrets/ftp_server_pass)"
# set the password to the local user
echo "$FTP_USER:$FTP_SERVER_PASS" | chpasswd

# This option should be the name of a directory which is empty.  Also, the
# directory should not be writable by the ftp user. This directory is used
# as a secure chroot() jail at times vsftpd does not require filesystem
# access.
mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

# this line to make the user of ftp_server have the right to modify in the files of wordpress.
chown -R $FTP_USER:$FTP_USER /var/www/

# add the pasv address to make connection possible from out side the docker network in the passive mode 
echo "pasv_address=$PASV_ADDRESS" >> /etc/vsftpd.conf

# vsftpd: secure FTP server that allows clients to connect and transfer files
exec vsftpd /etc/vsftpd.conf