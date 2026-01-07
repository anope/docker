#!/bin/sh

sanitize() {
	printf "%s" "$1" | awk '
		BEGIN { ORS="" }
		{
			gsub(/\\/, "\\\\")
			gsub(/"/, "\\\"")
			if (NR > 1) print "\\n"
			print $0
		}
	'
}

if [ -z "$ANOPE_MAIL_REGISTRATION_MESSAGE" ]; then
    ANOPE_MAIL_REGISTRATION_MESSAGE="Hi,

				You have requested to register the nickname {nick} on {network}.
				Please type \" /msg NickServ CONFIRM REGISTER {code} \" to complete registration.

				If you don't know why this mail was sent to you, please ignore it silently.

				{network} administrators."
fi

if [ -z "$ANOPE_MAIL_RESET_MESSAGE" ]; then
    ANOPE_MAIL_RESET_MESSAGE="Hi,

			You have requested to have the password for {nick} reset.
			To reset your password, type \" /msg NickServ CONFIRM RESETPASS {nick} {code} \"

			If you don't know why this mail was sent to you, please ignore it silently.

			{network} administrators."
fi

if [ -z "$ANOPE_MAIL_EMAILCHANGE_MESSAGE" ]; then
    ANOPE_MAIL_EMAILCHANGE_MESSAGE="Hi,

			You have requested to change your email address from {old_email} to {new_email}.
			Please type \" /msg NickServ CONFIRM EMAIL {code} \" to confirm this change.

			If you don't know why this mail was sent to you, please ignore it silently.

			{network} administrators."
fi

if [ -z "$ANOPE_MAIL_MEMO_MESSAGE" ]; then
    ANOPE_MAIL_MEMO_MESSAGE="Hi {receiver},

			You've just received a new memo from {sender}. This is memo number {number}.

			Memo text:

			{text}"
fi

ANOPE_MAIL_REGISTRATION_MESSAGE=$(sanitize "$ANOPE_MAIL_REGISTRATION_MESSAGE")
ANOPE_MAIL_RESET_MESSAGE=$(sanitize "$ANOPE_MAIL_RESET_MESSAGE")
ANOPE_MAIL_EMAILCHANGE_MESSAGE=$(sanitize "$ANOPE_MAIL_EMAILCHANGE_MESSAGE")
ANOPE_MAIL_MEMO_MESSAGE=$(sanitize "$ANOPE_MAIL_MEMO_MESSAGE")

cat <<EOF
/*
 * [OPTIONAL] Mail Config
 *
 * This section contains settings related to the use of e-mail from Services.
 * If the usemail directive is set to yes, unless specified otherwise, all other
 * directives are required.
 *
 * NOTE: Users can find the IP of the machine services is running on by examining
 * mail headers. If you do not want your IP known, you should set up a mail relay
 * to strip the relevant headers.
 */
mail
{
	/*
	 * If set, this option enables the mail commands in Services. You may choose
	 * to disable it if you have no Sendmail-compatible mailer installed. Whilst
	 * this directive (and entire block) is optional, it is required if
	 * nickserv:registration is set to mail.
	 */
	usemail = ${ANOPE_USEMAIL:-no}

	/*
	 * This is the command-line that will be used to call the mailer to send an
	 * e-mail. It must be called with all the parameters needed to make it
	 * scan the mail input to find the mail recipient; consult your mailer
	 * documentation.
	 *
	 * Postfix users must use the compatible sendmail utility provided with
	 * it. This one usually needs no parameters on the command-line. Most
	 * sendmail applications (or replacements of it) require the -t option
	 * to be used.
	 */
	sendmailpath = "${ANOPE_SENDMAILPATH:-/usr/sbin/sendmail -t}"

	/*
	 * This is the e-mail address from which all the e-mails are to be sent from.
	 * It should really exist.
	 */
	sendfrom = "${ANOPE_SENDFROM:-services@localhost.net}"

	/*
	 * This controls the minimum amount of time a user must wait before sending
	 * another e-mail after they have sent one. It also controls the minimum time
	 * a user must wait before they can receive another e-mail.
	 *
	 * This feature prevents users from being mail bombed using Services and
	 * it is highly recommended that it be used.
	 *
	 * This directive is optional, but highly recommended.
	 */
	delay = ${ANOPE_MAILDELAY:-5m}

	/*
	 * If set, Services will not attempt to put quotes around the TO: fields
	 * in e-mails.
	 *
	 * This directive is optional, and as far as we know, it's only needed
	 * if you are using ESMTP or QMail to send out e-mails.
	 */
	#dontquoteaddresses = ${ANOPE_DONTQUOTEADDRESSES:-yes}

	/*
	 * The content type to use when sending emails.
	 *
	 * This directive is optional, and is generally only needed if you want to
	 * use HTML or non UTF-8 text in your services emails.
	 */
	#content_type = "${ANOPE_MAIL_CONTENT_TYPE:-text/plain; charset=UTF-8}"

	/*
	 * The subject and message of emails sent to users when they register accounts.
	 *
	 * Available tokens for this template are:
	 *  %n - Gets replaced with the nickname
	 *  %N - Gets replaced with the network name
	 *  %c - Gets replaced with the confirmation code
	 */
	registration_subject = "${ANOPE_MAIL_REGISTRATION_SUBJECT:-Nickname registration for {nick}}"
	registration_message = "$ANOPE_MAIL_REGISTRATION_MESSAGE"

	/*
	 * The subject and message of emails sent to users when they request a new password.
	 *
	 * Available tokens for this template are:
	 *  %n - Gets replaced with the nickname
	 *  %N - Gets replaced with the network name
	 *  %c - Gets replaced with the confirmation code
	 */
	reset_subject = "${ANOPE_MAIL_RESET_SUBJECT:-Reset password request for {nick}}"
	reset_message = "$ANOPE_MAIL_RESET_MESSAGE"

	/*
	 * The subject and message of emails sent to users when they request a new email address.
	 *
	 * Available tokens for this template are:
	 *  %e - Gets replaced with the old email address
	 *  %E - Gets replaced with the new email address
	 *  %n - Gets replaced with the nickname
	 *  %N - Gets replaced with the network name
	 *  %c - Gets replaced with the confirmation code
	 */
	emailchange_subject = "${ANOPE_MAIL_EMAILCHANGE_SUBJECT:-Email confirmation}"
	emailchange_message = "$ANOPE_MAIL_EMAILCHANGE_MESSAGE"

	/*
	 * The subject and message of emails sent to users when they receive a new memo.
	 *
	 * Available tokens for this template are:
	 *  %n - Gets replaced with the nickname
	 *  %s - Gets replaced with the sender's nickname
	 *  %d - Gets replaced with the memo number
	 *  %t - Gets replaced with the memo text
	 *  %N - Gets replaced with the network name
	 */
	memo_subject = "${ANOPE_MAIL_MEMO_SUBJECT:-New memo}"
	memo_message = "$ANOPE_MAIL_MEMO_MESSAGE"
}
EOF
