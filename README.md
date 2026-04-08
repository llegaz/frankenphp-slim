# frankenphp-slim

[![CI](https://github.com/llegaz/frankenphp-slim/actions/workflows/ci.yaml/badge.svg)](https://github.com/llegaz/frankenphp-slim/actions/workflows/ci.yaml)

This project is largely inspired from [Kévin Dunglas](https://dunglas.dev)'s project Symfony Docker. it aims to provide a ready to use install for a slim project using frankenPHP server and vulcain / mercure technologies for SSE as well.

## Getting Started

1. If not already done, [install Docker Compose](https://docs.docker.com/compose/install/) (v2.10+)
2. Run `docker compose build --pull --no-cache` to build fresh images  
  
**optional**. If you have an existing Slim project you want to run just clone it (copy it) into this same project and rename its folder `src/`, like this:  
```text
    frankenphp-slim/
    ├─ frankenphp/
    ├─ src/
```
3. Run `docker compose up --wait` to set up and start a fresh Symfony project
4. Open `https://localhost` in your favorite web browser
5. Run `docker compose down --remove-orphans` to stop the Docker containers.

## Set the freshly generated Caddy certificate into your local browser
```bash
docker cp <container_name>:/data/caddy/pki/authorities/local/root.crt ./caddy-root.crt
```

### On Linux
```bash
sudo cp caddy-root.crt /usr/local/share/ca-certificates/caddy-root.crt
```
```bash
sudo update-ca-certificates
```bash

### On Mac
```bash
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain caddy-root.crt
```

## Features

- Production, development and CI ready
- Just 1 service by default
- Super-readable configuration
- Unfortunately [the worker mode of FrankenPHP](https://frankenphp.dev/docs/worker/) is not up in this version but you can set it or check on my next project [frankenphp-slim-enhanced](https://github.com/llegaz/frankenphp-slim-enhanced)
- [Installation of extra Docker Compose services](docs/extra-services.md) with Symfony Flex
- Automatic HTTPS (in dev and prod)
- HTTP/3 ready and HTTP/2 support
- Real-time messaging thanks to a built-in [Mercure hub](https://symfony.com/doc/current/mercure.html)
- [Vulcain](https://vulcain.rocks) support
- [Hot Reloading](https://frankenphp.dev/docs/hot-reload/)
- Rootless, slim production image
- This project should have a native [XDebug](docs/xdebug.md) integration (but I did not test it yet)

**Enjoy!**

## License

frankenphp-slim is available under the MIT License.

## Credits

By [Laurent Legaz](http://laurent.legaz.eu), largely inspired from [Kévin Dunglas](https://dunglas.dev)'s project Symfony Docker.

