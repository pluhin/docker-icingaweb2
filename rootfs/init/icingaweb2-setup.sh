#!/bin/sh
set -e

# Set timezone for PHP
sed -r -i "s~^;?date.timezone =.*~date.timezone = ${TIMEZONE:-UTC}~" /etc/php7/php.ini

[ "$ICINGAWEB_AUTOCONF" == false ] && exit 0 || true

# Enable modules
if [ ! -e /etc/icingaweb2/enabledModules ] || [ $(ls -1 /etc/icingaweb2/enabledModules | wc -l) -le 0 ] ; then
  icingacli module enable monitoring
fi

# Setup resources.ini
# if [ ! -e /etc/icingaweb2/resources.ini ]; then
#   while read line; do
#     eval echo "$line"
#   done < /temp/resources.ini > /etc/icingaweb2/resources.ini
# fi

# Set icinga2 api pass
if [ -n "$ICINGA_API_PASS" ] ; then
  sed -r -i "s/^password = .*/password = \"${ICINGA_API_PASS}\"/g" \
    /etc/icingaweb2/modules/monitoring/commandtransports.ini

  if [ -e /etc/icingaweb2/modules/director/kickstart.ini ] ; then
    sed -r -i "s/^password = .*/password = \"${ICINGA_API_PASS}\"/g" \
      /etc/icingaweb2/modules/director/kickstart.ini
  fi
fi