#!/bin/sh

if [ "${ANOPE_WEBCPANEL_ENABLE:-no}" = "yes" ]; then

cat <<EOF
/*
 * webcpanel
 *
 * This module creates a web configuration panel that allows users and operators to perform any task
 * as they could over IRC. If you are using the default configuration you should be able to access
 * this panel by visiting http://127.0.0.1:8080 in your web browser from the machine Anope is running on.
 *
 * This module requires httpd.
 */
module
{
	name = "webcpanel"

	/* Web server to use. */
	server = "httpd/main";

	/* Template to use. */
	template = "default";

	/* Page title. */
	title = "${ANOPE_WEBCPANEL_TITLE:-Anope IRC Services}";
}

/*
 * m_httpd
 *
 * Allows services to serve web pages. By itself, this module does nothing useful.
 *
 * Note that using this will allow users to get the IP of your services.
 * To prevent this we recommend using a reverse proxy or a tunnel.
 */
module
{
	name = "m_httpd"

	httpd
	{
		/* Name of this service. */
		name = "httpd/main"

		/* IP to listen on. */
		ip = "${ANOPE_HTTPD_IP:-0.0.0.0}"

		/* Port to listen on. */
		port = ${ANOPE_HTTPD_PORT:-8080}

		/* Time before connections to this server are timed out. */
		timeout = 30

		/* Listen using SSL. Requires an SSL module. */
		ssl = ${ANOPE_HTTPD_SSL:-no}

		/* If you are using a reverse proxy that sends one of the
		 * extforward_headers set below, set this to its IP.
		 * This allows services to obtain the real IP of users by
		 * reading the forwarded-for HTTP header.
		 * Multiple IP addresses can be specified separated by a space character.
		 */
		#extforward_ip = "192.168.0.255 192.168.1.255"

		/* The header to look for. These probably work as is. */
		extforward_header = "X-Forwarded-For Forwarded-For"
	}
}
EOF

fi
