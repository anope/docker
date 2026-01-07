#!/bin/sh

cat <<EOF
/*
 * [REQUIRED] Network Information
 *
 * This section contains information about the IRC network that Services will be
 * connecting to.
 */
networkinfo
{
	/*
	 * This is the name of the network that Services will be running on.
	 */
	networkname = "${ANOPE_NETWORK_NAME:-LocalNet}"

	/*
	 * Set this to the maximum allowed nick length on your network.
	 * Be sure to set this correctly, as setting this wrong can result in
	 * Services being disconnected from the network.
	 */
	nicklen = ${ANOPE_NICKLEN:-31}

	/* Set this to the maximum allowed ident length on your network.
	 * Be sure to set this correctly, as setting this wrong can result in
	 * Services being disconnected from the network.
	 */
	userlen = ${ANOPE_USERLEN:-10}

	/* Set this to the maximum allowed hostname length on your network.
	 * Be sure to set this correctly, as setting this wrong can result in
	 * Services being disconnected from the network.
	 */
	hostlen = ${ANOPE_HOSTLEN:-64}

	/* Set this to the maximum allowed channel length on your network.
	 */
	chanlen = ${ANOPE_CHANLEN:-32}

	/* The maximum number of list modes settable on a channel (such as b, e, I).
	 * Comment out or set to 0 to disable.
	 */
	modelistsize = ${ANOPE_MODELISTSIZE:-100}

	/*
	 * Characters allowed in nicknames. This always includes the characters described
	 * in RFC1459, and so does not need to be set for normal behavior. Changing this to
	 * include characters your IRCd doesn't support will cause your IRCd and/or Services
	 * to break. Multibyte characters are not supported, nor are escape sequences.
	 *
	 * It is recommended you DON'T change this.
	 */
	#nick_chars = ""

	/*
	 * The characters allowed in hostnames. This is used for validating hostnames given
	 * to services, such as BotServ bot hostnames and user vhosts. Changing this is not
	 * recommended unless you know for sure your IRCd supports whatever characters you are
	 * wanting to use. Telling services to set a vHost containing characters your IRCd
	 * disallows could potentially break the IRCd and/or Services.
	 *
	 * It is recommended you DON'T change this.
	 */
	vhost_chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-"

	/*
	 * If set to true, allows vHosts to not contain dots (.).
	 * Newer IRCds generally do not have a problem with this, but the same warning as
	 * vhost_chars applies.
	 *
	 * It is recommended you DON'T change this.
	 */
	allow_undotted_vhosts = false

	/*
	 * The characters that are not allowed to be at the very beginning or very ending
	 * of a vHost. The same warning as vhost_chars applies.
	 *
	 * It is recommended you DON'T change this.
	 */
	disallow_start_or_end = ".-"
}
EOF
