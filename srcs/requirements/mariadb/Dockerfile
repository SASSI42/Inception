FROM debian:oldstable

RUN apt update && apt upgrade -y && \
    apt install -y mariadb-server  &&\
    mkdir -p /var/run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

COPY tools/init_db.sh /tmp/init_db.sh
RUN chmod +x /tmp/init_db.sh

CMD ["/tmp/init_db.sh"]