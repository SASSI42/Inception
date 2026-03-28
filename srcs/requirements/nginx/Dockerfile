FROM debian:oldstable

ARG DOMAIN_NAME

RUN apt update && apt upgrade -y && \
    apt install -y nginx openssl

RUN mkdir -p /etc/ssl/private /etc/ssl/certs

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt \
    -subj "/CN=${DOMAIN_NAME}"

COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf


CMD ["nginx",  "-g", "daemon off;"]