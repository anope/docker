#!/bin/sh

cat <<EOF
/*
 * [REQUIRED] Services Options
 *
 * This section contains various options which determine how Services will operate.
 */
options
{
	/*
	 * On Linux/UNIX systems Anope can setuid and setgid to this user and group
	 * after starting up. This is useful if Anope has to bind to privileged ports
	 */
	#user = "anope"
	#group = "anope"

	/*
	 * The case mapping used by services. This must be set to a valid locale name
	 * installed on your machine. Services use this case map to compare, with
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
	 * This key is used to initiate the random number generator. This number
	 * MUST be random as you want your passcodes to be random. Don't give this
	 * key to anyone! Keep it private!
	 *
	 * NOTE: If you don't uncomment this or keep the default values, any talented
	 * programmer would be able to easily "guess" random strings used to mask
	 * information. Be safe, and come up with a 7-digit number.
	 *
	 * This directive is optional, but highly recommended.
	 */
	#seed = 9866235

	/*
	 * If set, Services will perform more stringent checks on passwords. If this
	 * isn't set, Services will only disallow a password if it is the same as the
	 * entity (nickname name) with which it is associated. When set, however,
	 * Services will also check that the password is at least five
	 * characters long, and in the future will probably check other things
	 * as well.
	 *
	 * This directive is optional, but recommended.
	 */
	strictpasswords = yes

	/*
	 * Sets the number of invalid password tries before Services removes a user
	 * from the network. If a user enters a number of invalid passwords equal to
	 * the given amount for any Services function or combination of functions
	 * during a single IRC session (subject to badpasstimeout, below), Services
	 * will issues a /KILL for the user. If not given, Services will ignore
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
	 * such as nick kills, occur; it also determines how much CPU time Services
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
	 * If set, this will allow users to let Services send PRIVMSGs to them
	 * instead of NOTICEs. Also see the "msg" option of nickserv:defaults,
	 * which also toggles the default communication (PRIVMSG or NOTICE) to
	 * use for unregistered users.
	 *
	 * This is a feature that is against the IRC RFC and should be used ONLY
	 * if absolutely necessary.
	 *
	 * This directive is optional, and not recommended.
	 */
	#useprivmsg = yes

	/*
	 * If set, will force Services to only respond to PRIVMSGs addresses to
	 * Nick@ServerName - e.g. NickServ@example.com. This should be used in
	 * conjunction with IRCd aliases. This directive is optional.
	 *
	 * This option will have no effect on some IRCds, such as TS6 IRCds.
	 */
	#usestrictprivmsg = yes

	/*
	 * If set, Services will only show /stats o to IRC Operators. This directive
	 * is optional.
	 */
	#hidestatso = yes

	/*
	 * A space-separated list of U-lined servers on your network, it is assumed that
	 * the servers in this list are allowed to set channel modes and Services will
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
	 * If set, Services will hide commands that users don't have the privilege to execute
	 * from HELP output.
	 */
	hideprivilegedcommands = ${ANOPE_HIDEPRIVILEGEDCOMMANDS:-yes}

	/*
	 * If set, Services will hide commands that users can't execute because they are not
	 * logged in from HELP output.
	 */
	hideregisteredcommands = ${ANOPE_HIDEREGISTEREDCOMMANDS:-yes}

	/* The regex engine to use, as provided by the regex modules.
	 * Leave commented to disable regex matching.
	 *
	 * Note for this to work the regex module providing the regex engine must be loaded.
	 */
EOF

if [ -n "$ANOPE_REGEXENGINE" ]; then
    echo "	regexengine = \"$ANOPE_REGEXENGINE\""
else
    echo "	#regexengine = \"regex/pcre\""
fi

cat <<EOF

	/*
	 * A list of languages to load on startup that will be available in /NICKSERV SET LANGUAGE.
	 * Useful if you translate Anope to your language. (Explained further in docs/LANGUAGE).
	 * Note that English should not be listed here because it is the base language.
	 *
	 * Removing .UTF-8 will instead use the default encoding for the language, e.g. iso-8859-1 for western European languages.
	 */
	languages = "${ANOPE_LANGUAGES:-ca_ES.UTF-8 de_DE.UTF-8 el_GR.UTF-8 es_ES.UTF-8 fr_FR.UTF-8 hu_HU.UTF-8 it_IT.UTF-8 nl_NL.UTF-8 pl_PL.UTF-8 pt_PT.UTF-8 ru_RU.UTF-8 tr_TR.UTF-8}"

	/*
	 * Default language that non- and newly-registered nicks will receive messages in.
	 * Set to "en" to enable English. Defaults to the language the system uses.
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
