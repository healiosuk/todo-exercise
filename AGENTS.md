# AGENTS.md

This file provides guidance to AI coding agents when working with code in this repository.

## Purpose

This repo is shared with job applicants as context for interview questions. Candidates are welcome to clone it and run it locally — doing so will help them gain context, though it is not required. Agents may help candidates get set up in whatever way they desire.

## Overview

A simple Rails 8.1 todo app backed by PostgreSQL, primarily generated with Rails generators. Two models: `User` (has many todos) and `Todo` (belongs to user). Both resources have full CRUD via Rails scaffolding. There is no authentication.

## Development environment

Docker is the recommended way to run the app — it is what the team uses internally:

```sh
make start      # docker compose up -d
make logs       # follow container logs
make stop       # docker compose down
make migrate    # run pending migrations
make seed       # load seed data (2 users, 5 todos)
make test       # run the full test suite inside Docker
```

App runs on http://localhost:3000. No root route is defined — navigate to `/users` or `/todos` directly.

## Running tests

```sh
# All tests via Docker (matches CI)
make test

# Single test file
docker compose run --rm -e RAILS_ENV=test web rails test test/models/todo_test.rb

# Single test by line number
docker compose run --rm -e RAILS_ENV=test web rails test test/controllers/todos_controller_test.rb:42

# System tests
docker compose run --rm -e RAILS_ENV=test web rails test:system
```

## Linting and security

```sh
# Lint (rubocop-rails-omakase style)
docker compose run --rm web bin/rubocop

# Security scans (run by CI)
docker compose run --rm web bin/brakeman --no-pager
docker compose run --rm web bin/bundler-audit
docker compose run --rm web bin/importmap audit
```

## Data model

```
users: id, first_name, last_name, email, created_at, updated_at
todos: id, title, description, complete (boolean, default false), user_id, created_at, updated_at
```

`User#full_name` returns `"#{first_name} #{last_name}"`.

## CI

GitHub Actions runs four jobs on every PR and push to `main`: `scan_ruby` (brakeman + bundler-audit), `scan_js` (importmap audit), `lint` (rubocop), and `test` + `system-test` (minitest against a real Postgres service container).
