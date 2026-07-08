.PHONY: start logs stop migrate seed test lint

start:
	docker compose up -d

logs:
	docker compose logs -f

stop:
	docker compose down

migrate:
	docker compose run --rm web rails db:migrate

seed:
	docker compose run --rm web rails db:seed

test:
	docker compose run --rm -e RAILS_ENV=test web rails test

lint:
	docker compose run --rm web bin/rubocop -a
