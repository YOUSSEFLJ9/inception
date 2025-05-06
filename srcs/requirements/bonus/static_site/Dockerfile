FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y nginx

COPY cnf.sh cnf.sh

COPY www/. www/.

RUN chmod +x cnf.sh

EXPOSE 1999

ENTRYPOINT ["/cnf.sh"]