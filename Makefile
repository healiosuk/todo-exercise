.PHONY: start logs stop migrate seed test lint setup

start:
	docker compose up -d

logs:
	docker compose logs -f

stop:
	docker compose down

migrate:
	docker compose run --rm web bin/rails db:migrate

seed:
	docker compose run --rm web bin/rails db:seed

test:
	docker compose run --rm -e RAILS_ENV=test web bin/rails test

lint:
	docker compose run --rm web bin/rubocop -a

build:
	docker compose build

setup: build
	docker compose run --rm web bin/rails db:create db:schema:load

purge:
	docker compose down -v --remove-orphans --rmi=all
