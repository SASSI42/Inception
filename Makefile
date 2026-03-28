all: up

up:
	@mkdir -p /home/msassi/data/mariadb
	@mkdir -p /home/msassi/data/wordpress
	@cd srcs && docker compose  up --build

down:
	@cd srcs && docker compose down

clean: down
	@docker system prune -a --force

fclean: clean
	@sudo rm -rf /home/msassi/data/wordpress /home/msassi/data/mariadb
	@docker system prune --all --force --volumes

re: fclean all
