FROM debian:bullseye

WORKDIR /adminer

RUN apt update && apt install -y php php-mysqli php-pgsql curl && apt clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /adminer/www

COPY script_if_needed.sh script_if_needed.sh

RUN chmod +x /adminer/script_if_needed.sh

EXPOSE 4040

ENTRYPOINT ["/adminer/script_if_needed.sh"]