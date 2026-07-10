.PHONY: start logs stop migrate seed test lint setup set-password init-credentials

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

init-credentials:
	docker compose run --rm web bin/rails credentials:edit

setup: build init-credentials set-password
	docker compose run --rm web bin/rails db:create db:schema:load

set-password:
	docker compose run --rm -it web bin/rails auth:set_password

purge:
	docker compose down -v --remove-orphans --rmi=all
