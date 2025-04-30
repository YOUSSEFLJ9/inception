#!/bin/sh

# create user
useradd -m "$FTP_USER"

# get password
FTP_SERVER_PASS="$(cat /run/secrets/ftp_server_pass)"
# add password
echo "$FTP_USER:$FTP_SERVER_PASS" | chpasswd

# Create the required directory for secure_chroot_dir 
# for jailed (chrooted) FTP users (for security reasons)
mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

chown -R $FTP_USER:$FTP_USER /var/www/

echo "pasv_address=$PASV_ADDRESS" >> /etc/vsftpd.conf
echo "Starting FTP in the foreground..."
# vsftpd: secure FTP server that allows clients to connect and transfer files
exec vsftpd /etc/vsftpd.conf