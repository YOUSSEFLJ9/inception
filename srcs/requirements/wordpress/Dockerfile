FROM debian:bullseye

# php-curl php-gd php-mbstring  php-xml php-zip php-xmlrpc  unzip curl \
RUN apt -y update && apt -y upgrade && apt install -y php php-fpm php-mysql wget mariadb-client
  
COPY tools/script.sh script.sh
RUN chmod +x script.sh


ENTRYPOINT [ "tail", "-f", "/dev/null" ]
# ENTRYPOINT ["/script.sh"]
# ENTRYPOINT  ["php-fpm7.4", "-F"]
