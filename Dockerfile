FROM alpine:3.23 AS builder

ARG VERSION=2.0
ARG BUILD_DEPENDENCIES="gnutls-dev mariadb-dev sqlite-dev"
ARG EXTRA_MODULES="m_mysql m_sqlite m_ssl_gnutls"

RUN apk add --no-cache gcc g++ ninja git cmake $BUILD_DEPENDENCIES && \
    mkdir -p /src && \
    cd /src && \
    git clone --depth 1 https://github.com/anope/anope.git anope -b $VERSION && \
    cd /src/anope && \
    for module in $EXTRA_MODULES; do ln -s /src/anope/modules/extra/$module.cpp modules; done && \
    mkdir build && \
    cd /src/anope/build && \
    cmake -DINSTDIR=/anope/ -DDEFUMASK=077 -DCMAKE_BUILD_TYPE=RELEASE -GNinja .. && \
    ninja install

FROM alpine:3.23

LABEL org.opencontainers.image.authors="Anope Team <team@anope.org>"

ARG RUN_DEPENDENCIES="gnutls gnutls-utils mariadb-client mariadb-connector-c sqlite-libs"

RUN apk add --no-cache libgcc libstdc++ $RUN_DEPENDENCIES && \
    adduser -u 10000 -h /anope/ -D -S anope && \
    mkdir -p /data && \
    touch /data/anope.db

COPY --from=builder /anope /anope

RUN ln -s /data/anope.db /anope/data/anope.db && \
    chown -R anope /anope/ && \
    chown -R anope /data/

COPY ./conf/ /anope/conf/

RUN chown -R anope /anope/conf/ && \
    chmod 755 /anope/conf/*.sh

WORKDIR /anope/

VOLUME /data/

USER anope

CMD ["/anope/bin/services", "--nofork"]
