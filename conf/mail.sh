#!/bin/sh

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

cat <<EOF
mail
{
	/*
	 * If set, this option enables the mail commands in Anope. You may choose
	 * to disable it if you have no Sendmail-compatible mailer installed. Whilst
	 * this directive (and entire block) is optional, it is required if
	 * nickserv:registration is set to mail.
	 */
	usemail = ${ANOPE_USEMAIL:-no}

	/*
	 * The command used for sending emails. It is assumed that this behaves like
	 * sendmail (i.e. it reads the email from the standard input stream) but you
	 * should probably use Postfix or some other sendmail-compatible emailer
	 * instead of sendmail as sendmail is very hard to configure correctly. If
	 * you are using Windows then https://www.glob.com.au/sendmail/ is probably
	 * the best option currently.
	 *
	 * If your emailer sends emails directly from the services host you will
	 * need to configure DKIM, DMARC, and SPF to avoid email hosts from marking
	 * your services emails as spam. It is important that you do this *BEFORE*
	 * sending emails for the first time as some email providers will add your
	 * host to a DNSBL like Spamhaus if they consider your emails to be spam. If
	 * this is too difficult then you may want to consider sending emails via an
	 * external email provider using a forwarder like msmtp.
	 */
	sendmailpath = "${ANOPE_SENDMAILPATH:-/usr/sbin/sendmail -t}"

	/*
	 * This is the email address from which all the emails are to be sent from.
	 * It should really exist.
	 */
	sendfrom = "${ANOPE_SENDFROM:-services@localhost.net}"

	/*
	 * This controls the minimum amount of time a user must wait before sending
	 * another email after they have sent one. It also controls the minimum time
	 * a user must wait before they can receive another email.
	 *
	 * This feature prevents users from being mail bombed using services and
	 * it is highly recommended that it be used.
	 *
	 * This directive is optional, but highly recommended.
	 */
	delay = ${ANOPE_MAILDELAY:-5m}

	/*
	 * If set, Anope will not put quotes around the TO: fields
	 * in emails.
	 *
	 * This directive is optional, and as far as we know, it's only needed
	 * if you are using ESMTP or QMail to send out emails.
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
	 *  {nick}    - Gets replaced with the nickname
	 *  {network} - Gets replaced with the network name
	 *  {code}    - Gets replaced with the confirmation code
	 */
	registration_subject = "${ANOPE_MAIL_REGISTRATION_SUBJECT:-Nickname registration for {nick}}"
	registration_message = "$ANOPE_MAIL_REGISTRATION_MESSAGE"

	/*
	 * The subject and message of emails sent to users when they request a new password.
	 *
	 * Available tokens for this template are:
	 *  {nick}    - Gets replaced with the nickname
	 *  {network} - Gets replaced with the network name
	 *  {code}    - Gets replaced with the confirmation code
	 */
	reset_subject = "${ANOPE_MAIL_RESET_SUBJECT:-Reset password request for {nick}}"
	reset_message = "$ANOPE_MAIL_RESET_MESSAGE"

	/*
	 * The subject and message of emails sent to users when they request a new email address.
	 *
	 * Available tokens for this template are:
	 *  {old_email} - Gets replaced with the old email address
	 *  {new_email} - Gets replaced with the new email address
	 *  {account}   - Gets replaced with the nickname
	 *  {network}   - Gets replaced with the network name
	 *  {code}      - Gets replaced with the confirmation code
	 */
	emailchange_subject = "${ANOPE_MAIL_EMAILCHANGE_SUBJECT:-Email confirmation}"
	emailchange_message = "$ANOPE_MAIL_EMAILCHANGE_MESSAGE"

	/*
	 * The subject and message of emails sent to users when they receive a new memo.
	 *
	 * Available tokens for this template are:
	 *  {receiver}  - Gets replaced with the receiver's nickname
	 *  {sender}    - Gets replaced with the sender's nickname
	 *  {number}    - Gets replaced with the memo number
	 *  {text}      - Gets replaced with the memo text
	 *  {network}   - Gets replaced with the network name
	 */
	memo_subject = "${ANOPE_MAIL_MEMO_SUBJECT:-New memo}"
	memo_message = "$ANOPE_MAIL_MEMO_MESSAGE"
}
EOF
