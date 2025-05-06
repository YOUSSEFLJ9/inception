FROM debian:bullseye


RUN apt update && apt upgrade -y && apt install -y curl apache2-utils docker-compose

RUN mkdir -p /data_pt

RUN chmod -R 755 /data_pt

COPY script.sh script.sh

RUN chmod +x script.sh

EXPOSE 7878 9443

ENTRYPOINT ["./script.sh"]