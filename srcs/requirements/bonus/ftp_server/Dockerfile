FROM debian:bullseye

RUN apt update && apt install -y vsftpd curl net-tools procps

WORKDIR /ftp

COPY script.sh script.sh

RUN chmod +x script.sh

COPY vsftp.conf /etc/vsftpd.conf

EXPOSE 21 20 21080-21090


ENTRYPOINT ["./script.sh"]

