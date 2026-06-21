UID := $(shell id -u)
GID := $(shell id -g)

setup:
	docker-compose run --rm -u $(UID):$(GID) app make setup

dev:
	docker-compose up

test:
	docker-compose -f docker-compose.yml up --abort-on-container-exit --exit-code-from app
