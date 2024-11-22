# Base Image
FROM serversideup/php:8.2-cli-alpine

# Maintainer information (opcional, pero recomendado)
LABEL maintainer="Your Name <your.email@example.com>"

# Argumento para seleccionar la versión de Pest (por defecto 3)
ARG PEST_VERSION=3
ENV PEST_VERSION=${PEST_VERSION}

# Configurar PHP con Xdebug y extensiones necesarias
RUN apk add --no-cache \
    autoconf \
    build-base \
    bash \
    libtool \
    icu-dev \
    libxml2-dev \
    libpng-dev \
    imagemagick-dev \
    libzip-dev \
    oniguruma-dev \
    && docker-php-ext-install \
    bcmath \
    mbstring \
    pdo_mysql \
    pcntl \
    gd \
    intl \
    soap \
    exif \
    zip \
    && pecl install \
    redis \
    imagick \
    igbinary \
    && docker-php-ext-enable \
    redis \
    imagick \
    igbinary \
    opcache \
    && apk del autoconf build-base libtool

# Configuración de PHP (usar archivo oficial de desarrollo)
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

# Configuración de Xdebug
ENV XDEBUG_MODE=coverage,debug

# Instalación de Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Instalación de Pest según la versión proporcionada
RUN composer global require pestphp/pest:${PEST_VERSION} --no-progress --no-suggest

# Configuración de PATH para usar Pest desde cualquier lugar
ENV PATH="$PATH:/root/.composer/vendor/bin"

# Directorio de trabajo (opcional, configurable por el usuario)
WORKDIR /app

# Permitir configuraciones adicionales vía ENV
ENV CUSTOM_CONFIG="default"

# Comando predeterminado (ejecutar Pest en la carpeta actual)
CMD ["pest"]