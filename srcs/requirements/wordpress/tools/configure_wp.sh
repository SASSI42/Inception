#!/bin/bash

sleep 30

wp core download --allow-root

chown -R www-data:www-data /var/www/html

wp config create \
    --dbname=${DB_NAME} \
    --dbuser=${DB_USER} \
    --dbpass=${DB_PASSWORD} \
    --dbhost=mariadb \
    --allow-root

wp core install \
    --url=${DOMAIN_NAME} \
    --title="${WP_TITLE}" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --skip-email \
    --allow-root

wp user create \
    ${DB_USER} \
    "user@${DOMAIN_NAME}" \
    --user_pass=${DB_PASSWORD} \
    --role=author \
    --allow-root
exec php-fpm8.2 -F