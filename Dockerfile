FROM haproxy:2.1.4

ENV HAPROXY_DATAPLANEAPI_TAG v2.0.0
ENV HAPROXY_DATAPLANEAPI_PORT 5555
ENV HAPROXY_DATAPLANEAPI_USERLIST dataplaneapi
ENV HAPROXY_DATAPLANEAPI_TRANSACTION_DIR /tmp/haproxy
ENV HAPROXY_DATAPLANEAPI_MAPS_DIR /usr/local/etc/haproxy/maps

RUN set -xe \
    && apt-get update \
    && apt-get install -y \
      git \
      golang \
      make \
    && git clone --branch v2.0.0 https://github.com/haproxytech/dataplaneapi.git \
    && eval "(cd dataplaneapi; make build)" \
    && mv /dataplaneapi/build/dataplaneapi /usr/local/bin/dataplaneapi \
    && rm -rf /dataplaneapi

COPY hapapi-entrypoint.sh /
COPY reload.sh /
COPY restart.sh /

STOPSIGNAL SIGUSR1

ENTRYPOINT ["/hapapi-entrypoint.sh"]
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
