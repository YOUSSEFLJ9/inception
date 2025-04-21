#!/bin/bash

mkdir -p /run/php && mkdir -p /var/www/

wget -q -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x /usr/local/bin/wp

sleep 10
cd /var/www/html
# wp core download --allow-root
wp core download --allow-root

chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html

DB_PASSWORD="$(cat /run/secrets/db_password)"
WORDPRESS_ADMIN_PASS="$(cat /run/secrets/wordpress_admin_pass)"
WORDPRESS_USER_PASS="$(cat /run/secrets/wordpress_user_pass)"


wp config create --allow-root \
    --dbname=$DATABASE_NAME \
    --dbuser=$USER_DB \
    --dbpass=$DB_PASSWORD \
    --dbhost=mariadb:3306
    #install wordpress
wp core install --allow-root \
    --url="https://$DOMAIN_NAME" \
    --title=$WORDPRESS_TITLE \
    --admin_user=$WORDPRESS_ADMIN \
    --admin_password=$WORDPRESS_ADMIN_PASS \
    --admin_email=$WP_ADMIN_EMAIL

# creat new user 
wp user create --allow-root "$WP_USER" "$WP_USER_EMAIL" --role=author --user_pass=$WORDPRESS_USER_PASS --path=/var/www/html

wp option update home "https://$DOMAIN_NAME" --allow-root --path=/var/www/html 
wp option update siteurl "https://$DOMAI_NAME" --allow-root --path=/var/www/html

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

php-fpm7.4 -F