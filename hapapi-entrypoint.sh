#!/bin/sh

echo -n $$ > /haproxy.pid

mkdir -p $HAPROXY_DATAPLANEAPI_TRANSACTION_DIR
mkdir -p $HAPROXY_DATAPLANEAPI_MAPS_DIR

/usr/bin/nohup /usr/local/bin/dataplaneapi \
 --port $HAPROXY_DATAPLANEAPI_PORT \
 -b /usr/local/sbin/haproxy \
 -c /usr/local/etc/haproxy/haproxy.cfg \
 -d 5 \
 -r "/reload.sh" \
 -s "/restart.sh" \
 -u $HAPROXY_DATAPLANEAPI_USERLIST \
 -t $HAPROXY_DATAPLANEAPI_TRANSACTION_DIR \
 -p $HAPROXY_DATAPLANEAPI_MAPS_DIR &

exec /docker-entrypoint.sh "$@"
