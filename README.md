# frankenphp-slim

[![CI](https://github.com/llegaz/frankenphp-slim/actions/workflows/ci.yaml/badge.svg)](https://github.com/llegaz/frankenphp-slim/actions/workflows/ci.yaml)

This project is largely inspired from [Kévin Dunglas](https://dunglas.dev)'s project [Symfony Docker](https://github.com/dunglas/symfony-docker), it aims to provide a ready to use install for a slim project using frankenPHP server and vulcain / mercure technologies for SSE and hot reloading.

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

## Add the authority to the trust store of the host
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

## Deploying

Copy your project on the server using `git clone`, `scp`, or any other tool
that may fit your need.
If you use GitHub, you may want to use [a deploy key](https://docs.github.com/en/free-pro-team@latest/developers/overview/managing-deploy-keys#deploy-keys).
Deploy keys are also [supported by GitLab](https://docs.gitlab.com/user/project/deploy_keys/).

Example with Git:

```console
git clone git@github.com:<username>/<project-name>.git
```

Go into the directory containing your project (`<project-name>`),
and start the app in production mode:

```console
# Build fresh production image
docker compose -f compose.yaml -f compose.prod.yaml build --pull --no-cache

# Start container
SERVER_NAME=your-domain-name.example.com \
APP_SECRET=ChangeMe \
CADDY_MERCURE_JWT_SECRET=ChangeThisMercureHubJWTSecretKey \
docker compose -f compose.yaml -f compose.prod.yaml up --wait
```

Be sure to replace `your-domain-name.example.com` with your actual domain name
and to set the values of `APP_SECRET`, `CADDY_MERCURE_JWT_SECRET`
to cryptographically secure random values.

Your server is up and running, and a HTTPS certificate has been automatically
generated for you.
Go to `https://your-domain-name.example.com` and **enjoy!**

> [!CAUTION]
>
> Docker can have a cache layer, make sure you have the right build
> for each deployment or rebuild your project with `--no-cache` option
> to avoid cache issues.

## Disabling HTTPS

Alternatively, if you don't want to expose an HTTPS server but only an HTTP one,
run the following command:

```console
SERVER_NAME=:80 \
APP_SECRET=ChangeMe \
CADDY_MERCURE_JWT_SECRET=ChangeThisMercureHubJWTSecretKey \
docker compose -f compose.yaml -f compose.prod.yaml up --wait
```

## Deploying on Multiple Nodes

If you want to deploy your app on a cluster of machines, you can use [Docker Swarm](https://docs.docker.com/engine/swarm/stack-deploy/),
which is compatible with the provided Compose files.
To deploy on Kubernetes, take a look
at [the Helm chart provided with API Platform](https://api-platform.com/docs/deployment/kubernetes/),
which can be easily adapted for use with Symfony Docker.

## Passing local environment variables to containers

By default, `.env.local` and `.env.*.local` files are excluded from production images.
If you want to pass them to your containers, you can use the [`env_file` attribute](https://docs.docker.com/compose/how-tos/environment-variables/set-environment-variables/#use-the-env_file-attribute):

```yaml
# compose.prod.yaml

services:
  php:
    env_file:
      - .env.prod.local
    # ...
```

## License

frankenphp-slim is available under the MIT License.

## Credits

By [Laurent Legaz](http://laurent.legaz.eu), largely inspired from [Kévin Dunglas](https://dunglas.dev)'s project [Symfony Docker](https://github.com/dunglas/symfony-docker).

