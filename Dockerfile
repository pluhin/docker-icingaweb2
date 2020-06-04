FROM alpine:3.10

LABEL maintainer="pluhin@gmail.com"

ENV REFRESHED_AT="2020-05-26"\
    TIMEZONE="UTC" 

RUN apk add --no-cache \
      postgresql-client \
      ca-certificates openssl \
      php7 php7-apache2 php7-pdo_pgsql php7-openssl php7-intl php7-ldap php7-gettext \
      php7-ctype php7-json php7-mbstring php7-session php7-curl php7-iconv php7-pcntl \
      php7-posix php7-sockets \
    && ln -sf /usr/bin/php7 /usr/bin/php \
    && mkdir -p /run/apache2 \
    && sed -r -i "s~^;?date.timezone =.*~date.timezone = ${TIMEZONE:-UTC}~" /etc/php7/php.ini \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache icingaweb2

ADD rootfs /

RUN mkdir -p /usr/share/webapps/icingaweb2/modules/ \
    && mkdir -p /usr/share/webapps/icingaweb2/modules/graphite \
    && wget -q -O - "https://github.com/Icinga/icingaweb2-module-graphite/archive/v1.1.0.tar.gz" \
    | tar xz --strip-components=1 --directory=/usr/share/webapps/icingaweb2/modules/graphite -f - 
    

RUN cp -a /temp/icingaweb2 /etc \
    && icingacli module enable monitoring \
    && icingacli module enable graphite \
    && cp -r /usr/share/webapps/icingaweb2/modules/graphite/templates /etc/icingaweb2/modules/graphite \
    && chown -R apache /etc/icingaweb2
EXPOSE 80

CMD ["/init/run.sh"]

