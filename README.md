# Todo Exercise

A simple Rails todo app shared with interview candidates as context for technical questions. You are welcome to run it locally — doing so may help, but is not required.

## Requirements

- Docker & Docker Compose

## Getting started

```sh
make start    # start the app
make migrate  # set up the database
make seed     # load sample data
```

Then open http://localhost:3000/users or http://localhost:3000/todos.

```sh
make stop     # shut everything down
```

## Running tests

```sh
make test
```
