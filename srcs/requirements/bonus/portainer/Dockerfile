FROM debian:bullseye


RUN apt update && apt install -y curl ca-certificates apache2-utils

RUN mkdir -p /data /certificates

RUN chmod -R 777 /data
RUN chmod -R 777 /certificates

COPY script.sh script.sh

RUN chmod +x script.sh

EXPOSE 7878 9443

ENTRYPOINT ["./script.sh"]