Runs phoenix with hex, node and inotify-tools all installed on the latest elixir
base image.

This image is intended for use in development of phoenix applications, and
expects a `start.sh` in the app directory, mounted at `/usr/src/app` by default.


Example docker-compose config:
```
services:
    app:
        image: leakypixel/elixir-phoenix-node
        expose:
          - 4000
        volumes:
          - "${PWD}:/usr/src/app"
        ports:
          - "4000:4000"
        environment:
          - "DATABASE_URL=ecto://postgres:postgres@postgres-db/my_app_dev?ssl=false&pool_size=10&timeout=150000"
  
    postgres-db:
        image: postgres
        expose:
          - 5432
        environment:
          - "POSTGRES_PASSWORD=postgres"
          - "POSTGRES_USER=postgres"
          - "POSTGRES_DB=my_app_dev"
  
```
