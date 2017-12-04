#!/bin/sh

chmod +x /usr/bin/gosu
chown -R kapacitor:kapacitor /var/lib/kapacitor

echo "Start Kapacitor"
/usr/bin/gosu kapacitor /usr/bin/kapacitord -pidfile /tmp/kapicitor.pid