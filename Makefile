.PHONY: start logs stop migrate test

start:
	docker compose up -d

logs:
	docker compose logs -f

stop:
	docker compose down

migrate:
	docker compose run --rm web rails db:migrate

test:
	docker compose run --rm -e RAILS_ENV=test web rails test
