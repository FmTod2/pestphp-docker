# Set PHP extensions to install
ARG PHP_EXTS="bcmath mbstring pdo_mysql pcntl gd intl soap exif gd imagick igbinary redis opcache zip"

# Base Image
FROM serversideup/php:8.2-cli-alpine

# Set the user to root to install dependencies
USER root

# Argument to select the Pest version (default is 3)
ARG PEST_VERSION=3
ENV PEST_VERSION=${PEST_VERSION}

# Use the PHP_EXTS build argument
ARG PHP_EXTS

# Install additional PHP extensions
RUN install-php-extensions ${PHP_EXTS}

# PHP configuration (use official development file)
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Xdebug configuration
ENV XDEBUG_MODE=coverage,debug

# Install Pest according to the provided version
RUN composer global config allow-plugins "true"
RUN composer global require pestphp/pest:^${PEST_VERSION} --no-progress --no-suggest

# PATH configuration to use Pest from anywhere
ENV PATH="$PATH:/composer/vendor/bin"

# Set the user to run the tests
USER www-data

# Working directory (optional, configurable by the user)
WORKDIR /app

# Default command (run Pest in the current folder)
ENTRYPOINT ["pest"]

