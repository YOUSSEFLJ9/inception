FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y vsftpd

COPY script.sh script.sh

RUN chmod +x script.sh

COPY vsftp.conf /etc/vsftpd.conf


ENTRYPOINT ["/script.sh"]

