FROM debian:bullseye
# base image is debian bullseye


WORKDIR /nginx

# nginx is webserver , revereseporoxy, loadbalancer, opennssl is to manage the certificates and encryption
RUN apt update && apt upgrade -y && apt install -y nginx && apt install openssl

COPY tools/script.sh script.sh

RUN chmod +x script.sh

EXPOSE 443

#run the script in the runtime
ENTRYPOINT ["/nginx/script.sh"]