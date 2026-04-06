#!/bin/sh
set -e

if [ "$1" = 'frankenphp' ] || [ "$1" = 'php' ]; then
    if [ -z "$(ls -A 'src/' 2>/dev/null)" ]; then
        echo 'Installing Slim skeleton...'
        composer create-project slim/slim-skeleton /tmp/slim --prefer-dist --no-progress --no-interaction
        cp -r /tmp/slim/. /app/src/
        rm -rf /tmp/slim
        echo 'Slim skeleton installed!'
    elif [ -z "$(ls -A 'src/vendor/' 2>/dev/null)" ]; then
        echo 'Installing dependencies...'
        composer install \
            --working-dir=/app/src \
            --prefer-dist \
            --no-progress \
            --no-interaction
        echo 'Dependencies installed!'
    fi

    echo 'Slim app ready!'
fi

exec docker-php-entrypoint "$@"
