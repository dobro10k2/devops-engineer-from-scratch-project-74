UID := $(shell id -u)
GID := $(shell id -g)
DC := docker compose

setup: prepare-env
	$(DC) run --rm -u $(UID):$(GID) app make setup

dev: prepare-env
	$(DC) up

test: prepare-env
	$(DC) -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

ci: test

lint: prepare-env
	$(DC) run --rm app make lint

clean:
	$(DC) down -v

prepare-env:
	@test -f .env || cp .env.example .env
