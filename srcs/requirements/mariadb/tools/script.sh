#!/bin/bash

# creat the dir of storting all the databases
mkdir -p /var/lib/mysql
mkdir -p /run/mysqld

#Set onwership and permissions:

chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld  #this file is where the socket is stored so we must have write permisssions 

chmod 755 /run/mysqld  # give the file of the socket the permission rwe of the owner and others and grop re so anyother can r and be executable for others to access socket files inside it 

chmod 700 /var/lib/mysql # the owner have rwe and no one have the right to do any thing in the database folder its private.
service mariadb start

echo "starting mariadb"
sleep 6


DB_PASSWD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWD=$(cat /run/secrets/db_root_password)
DB_ROOT_DEAF_PASSWD=$(cat /run/secrets/db_default_root_password)

mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`$DATABASE_NAME\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS '$USER_DB'@'%' IDENTIFIED BY '$DB_PASSWD';"
# connect to mysql mariadb as root user -e execute the following sql command , with giving all the permission select insert update delete.. and aply all those privilage on all the tables in the database , the (%) mean give the user the privilage to connect from any host, and this user can give those privilages to other users
mysql -u root -e "GRANT ALL PRIVILEGES ON \`$DATABASE_NAME\`.* TO '$USER_DB'@'%' WITH GRANT OPTION;"

mysql -u root -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWD';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"

mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_DEAF_PASSWD';"
#The FLUSH PRIVILEGES command simply ensures that all changes made to users, privileges, etc., are applied immediately.
mysql -u root -p"$DB_ROOT_DEAF_PASSWD" -e "FLUSH PRIVILEGES;"


# service mariadb stop
mysqladmin -u root -p"$DB_ROOT_DEAF_PASSWD" shutdown

exec mysqld
