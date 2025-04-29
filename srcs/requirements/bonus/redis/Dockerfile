FROM debian:bullseye

WORKDIR /redis

RUN apt update && apt install -y redis-server && apt clean && rm -rf /var/lib/apt/lists/*

EXPOSE 6379

ENTRYPOINT ["redis-server", "--protected-mode", "no"]