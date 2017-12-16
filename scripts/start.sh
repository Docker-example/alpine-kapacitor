#!/bin/sh

chown -R kapacitor:kapacitor /var/lib/kapacitor
exec su-exec kapacitor /usr/bin/kapacitord -pidfile /tmp/kapicitor.pid