#!/bin/sh

if [ -n "$ANOPE_UPLINK_PASSWORD_FILE" ]; then
	ANOPE_UPLINK_PASSWORD=$(cat "$ANOPE_UPLINK_PASSWORD_FILE")
fi

# Determine protocol based on ANOPE_UPLINK_IPV6
if [ "${ANOPE_UPLINK_IPV6:-no}" = "yes" ]; then
	PROTOCOL="ipv6"
else
	PROTOCOL="ipv4"
fi

cat <<EOF
uplink
{
	/*
	 * The IP address, hostname, or UNIX socket path of the IRC server you wish
	 * to connect Anope to.
	 * Usually, you will want to connect over 127.0.0.1 (aka localhost).
	 *
	 * NOTE: On some shell providers, this will not be an option.
	 */
	host = "$ANOPE_UPLINK_IP"

	/*
	 * The protocol that Anope should use when connecting to the uplink. Can
	 * be set to "ipv4" (the default), "ipv6", or "unix".
	 */
	protocol = "$PROTOCOL"

	/*
	 * Enable if Anope should connect using SSL.
	 * You must have an SSL module loaded for this to work.
	 */
	ssl = ${ANOPE_UPLINK_SSL:-no}

	/*
	 * The port to connect to.
	 * The IRCd *MUST* be configured to listen on this port, and to accept
	 * server connections.
	 *
	 * Refer to your IRCd documentation for how this is to be done.
	 */
	port = ${ANOPE_UPLINK_PORT:-7000}

	/*
	 * The password to send to the IRC server for authentication.
	 * This must match the link block on your IRCd.
	 *
	 * Refer to your IRCd documentation for more information on link blocks.
	 */
	password = "${ANOPE_UPLINK_PASSWORD}"
}

EOF
