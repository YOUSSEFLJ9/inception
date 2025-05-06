#!/bin/bash


#Set onwership and permissions:

chmod 755 /run/mysqld  # give the file of the socket the permission rwe of the owner and others and grop re so anyother can r and be executable for others to access socket files inside it 
chmod 700 /var/lib/mysql # the owner have rwe and no one have the right to do any thing in the database folder its private.
chown -R mysql:mysql /var/lib/mysql
chown -R mysql:mysql /run/mysqld  #this file is where the socket is stored so we must have write permisssions 


DB_PASSWD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWD=$(cat /run/secrets/db_root_password)
DB_ROOT_DEAF_PASSWD=$(cat /run/secrets/db_default_root_password)

service mariadb start

sleep 5

#run sql queries
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`$DATABASE_NAME\`;" 2>/dev/null
mysql -u root -e "CREATE USER IF NOT EXISTS '$USER_DB'@'%' IDENTIFIED BY '$DB_PASSWD';" 2>/dev/null
# connect to mysql mariadb as root user -e execute the following sql command , with giving all the permission select insert update delete.. and aply all those privilage on all the tables in the database , the (%) mean give the user the privilage to connect from any host, and this user also can give those privilages to other users
mysql -u root -e "GRANT ALL PRIVILEGES ON \`$DATABASE_NAME\`.* TO '$USER_DB'@'%' WITH GRANT OPTION;" 2>/dev/null

mysql -u root -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASSWD';" 2>/dev/null
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;"

mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_DEAF_PASSWD';" 2>/dev/null
#The FLUSH PRIVILEGES command simply ensures that all changes made to users, privileges, etc., are applied immediately.
mysql -u root -p"$DB_ROOT_DEAF_PASSWD" -e "FLUSH PRIVILEGES;"


# service mariadb stop
mysqladmin shutdown -p"$DB_ROOT_DEAF_PASSWD" 

exec mysqld
