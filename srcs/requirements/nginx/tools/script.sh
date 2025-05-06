#! /bin/bash

# mkdir to store the privtekey and certificat
mkdir -p /etc/ssl/private && mkdir -p /etc/ssl/certs

# req -> reate, view, or process a certificate
# -x509 to generate a self-singned certif without CA (Certificate Authority)
# node do not put pass on privtekey
# -days:  days to certify the certificate for, otherwise it default is 30 days
# newkey is algorithms [rsa:]nbits generates an RSA key nbits in size
# -keyout and -out where to save certif and privtkey
#-subj: Certificate subject (country, state, location, organisation, campnyname, uid)
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/privte_site.key -out /etc/ssl/certs/certif.crt -subj "/C=MA/ST=Beni Mellal-Khenifra/L=KHOURIBGA/O=42/CN=${DOMAIN_NAME}/UID=ymomen"


echo "server {
    listen 443 ssl;
    server_name ${DOMAIN_NAME};

    ssl_certificate /etc/ssl/certs/certif.crt;
    ssl_certificate_key /etc/ssl/private/privte_site.key;

    ssl_protocols TLSv1.3;

    root /var/www/html;
    index index.php index.html;
    # Loads file extension to MIME type mappings So Nginx can serve the correct Content-Type
    include /etc/nginx/mime.types;

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass wordpress:9000;
    }
}" > /etc/nginx/sites-enabled/default

# important to run it in the forgroude so it be the process pid 1 that hold all the container if it end the docker container going to shut down
exec nginx -g "daemon off;"
