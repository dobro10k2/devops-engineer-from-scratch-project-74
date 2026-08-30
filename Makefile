UID := $(shell id -u)
GID := $(shell id -g)
DC := docker compose

.PHONY: prepare-env setup dev test ci lint clean

prepare-env:
	@test -f .env || cp .env.example .env

setup: prepare-env
	$(DC) run --rm -u $(UID):$(GID) app make setup

dev: prepare-env
	$(DC) up

test: prepare-env
	$(DC) -f docker-compose.yml up --build --abort-on-container-exit --exit-code-from app

ci: prepare-env test

lint: prepare-env
	$(DC) run --rm app make lint

clean:
	$(DC) down -v --remove-orphans
