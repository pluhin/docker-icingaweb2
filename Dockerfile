FROM debian:buster
LABEL maintainer="pluhin@gmail.com"
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    apache2 \
    ca-certificates \
    curl \
    file \
    gnupg \
    libdigest-hmac-perl \
    locales \
    lsb-release \
    netbase \
    openssh-client \
    openssl \
    php-curl \
    php-ldap \
    php-pgsql \
    php-mbstring \
    php-gmp \
    procps \
    msmtp \
    sudo \
    supervisor \
    unzip \
    wget \
    && apt-get -y --purge remove exim4 exim4-base exim4-config exim4-daemon-light \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN export DEBIAN_FRONTEND=noninteractive \
    && curl -s https://packages.icinga.com/icinga.key \
    | apt-key add - \
    && echo "deb http://packages.icinga.org/debian icinga-$(lsb_release -cs) main" > /etc/apt/sources.list.d/icinga2.list \
    && echo "deb http://deb.debian.org/debian $(lsb_release -cs)-backports main" > /etc/apt/sources.list.d/$(lsb_release -cs)-backports.list \
    && apt-get update \
    && apt-get install -y --install-recommends \
    icingacli \
    icingaweb2 \
    icingaweb2-module-monitoring \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /usr/local/share/icingaweb2/modules/ \
    # Icingaweb2 Graphite
    && mkdir -p /usr/local/share/icingaweb2/modules/graphite \
    && wget -q --no-cookies -O - "https://github.com/Icinga/icingaweb2-module-graphite/archive/v1.1.0.tar.gz" \
    | tar xz --strip-components=1 --directory=/usr/local/share/icingaweb2/modules/graphite -f - \
    && true

ADD content/ /

# Final fixes
RUN true \
    && mv /etc/icingaweb2/ /etc/icingaweb2.dist \
    && usermod -aG icingaweb2 www-data \
    && chmod u+s,g+s \
    /bin/ping \
    /bin/ping6 

EXPOSE 80
# Initialize and run Supervisor
ENTRYPOINT ["/opt/run"]
