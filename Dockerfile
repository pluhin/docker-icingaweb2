FROM alpine:latest

LABEL maintainer="pluhin@gmail.com"

ENV REFRESHED_AT="2020-06-25"\
    TIMEZONE="UTC" 

RUN mkdir -p /run/apache2 \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
    && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache icingaweb2 \
    && sed -r -i "s~^;?date.timezone =.*~date.timezone = ${TIMEZONE:-UTC}~" /etc/php7/php.ini

ADD rootfs /

RUN mkdir -p /usr/share/webapps/icingaweb2/modules/ \
    && mkdir -p /usr/share/webapps/icingaweb2/modules/graphite \
    && wget -q -O - "https://github.com/Icinga/icingaweb2-module-graphite/archive/v1.1.0.tar.gz" \
    | tar xz --strip-components=1 --directory=/usr/share/webapps/icingaweb2/modules/graphite -f - 
    

RUN cp -a /temp/icingaweb2 /etc \
    && icingacli module enable monitoring \
    && icingacli module enable graphite
EXPOSE 80

CMD ["/init/run.sh"]

