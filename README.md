# frankenphp-slim

[![CI](https://github.com/llegaz/frankenphp-slim/actions/workflows/ci.yaml/badge.svg)](https://github.com/llegaz/frankenphp-slim/actions/workflows/ci.yaml)


## dev memo [TODO: remove this]

```bash
sudo cp -r ./* /opt/frankenphp-slim/
docker exec -it frankenphp-slim-php-1 bash
docker compose logs php
docker exec -it <container_name> sh -c "composer require llegaz/redis-cache --working-dir=/app/src"
```

## Getting Started

1. If not already done, [install Docker Compose](https://docs.docker.com/compose/install/) (v2.10+)
2. Run `docker compose build --pull --no-cache` to build fresh images
3. Run `docker compose up --wait` to set up and start a fresh Symfony project
4. Open `https://localhost` in your favorite web browser
5. Run `docker compose down --remove-orphans` to stop the Docker containers.


## License

frankenphp-slim is available under the MIT License.

## Credits

Created by [Laurent Legaz](http://laurent.legaz.eu) from [Kévin Dunglas](https://dunglas.dev)'s project Symfony Docker.

