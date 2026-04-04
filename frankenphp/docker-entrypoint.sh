#!/bin/sh
set -e

if [ "$1" = 'frankenphp' ] || [ "$1" = 'php' ] || [ "$1" = 'bin/console' ]; then
	###> dunglas/symfony-docker ###
	# Install the project the first time PHP is started
	# This block will remove itself after the installation
	if [ "$(cat composer.json)" = '{}' ]; then
		rm -Rf tmp/
		composer create-project "slim/slim-skeleton" --prefer-dist --no-progress --no-interaction --no-install

		cd tmp
                cd ../
                cd tmp
		cp -Rp . ..
		cd -
		rm -Rf tmp/

		composer require "php:>=$PHP_VERSION"
		composer config --json extra.symfony.docker 'true'

		# Remove the project install block from this script and the compose.yaml
		sed -i '/^\t###> dunglas\/symfony-docker ###/,/^\t###< dunglas\/symfony-docker ###/d' frankenphp/docker-entrypoint.sh
		sed -i '/###> dunglas\/symfony-docker ###/,/###< dunglas\/symfony-docker ###/d' compose.yaml

		if grep -q ^DATABASE_URL= .env; then
			echo 'To finish the installation please press Ctrl+C to stop Docker Compose and run: docker compose up --build --wait'
			sleep infinity
		fi
	fi
	###< dunglas/symfony-docker ###

	if [ -z "$(ls -A 'vendor/' 2>/dev/null)" ]; then
		composer install --prefer-dist --no-progress --no-interaction
	fi

	echo 'PHP app ready!'
fi

exec docker-php-entrypoint "$@"
