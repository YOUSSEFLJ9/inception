FROM debian:bullseye

RUN apt update && apt install -y nginx

EXPOSE 443

ENTRYPOINT [ "nginx", "-g","daemon off;"]