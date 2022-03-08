DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

start:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up
down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
re:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up --build
stop:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) stop

.PHONY: start down stop