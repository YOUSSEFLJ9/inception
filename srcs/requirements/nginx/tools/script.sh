#! /bin/bash

mkdir -p /etc/ssl/private && mkdir -p /etc/ssl/certs

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/privte_site.key -out /etc/ssl/certs/certif.crt -subj "/C=MA/ST=Beni Mellal-Khenifra/L=KHOURIBGA/O=42/CN=${DOMAIN_NAME}/UID=ymomen"


echo "server {
    listen 443 ssl;
    server_name ${DOMAIN_NAME};

    ssl_certificate /etc/ssl/certs/certif.crt;
    ssl_certificate_key /etc/ssl/private/privte_site.key;

    ssl_protocols TLSv1.3;

    root /var/www/html;
    index index.php index.html index.htm;

    include /etc/nginx/mime.types;

    # location / {
    #     try_files \$uri \$uri/ /index.php?\$args;
    # }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass wordpress:9000;
        # fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    # location ~ /\.ht {
    #     deny all;
    # }
}" > /etc/nginx/sites-enabled/default


exec nginx -g "daemon off;"

# echo "server {
#     listen 443 ssl;
#     server_name ${DOMAIN_NAME};

#     ssl_certificate /etc/ssl/certs/certif.crt;
#     ssl_certificate_key /etc/ssl/private/privte_site.key;

#     ssl_protocols TLSv1.3;
#     # ssl_prefer_server_ciphers on;

#     location / {
#         root /var/www/html;
#         # index index.php index.html;
#         autoindex on;
#     }
#     location ~ \.php$ {
#         # include the configuration file (fastcgi-php.conf) 
#         # that contains common settings for processing PHP requests with FastCGI.
#         include snippets/fastcgi-php.conf;
#         # Directs the PHP requests to a FastCGI server running on a container named wordpress at port 9000.
#         fastcgi_pass wordpress:9000;
#     }
# }"  > /etc/nginx/sites-enabled/default