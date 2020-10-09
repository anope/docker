FROM alpine:3.12

MAINTAINER Adam adam@anope.org
MAINTAINER Sheogorath <sheogorath@shivering-isles.com>

ARG VERSION=2.0
ARG RUN_DEPENDENCIES=
ARG BUILD_DEPENDENCIES=

RUN apk add --no-cache --virtual .build-utils gcc g++ make git cmake gnutls-dev sqlite-dev mariadb-dev $BUILD_DEPENDENCIES && \
    apk add --no-cache --virtual .dependencies libgcc libstdc++ gnutls gnutls-utils sqlite-libs mariadb-client mariadb-connector-c $RUN_DEPENDENCIES && \
    # Create a user to run anope later
    adduser -u 10000 -h /anope/ -D -S anope && \
    mkdir -p /src && \
    cd /src && \
    # Clone the requested version
    git clone --depth 1 https://github.com/anope/anope.git anope -b $VERSION && \
    cd /src/anope && \
    # Add and overwrite modules
    ln -s /src/anope/modules/extra/m_ssl_gnutls.cpp modules && \
    ln -s /src/anope/modules/extra/m_mysql.cpp modules && \
    ln -s /src/anope/modules/extra/m_sqlite.cpp modules && \
    mkdir build && \
    cd /src/anope/build && \
    cmake -DINSTDIR=/anope/ -DDEFUMASK=077 -DCMAKE_BUILD_TYPE=RELEASE .. && \
    # Run build multi-threaded
    make -j`getconf _NPROCESSORS_ONLN` install && \
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
