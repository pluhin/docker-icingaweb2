FROM alpine:3.10

LABEL maintainer="pluhin@gmail.com"

ENV REFRESHED_AT="2020-05-20"\
    ICINGAWEB_VERSION="2.8.0-rc1" \
    TIMEZONE="UTC" \
    ICINGAWEB_AUTOCONF=true \
    ICINGA_API_PASS="super-secret" \
    WEB_DB_HOST="" \
    WEB_DB_PORT="5432" \
    WEB_DB_USER="icingaweb" \
    WEB_DB_PASS="" \
    WEB_DB="icingaweb2" \
    IDO_DB_HOST="" \
    IDO_DB_USER="icinga" \
    IDO_DB_PASS="" \
    IDO_DB="icinga2"

RUN apk add --no-cache \
      postgresql-client \
      ca-certificates openssl \
      php7 php7-apache2 php7-pdo_pgsql php7-openssl php7-intl php7-ldap php7-gettext \
      php7-ctype php7-json php7-mbstring php7-session php7-curl php7-iconv php7-pcntl \
      php7-posix php7-sockets icingaweb2 &&  \
    ln -sf /usr/bin/php7 /usr/bin/php && \
    mkdir -p /run/apache2 && \
    echo "Fetch Icingaweb2 ${ICINGAWEB_VERSION}" && \
    sed -r -i "s~^;?date.timezone =.*~date.timezone = ${TIMEZONE:-UTC}~" /etc/php7/php.ini

ADD rootfs /

RUN cp -a /temp/icingaweb2 /etc && \
    icingacli module enable monitoring && \
    chown -R apache /etc/icingaweb2
EXPOSE 80

CMD ["/init/run.sh"]

