start:
	docker compose up -d

logs:
	docker compose logs -f

stop:
	docker compose down

migrate:
	docker compose run --rm web rails db:migrate
