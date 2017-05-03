#!/bin/sh

if [ "$1" = "--help" ]; then
    echo "
    Usage of $0:
        $0 <PREFIX> <VERSION> <SUFFIX>

    Example:
        $0 anope 2.0.24 alpine
    "
fi

PREFIX=${1:-anope}
VERSION=${2}
[ "${3}" != "" ] && [ "${3}" != "debian" ] && SUFFIX="-${3}"



if [ "$VERSION" != "" ]; then
    docker tag anope:testing "$PREFIX:$(echo "${VERSION}" | cut -d. -f1)${SUFFIX}"
    docker tag anope:testing "$PREFIX:$(echo "${VERSION}" | cut -d. -f1-2)${SUFFIX}"
    docker tag anope:testing "$PREFIX:$(echo "${VERSION}" | cut -d. -f1-3)${SUFFIX}"
    [ "$SUFFIX" = "" ] && docker tag anope:testing "$PREFIX:latest"
else
    echo "No version provided. Skipping tagging..."
fi
