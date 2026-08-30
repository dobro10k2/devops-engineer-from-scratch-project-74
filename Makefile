.PHONY: prepare-env setup dev test ci lint clean

UID := $(shell id -u)
GID := $(shell id -g)
DC := docker compose

prepare-env:
	cp -n .env.example .env

setup:
	$(DC) run --rm -u $(UID):$(GID) app make setup

dev:
	$(DC) up

test:
	$(DC) -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

ci: prepare-env test

lint:
	$(DC) run --rm app make lint

clean:
	$(DC) down -v
