#!/bin/sh

chmod -R 755 /www
chown -R www-data:www-data /www

echo "server {
    listen 1999;
    server_name ${DOMAIN_NAME};

    root /www;
    index index.html;
    
    location / {
    autoindex on;
}

}" > /etc/nginx/sites-enabled/default


exec nginx -g "daemon off;"