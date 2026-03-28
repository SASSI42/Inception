FROM debian:oldstable

RUN apt update && apt upgrade -y && \
    apt install -y \
    php-fpm \
    php-mysql \
    curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/run/php && chown -R www-data:www-data /var/run/php

WORKDIR /var/www/html



RUN sed -i 's/^listen = .*/listen = 0.0.0.0:9000/' /etc/php/8.2/fpm/pool.d/www.conf
COPY tools/configure_wp.sh /tmp/configure_wp.sh
RUN chmod +x /tmp/configure_wp.sh

CMD ["/tmp/configure_wp.sh"]