FROM katorlys/workspace-base:latest

# Run as root
USER root

# Install PHP & extensions
RUN PHP_VERSION=$(curl -s https://www.php.net/releases/index.php?json | jq -r '[.[] | select(.museum != true) | .version | select(test("^[0-9]+\\.[0-9]+\\.[0-9]+$"))] | sort_by(split(".") | map(tonumber)) | last | split(".")[0:2] | join(".")') && \
	add-apt-repository -y ppa:ondrej/php && \
	DEBIAN_FRONTEND="noninteractive" apt-get update -y && apt-get install -y --no-install-recommends \
	php${PHP_VERSION} \
	php${PHP_VERSION}-bcmath \
	php${PHP_VERSION}-cli \
	php${PHP_VERSION}-curl \
	php${PHP_VERSION}-intl \
	php${PHP_VERSION}-mbstring \
	php${PHP_VERSION}-mysql \
	php${PHP_VERSION}-sqlite3 \
	php${PHP_VERSION}-xml \
	php${PHP_VERSION}-zip && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# Set back to non-root user
USER dev

# Install development tools
RUN composer global require \
	friendsofphp/php-cs-fixer \
	laravel/installer \
	phpstan/phpstan \
	phpunit/phpunit \
	squizlabs/php_codesniffer && \
	composer clear-cache