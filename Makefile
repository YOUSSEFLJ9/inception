all: creatdir up

restart: down up

build:
	docker compose -f srcs/docker-compose.yml build

up: creatdir
	docker compose -f srcs/docker-compose.yml up --build -d

down:
	docker compose -f srcs/docker-compose.yml down

ps:
	docker compose -f srcs/docker-compose.yml ps

update: creatdir
	docker compose -f srcs/docker-compose.yml up --build -d


creatdir:
	mkdir -p /home/ymomen/data/DB
	mkdir -p /home/ymomen/data/portainer_data
	mkdir -p /home/ymomen/data/Wordpress_volume
deletedir:
	sudo rm -rf /home/ymomen/data/

clean: deletedir
	docker compose -f srcs/docker-compose.yml down -v --rmi all

cleanall:deletedir
	docker system prune -a --volumes --force
# clean all unused resources -a all --volumes 