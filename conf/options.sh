#!/bin/sh

cat <<EOF
options
{
	/*
	 * On Linux/UNIX systems Anope can setuid and setgid to this user and group
	 * after starting up. This is useful if Anope has to bind to privileged ports.
	 */
	#user = "anope"
	#group = "anope"

	/*
	 * The case mapping used by services. This must be set to a valid locale name
	 * installed on your machine. Anope uses this case map to compare, with
	 * case insensitivity, things such as nick names, channel names, etc.
	 *
	 * We provide two special casemaps shipped with Anope, ascii and rfc1459.
	 *
	 * This value should be set to what your IRCd uses, which is probably rfc1459,
	 * however Anope has always used ascii for comparison, so the default is ascii.
	 *
	 * Changing this value once set is not recommended.
	 */
	casemap = "${ANOPE_CASEMAP:-ascii}"

	/*
	 * Sets the number of invalid password tries before services removes a user
	 * from the network. If a user enters a number of invalid passwords equal to
	 * the given amount for any services function or combination of functions
	 * during a single IRC session (subject to badpasstimeout, below), services
	 * will issues a /KILL for the user. If not given, services will ignore
	 * failed password attempts (though they will be logged in any case).
	 *
	 * This directive is optional, but recommended.
	 */
	badpasslimit = ${ANOPE_BADPASSLIMIT:-5}

	/*
	 * Sets the time after which invalid passwords are forgotten about. If a user
	 * does not enter any incorrect passwords in this amount of time, the incorrect
	 * password count will reset to zero. If not given, the timeout will be
	 * disabled, and the incorrect password count will never be reset until the user
	 * disconnects.
	 *
	 * This directive is optional.
	 */
	badpasstimeout = ${ANOPE_BADPASSTIMEOUT:-1h}

	/*
	 * Sets the delay between automatic database updates.
	 */
	updatetimeout = ${ANOPE_UPDATETIMEOUT:-2m}

	/*
	 * Sets the delay between checks for expired nicknames and channels.
	 */
	expiretimeout = ${ANOPE_EXPIRETIMEOUT:-30m}

	/*
	 * Sets the timeout period for reading from the uplink.
	 */
	readtimeout = ${ANOPE_READTIMEOUT:-5s}

	/*
	 * Sets the (maximum) frequency at which the timeout list is checked. This,
	 * combined with readtimeout above, determines how accurately timed events,
	 * such as nick kills, occur; it also determines how much CPU time services
	 * will use doing this. Higher values will cause less accurate timing but
	 * less CPU usage.
	 *
	 * Note that this value is not an absolute limit on the period between
	 * checks of the timeout list; the previous may be as great as readtimeout
	 * (above) during periods of inactivity.
	 *
	 * If this directive is not given, it will default to 0.
	 */
	timeoutcheck = ${ANOPE_TIMEOUTCHECK:-3s}

	/*
	 * If set Anope will tell users to use a server-side alias for messaging
	 * services instead of /msg. The alias for each service defaults to the
	 * bot name but can be configured in the service block.
	 */
	#servicealias = yes

	/*
	 * If set, Anope will only show /stats o to IRC Operators. This directive
	 * is optional.
	 */
	#hidestatso = yes

	/*
	 * A space-separated list of U-lined servers on your network, it is assumed that
	 * the servers in this list are allowed to set channel modes and Anope will
	 * not attempt to reverse their mode changes.
	 *
	 * WARNING: Do NOT put your normal IRC user servers in this directive.
	 *
	 * This directive is optional.
	 */
	#ulineservers = "stats.your.network"

	/*
	 * How long to wait between connection retries with the uplink(s).
	 */
	retrywait = ${ANOPE_RETRYWAIT:-60s}

	/*
	 * If set, services will hide commands that users don't have the privilege to execute
	 * from HELP output.
	 */
	hideprivilegedcommands = ${ANOPE_HIDEPRIVILEGEDCOMMANDS:-yes}

	/*
	 * If set, services will hide commands that users can't execute because they are not
	 * logged in from HELP output.
	 */
	hideregisteredcommands = ${ANOPE_HIDEREGISTEREDCOMMANDS:-yes}

	/*
	 * If set, the maximum difference between an invalid and valid command name to allow
	 * as a suggestion. Defaults to 4.
	 */
	didyoumeandifference = ${ANOPE_DIDYOUMEANDIFFERENCE:-4}

	/*
	 * The length of codes used for confirming actions like dropping a channel or a
	 * nickname.
	 *
	 * Defaults to 15 if not set.
	 */
	codelength = ${ANOPE_CODELENGTH:-15}

	/*
	 * If set, the maximum number of bytes after which to wrap services messages. This
	 * can be set a bit higher than the default but should be well under the maximum
	 * message length imposed by your IRC server or messages will end up truncated.
	 *
	 * NOTE: this currently only applies to tables but will be expanded to all messages
	 * in a later release.
	 *
	 * Defaults to 100 if not set.
	 */
	linelength = ${ANOPE_LINELENGTH:-100}

	/* The regex engine to use, as provided by the regex modules.
	 * Leave commented to disable regex matching.
	 *
	 * Note for this to work the regex module providing the regex engine must be loaded.
	 */
	#regexengine = "regex/stdlib"

	/*
	 * A list of languages to load on startup that will be available in /NICKSERV SET LANGUAGE.
	 * Useful if you translate Anope to your language. (Explained further in docs/LANGUAGE).
	 * Note that English should not be listed here because it is the base language.
	 *
	 * Removing .UTF-8 will instead use the default encoding for the language, e.g. iso-8859-1 for western European languages.
	 */
	languages = "${ANOPE_LANGUAGES:-de_DE.UTF-8 el_GR.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 it_IT.UTF-8 nl_NL.UTF-8 pl_PL.UTF-8 pt_PT.UTF-8 ro_RO.UTF-8 tr_TR.UTF-8}"

	/*
	 * Default language that unregistered users and users of newly-registered
	 * accounts will receive messages in.
	 *
	 * Defaults to the language the system uses. Set to "en_US" to override this
	 * with English.
 	 */
EOF

if [ -n "$ANOPE_DEFAULTLANGUAGE" ]; then
    echo "	defaultlanguage = \"$ANOPE_DEFAULTLANGUAGE\""
else
    echo "	#defaultlanguage = \"es_ES.UTF-8\""
fi

cat <<EOF
}
EOF
