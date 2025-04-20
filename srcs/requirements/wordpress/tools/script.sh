#!/bin/bash

mkdir -p /run/php && mkdir -p /var/www/

wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -pO /usr/local/bin/wp
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
wp core install --allow-root \
    --url="https://$DOMAIN_NAME" \
    --title=$WORDPRESS_TITLE \
    --admin_user=$WORDPRESS_ADMIN \
    --admin_password=$WORDPRESS_ADMIN_PASS \
    --admin_email=$WP_ADMIN_EMAIL

# wget https://wordpress.org/latest.tar.gz -P /var/www/

# tar -xzf /var/www/latest.tar.gz -C /var/www/html --strip-components=1
# rm -rf /var/www/latest.tar.gz
