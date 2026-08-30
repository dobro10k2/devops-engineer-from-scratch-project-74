UID := $(shell id -u)
GID := $(shell id -g)
# Extract the compose call into a variable for consistency (using the modern v2)
DC := docker compose

setup:
	$(DC) run --rm -u $(UID):$(GID) app make setup

dev:
	$(DC) up

test:
	$(DC) -f docker-compose.yml up --abort-on-container-exit --exit-code-from app

# Repository check (CI) now simply reuses the test target
ci: test

# Local check (running the linter from the application's internal Makefile)
lint:
	$(DC) run --rm app make lint

# Environment cleanup (stopping containers and removing database volumes)
clean:
	$(DC) down -v
