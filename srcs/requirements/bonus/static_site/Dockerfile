FROM debian:bullseye

RUN apt update && apt install -y nginx && apt clean && rm -rf /var/lib/apt/lists/*

COPY cnf.sh cnf.sh

COPY www/. www/.

RUN chmod +x cnf.sh

EXPOSE 1999

ENTRYPOINT ["/cnf.sh"]