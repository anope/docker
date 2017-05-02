#!/bin/sh

cat <<EOF
uplink
{
	/*
	 * The IP or hostname of the IRC server you wish to connect Services to.
	 * Usually, you will want to connect Services over 127.0.0.1 (aka localhost).
	 *
	 * NOTE: On some shell providers, this will not be an option.
	 */
	host = "$ANOPE_UPLINK_IP"

	/*
	 * Enable if Services should connect using IPv6.
	 */
	ipv6 = no

	/*
	 * Enable if Services should connect using SSL.
	 * You must have an SSL module loaded for this to work.
	 */
	ssl = no

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
