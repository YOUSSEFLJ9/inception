FROM debian:bullseye

WORKDIR /nginx

RUN apt update && apt install -y nginx && apt install openssl && apt clean && rm -rf /var/lib/apt/lists/*

COPY tools/script.sh script.sh

RUN chmod +x script.sh

EXPOSE 443

ENTRYPOINT ["/nginx/script.sh"]