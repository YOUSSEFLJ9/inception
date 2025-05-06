FROM debian:bullseye

#install 
RUN apt -y update && apt -y upgrade && apt install -y php php-fpm php-mysql wget mariadb-client


COPY tools/script.sh tmp/script.sh

RUN chmod +x tmp/script.sh

ENTRYPOINT ["tmp/script.sh"]


