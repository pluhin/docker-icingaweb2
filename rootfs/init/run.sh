#!/bin/sh
set -e

# Run setups
[ -x /init/icingaweb2-setup.sh ] && /init/icingaweb2-setup.sh

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2.pid

# Start Webserver
echo "Starting Webserver"
exec /usr/sbin/httpd -f /etc/apache2/httpd.conf -DFOREGROUND
