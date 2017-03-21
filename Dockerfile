FROM alpine:3.5

MAINTAINER Adam adam@anope.org
MAINTAINER Sheogorath <sheogorath@shivering-isles.com>

ARG VERSION=2.0
ARG ADDPACKAGES=
ARG DELPACKAGES=

RUN apk add --no-cache gcc g++ make libgcc libstdc++ git cmake gnutls gnutls-dev gnutls-utils $ADDPACKAGES && \
    # Create a user to run anope later
    adduser -u 10000 -h /anope/ -D -S anope && \
    mkdir -p /src && \
    cd /src && \
    # Clone the requested version
    git clone --depth 1 https://github.com/anope/anope.git anope -b $VERSION

RUN \
    cd /src/anope && \
    # Add and overwrite modules
    ln -s /src/anope/modules/extra/m_ssl_gnutls.cpp modules && \
    mkdir build && cd build && \
    cd /src/anope/build && \
    cmake -DINSTDIR=/anope/ -DDEFUMASK=077 -DCMAKE_BUILD_TYPE=RELEASE .. && \
    # Run build multi-threaded
    make -j`getconf _NPROCESSORS_ONLN` install && \
    # Uninstall all unnecessary tools after build process
    apk del gcc g++ make git cmake gnutls-dev $DELPACKAGES && \
    rm -rf /src && \
    # Keep example configs as good reference for users
    # Make sure the application is allowed to write to it's own direcotry for 
    # logging and generation of certificates
    chown -R anope /anope/

WORKDIR /anope/

USER anope
