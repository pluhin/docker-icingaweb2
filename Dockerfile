FROM alpine:3.10

LABEL maintainer="pluhin@gmail.com"

ENV REFRESHED_AT="2020-05-18"\
    ICINGAWEB_VERSION="2.7.3" \
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
      php7-posix php7-sockets && \
    ln -sf /usr/bin/php7 /usr/bin/php && \
    mkdir -p /run/apache2 && \
    echo "Fetch Icingaweb2 ${ICINGAWEB_VERSION}" && \
    mkdir /icingaweb2 && \
    wget -q -O - https://github.com/Icinga/icingaweb2/archive/v${ICINGAWEB_VERSION}.tar.gz \
      | tar xz --strip 1 -C /icingaweb2 && \
    ln -s /icingaweb2/bin/icingacli /usr/bin/icingacli && \
    chown -R apache /icingaweb2 && \
    mkdir -p /var/log/icingaweb2 && \
    chown -R apache /var/log/icingaweb2

ADD rootfs /

EXPOSE 80

CMD ["/init/run.sh"]

