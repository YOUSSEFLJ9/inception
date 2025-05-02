FROM debian:bullseye


RUN apt update && apt install -y curl apache2-utils docker-compose

RUN mkdir -p /data /certificates

RUN chmod -R 777 /data /certificates

COPY script.sh script.sh

RUN chmod +x script.sh

EXPOSE 7878 9443

ENTRYPOINT ["./script.sh"]