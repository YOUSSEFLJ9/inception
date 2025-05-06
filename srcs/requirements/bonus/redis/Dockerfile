FROM debian:bullseye

WORKDIR /redis

RUN apt update && apt upgrade -y && apt install -y redis-server

# Default port for Redis
EXPOSE 6379


# desable the security it can be accessbel from other containers
ENTRYPOINT ["redis-server", "--protected-mode", "no"]