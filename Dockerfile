FROM alpine:3.18

LABEL org.opencontainers.image.authors="Anope Team <team@anope.org>"

ARG VERSION=2.0
ARG RUN_DEPENDENCIES="gnutls gnutls-utils mariadb-client mariadb-connector-c sqlite-libs"
ARG BUILD_DEPENDENCIES="gnutls-dev mariadb-dev sqlite-dev"
ARG EXTRA_MODULES="m_mysql m_sqlite m_ssl_gnutls"

RUN apk add --no-cache --virtual .build-utils gcc g++ ninja git cmake $BUILD_DEPENDENCIES && \
    apk add --no-cache --virtual .dependencies libgcc libstdc++ $RUN_DEPENDENCIES && \
    # Create a user to run anope later
    adduser -u 10000 -h /anope/ -D -S anope && \
    mkdir -p /src && \
    cd /src && \
    # Clone the requested version
    git clone --depth 1 https://github.com/anope/anope.git anope -b $VERSION && \
    cd /src/anope && \
    # Add and overwrite modules
    for module in $EXTRA_MODULES; do ln -s /src/anope/modules/extra/$module.cpp modules; done && \
    mkdir build && \
    cd /src/anope/build && \
    cmake -DINSTDIR=/anope/ -DDEFUMASK=077 -DCMAKE_BUILD_TYPE=RELEASE -GNinja .. && \
    # Run build multi-threaded
    ninja install && \
    # Uninstall all unnecessary tools after build process
    apk del .build-utils && \
    rm -rf /src && \
    # Provide a data location
    mkdir -p /data && \
    touch /data/anope.db && \
    ln -s /data/anope.db /anope/data/anope.db && \
    # Make sure everything is owned by anope
    chown -R anope /anope/ && \
    chown -R anope /data/

COPY ./conf/ /anope/conf/

RUN chown -R anope /anope/conf/

WORKDIR /anope/

VOLUME /data/

USER anope

CMD ["/anope/bin/services", "-n"]
