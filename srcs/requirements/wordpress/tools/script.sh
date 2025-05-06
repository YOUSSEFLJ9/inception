#!/bin/bash

# Create necessary directories for php-fpm pid to mange he pid proc of phpfpm and where to install file of wp
mkdir -p /run/php /var/www/html

# Download wp-cli if not already downloaded -> wordpress command line -q quit mode
if [ ! -f /usr/local/bin/wp ]; then
    wget -q -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x /usr/local/bin/wp
fi

# Wait for the DB to be ready
sleep 15

cd /var/www/html

# Only download WordPress if it's not already downloaded
if [ ! -f wp-load.php ]; then
    wp core download --allow-root
fi
# www-data: the default web server user
chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html


# Secrets
DB_PASSWORD="$(cat /run/secrets/db_password)"
WORDPRESS_ADMIN_PASS="$(cat /run/secrets/wordpress_admin_pass)"
WORDPRESS_USER_PASS="$(cat /run/secrets/wordpress_user_pass)"

# Create wp-config.php if it doesn't exist
if [ ! -f wp-config.php ]; then
    wp config create --allow-root \
        --dbname=$DATABASE_NAME \
        --dbuser=$USER_DB \
        --dbpass=$DB_PASSWORD \
        --dbhost=mariadb:3306
fi

# Install WordPress site only if it's not already installed
if ! wp core is-installed --allow-root; then
    wp core install --allow-root \
        --url="$DOMAIN_NAME" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN" \
        --admin_password="$WORDPRESS_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL"
fi

# Create user if not exists
if ! wp user get "$WP_USER" --allow-root > /dev/null 2>&1; then
    wp user create "$WP_USER" "$WP_USER_EMAIL" --role=author --user_pass=$WORDPRESS_USER_PASS --allow-root
fi

# Activate theme if not already activated
CURRENT_THEME=$(wp theme list --status=active --field=name --allow-root)
if [ "$CURRENT_THEME" != "twentytwentyfour" ]; then
    wp theme install twentytwentyfour --activate --allow-root
fi


# Fix php-fpm port to now work with the unix socket but the ip tcp from 0.0.0.0:9000
#sed command strem editing , -i edit in file not in the output s is substion minn tebda | is the delem , the next is the remplacment string until | , at the end the file name
sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

# this lines to install the redis object caching if not alrad instaled 
wp plugin install redis-cache --activate --allow-root
sleep 10

wp config set WP_REDIS_HOST 'redis' --allow-root
wp config set WP_CACHE 'true' --allow-root
wp config set WP_REDIS_PORT '6379' --allow-root
wp redis enable --allow-root

# Run PHP-FPM in foreground
php-fpm7.4 -F
