#!/bin/sh

cat <<EOF
define
{
    name = "services.host"
    value = "${ANOPE_SERVICES_VHOST:-services.localhost.net}"
}
EOF
