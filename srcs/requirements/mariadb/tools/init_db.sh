#!/bin/bash

service mariadb start

sleep 5

echo "MariaDB started"

mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME}";
mysql -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}'";
mysql -u root -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%'";
mysql -u root -e "FLUSH PRIVILEGES";

echo "Database initialization complete"

mysqladmin -u root shutdown

exec mysqld --user=mysql --bind-address=0.0.0.0
