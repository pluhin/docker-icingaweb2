#!/bin/sh
set -e


# Set icinga2 api pass
if [ -n "$ICINGA_API_PASS" ] ; then
  sed -r -i "s/^password = .*/password = \"${ICINGA_API_PASS}\"/g" \
    /etc/icingaweb2/modules/monitoring/commandtransports.ini

  if [ -e /etc/icingaweb2/modules/director/kickstart.ini ] ; then
    sed -r -i "s/^password = .*/password = \"${ICINGA_API_PASS}\"/g" \
      /etc/icingaweb2/modules/director/kickstart.ini
  fi
fi