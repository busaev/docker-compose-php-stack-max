FROM php:7.2-fpm
WORKDIR "/application"

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive

# staff
RUN apt-get update \
    && apt-get -y --no-install-recommends install net-tools git curl gnupg make zip libicu-dev gzip zlib1g-dev libxml2-dev libpq-dev libyaml-dev libmcrypt-dev libmemcached-dev libtidy-dev libxslt-dev libpng-dev libzmq3-dev

RUN docker-php-ext-install -j$(nproc) iconv intl xml soap opcache pdo pdo_mysql pgsql pdo_pgsql mysqli tidy mbstring exif xsl gd

RUN pecl install redis-4.0.1 \
    && pecl install xdebug-2.6.1 \
    && pecl install memcached-3.0.4 \
    && pecl install yaml-2.0.2 \
    && pecl install mongodb-1.5.3 \
    && pecl install msgpack \
    && pecl install zmq-1.1.3 \
    && docker-php-ext-enable redis xdebug memcached yaml mongodb msgpack zmq \
    &&  rm -rf /tmp/pear

#composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer

# NodeJS
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - \
    && apt-get update && apt-get install -y nodejs \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

COPY ./conf.d/20_opcache.ini /usr/local/etc/php/conf.d/20_opcache.ini
COPY ./conf.d/20_xdebug.ini /usr/local/etc/php/conf.d/20_xdebug.ini

RUN HOST_IP="$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')" \
    && sed -i "$ a\xdebug.remote_host=${HOST_IP}"