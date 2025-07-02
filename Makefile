# Chemins
SRC_DIR := src
COMPOSE := docker compose -f $(SRC_DIR)/docker-compose.yml


VOLUME_DIRS := \
	$(HOME)/data/mariadb \
	$(HOME)/data/wordpress \

up:
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

re: down up

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

clean:
	$(COMPOSE) down --volumes --remove-orphans
	docker volume prune -f
	@for dir in $(VOLUME_DIRS); do \
		echo "Removing $$dir..."; \
		sudo rm -rf $$dir; \
		mkdir -p $$dir; \
	done

rebuild: clean up

.PHONY: up down re logs ps clean rebuild
