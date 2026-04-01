Anope
=====

Anope is a set of IRC Services designed for flexibility and ease of use.

Anope is a set of Services for IRC networks that allows users to manage their nicks and channels in a secure and efficient way, and administrators to manage their network with powerful tools.


# How to use this image

This image is not usable as stand alone image. You need some kind of IRCd.

For example you can use [InspIRCd](https://hub.docker.com/r/inspircd/inspircd-docker) like in the [example](https://github.com/anope/docker/blob/master/examples/docker-compose.yml).

The minimal configuration looks like this:

```console
$ docker run --name anope -e "ANOPE_UPLINK_IP=irc.example.org" -e "ANOPE_UPLINK_PASSWORD=password"  anope/anope
```

You can use your own configs in this container by mounting them to `/anope/conf/`:

```console
$ docker run --name anope -v /path/to/your/config:/anope/conf/ anope/anope
```


# Configuration

This image provides various options to configure it by environment variables.

## Server Information

|Available variables      |Default value                   |Description                                 |
|-------------------------|--------------------------------|--------------------------------------------|
|`ANOPE_SERVICES_NAME`    |`services.localhost.net`        |Name of the services. *Important for uplink*|
|`ANOPE_SERVICES_DESCRIPTION`|`Services for IRC Networks`  |Description of the services                 |
|`ANOPE_SERVICES_VHOST`   |`services.localhost.net`        |Host used by services pseudo clients        |

## Uplink Configuration

|Available variables      |Default value                   |Description                                 |
|-------------------------|--------------------------------|--------------------------------------------|
|`ANOPE_UPLINK_IP`        |no default                      |DNS name or IP of the uplink host           |
|`ANOPE_UPLINK_PORT`      |`7000`                          |Port used to connect to uplink host         |
|`ANOPE_UPLINK_PASSWORD`  |no default                      |Password used to authenticate against uplink|
|`ANOPE_UPLINK_PASSWORD_FILE`|no default                   |File containing password used to authenticate against uplink|
|`ANOPE_UPLINK_IPV6`      |`no`                            |Enable if Services should connect using IPv6|
|`ANOPE_UPLINK_SSL`       |`no`                            |Enable if Services should connect using SSL |

## Network Information

|Available variables      |Default value                   |Description                                 |
|-------------------------|--------------------------------|--------------------------------------------|
|`ANOPE_NETWORK_NAME`     |`LocalNet`                      |Name of the network                         |
|`ANOPE_NICKLEN`          |`31`                            |Maximum allowed nick length                 |
|`ANOPE_USERLEN`          |`10`                            |Maximum allowed ident length                |
|`ANOPE_HOSTLEN`          |`64`                            |Maximum allowed hostname length             |
|`ANOPE_CHANLEN`          |`32`                            |Maximum allowed channel length              |
|`ANOPE_MODELISTSIZE`     |`100`                           |Maximum number of list modes settable       |

## Options

|Available variables      |Default value                   |Description                                 |
|-------------------------|--------------------------------|--------------------------------------------|
|`ANOPE_CASEMAP`          |`ascii`                         |Case mapping used by services               |
|`ANOPE_BADPASSLIMIT`     |`5`                             |Invalid password tries before kill          |
|`ANOPE_BADPASSTIMEOUT`   |`1h`                            |Time after which invalid passwords are forgotten|
|`ANOPE_UPDATETIMEOUT`    |`2m`                            |Delay between automatic database updates    |
|`ANOPE_EXPIRETIMEOUT`    |`30m`                           |Delay between checks for expired nicks/chans|
|`ANOPE_READTIMEOUT`      |`5s`                            |Timeout period for reading from the uplink  |
|`ANOPE_TIMEOUTCHECK`     |`3s`                            |Frequency at which the timeout list is checked|
|`ANOPE_RETRYWAIT`        |`60s`                           |Wait time between connection retries        |
|`ANOPE_HIDEPRIVILEGEDCOMMANDS`|`yes`                      |Hide commands users can't execute           |
|`ANOPE_HIDEREGISTEREDCOMMANDS`|`yes`                      |Hide commands unregistered users can't execute|
|`ANOPE_DIDYOUMEANDIFFERENCE`|`4`                          |Max difference for command suggestions      |
|`ANOPE_CODELENGTH`       |`15`                            |Length of confirmation codes                |
|`ANOPE_LINELENGTH`       |`100`                           |Max bytes to wrap services messages         |
|`ANOPE_REGEXENGINE`      |`regex/stdlib`                  |Regex engine to use                         |
|`ANOPE_LANGUAGES`        |`de_DE.UTF-8 ...`               |List of languages to load                   |
|`ANOPE_DEFAULTLANGUAGE`  |`es_ES.UTF-8`                   |Default language for users                  |

## Mail Configuration

|Available variables      |Default value                   |Description                                 |
|-------------------------|--------------------------------|--------------------------------------------|
|`ANOPE_USEMAIL`          |`no`                            |Enable mail commands                        |
|`ANOPE_SENDMAILPATH`     |`/usr/sbin/sendmail -t`         |Command used for sending emails             |
|`ANOPE_SENDFROM`         |`services@localhost.net`        |Email address to send from                  |
|`ANOPE_MAILDELAY`        |`5m`                            |Minimum time between emails                 |
|`ANOPE_DONTQUOTEADDRESSES`|`yes`                          |Don't quote TO: fields                      |
|`ANOPE_MAIL_CONTENT_TYPE`|`text/plain; charset=UTF-8`     |Content type for emails                     |
|`ANOPE_MAIL_REGISTRATION_SUBJECT`|`Nickname registration for {nick}`|Subject for registration emails|
|`ANOPE_MAIL_REGISTRATION_MESSAGE`|no default              |Message for registration emails             |
|`ANOPE_MAIL_RESET_SUBJECT`|`Reset password request for {nick}`|Subject for password reset emails      |
|`ANOPE_MAIL_RESET_MESSAGE`|no default                     |Message for password reset emails           |
|`ANOPE_MAIL_EMAILCHANGE_SUBJECT`|`Email confirmation`     |Subject for email change emails             |
|`ANOPE_MAIL_EMAILCHANGE_MESSAGE`|no default               |Message for email change emails             |
|`ANOPE_MAIL_MEMO_SUBJECT`|`New memo`                      |Subject for memo emails                     |
|`ANOPE_MAIL_MEMO_MESSAGE`|no default                      |Message for memo emails                     |

## Webcpanel Configuration

|Available variables      |Default value                   |Description                                 |
|-------------------------|--------------------------------|--------------------------------------------|
|`ANOPE_WEBCPANEL_ENABLE` |`no`                            |Enable webcpanel                            |
|`ANOPE_WEBCPANEL_TITLE`  |`Anope IRC Services`            |Page title                                  |
|`ANOPE_HTTPD_IP`         |`0.0.0.0`                       |IP to listen on                             |
|`ANOPE_HTTPD_PORT`       |`8080`                          |Port to listen on                           |
|`ANOPE_HTTPD_SSL`        |`no`                            |Listen using SSL                            |

## Operators

You can configure up to 20 operators using indexed variables `ANOPE_x_...` where `x` is a number from 0 to 19.

|Available variables      |Default value                   |Description                                 |
|-------------------------|--------------------------------|--------------------------------------------|
|`ANOPE_x_NAME`           |no default                      |Oper's Nickname (Required)                  |
|`ANOPE_x_TYPE`           |`Services Root`                 |Opertype                                    |
|`ANOPE_x_REQUIRE_OPER`   |`yes`                           |Require the oper to be oper'd on the ircd   |
|`ANOPE_x_PASSWORD`       |no default                      |Optional password for oper access           |
|`ANOPE_x_PASSWORD_FILE`  |no default                      |File containing password for oper access    |
|`ANOPE_x_CERTFP`         |no default                      |Secure Cert finger print for oper access    |
|`ANOPE_x_HOST`           |no default                      |Space separated Hostmask(s) for this oper   |
|`ANOPE_x_VHOST`          |no default                      |Oper Vhost                                  |

Available `ANOPE_x_TYPE` values (from `services.conf`):
*   `Services Root` (Default): Full access to all commands and privileges.
*   `Services Administrator`: Access to most administrative commands (BotServ, ChanServ, NickServ, OperServ, Global).
*   `Services Operator`: Access to basic operator commands (ChanServ, MemoServ, NickServ, OperServ).
*   `Helper`: Access to HostServ commands.


## Database Configuration

This image provides two way to configure database handling. You can use sqlite inside a volume or an external mysqldb.

SQLite is used by default to prevent failing of the container, but mysql is recommended.


### SQLite

For very small setup, development and testing SQLite setup should be enough. Simply make sure you mount a volume to `/data`.

```console
$ docker run --name anope -v "/path/to/datastore:/data" -e "ANOPE_UPLINK_IP=irc.example.org" -e "ANOPE_UPLINK_PASSWORD=password"  anope/anope
```

### MySQL

For a production setup MySQL is the recommended way to set this image up. Checkout the [example](https://github.com/anope/docker/blob/master/examples/docker-compose.yml) if you want to test it.

|Available variables      |Default value                   |Description                                 |
|-------------------------|--------------------------------|--------------------------------------------|
|`ANOPE_SQL_ENGINE`       |`sqlite`                        |Set it to `mysql` to enable `mysql` backend |
|`ANOPE_MYSQL_DB`         |`anope`                         |Database name for the data                  |
|`ANOPE_MYSQL_HOST`       |`database`                      |Hostname of the database host or container  |
|`ANOPE_MYSQL_PORT`       |`3306`                          |Port used to access the mysql database      |
|`ANOPE_MYSQL_USER`       |`anope`                         |Username for the MySQL database             |
|`ANOPE_MYSQL_PASSWORD`   |no default                      |Password for the `ANOPE_MYSQL_USER`         |
|`ANOPE_MYSQL_PASSWORD_FILE`|no default                    |File containing password for the `ANOPE_MYSQL_USER`|
|`ANOPE_SQL_LIVE`         |`no`                            |Enable Anope SQL-DB live feature            |
|`ANOPE_SQL_PREFIX`       |`anope_db_`                     |Prefix for SQL tables                       |
|`ANOPE_SQL_IMPORT`       |`false`                         |Import data from another DB module on startup|


# Updates and updating

To update your setup simply pull the newest image version from docker hub and run it.

```console
$ docker pull anope/anope
```

Considering to update your docker setup regularly.


# License

View [license information](https://github.com/anope/anope) for the software contained in this image.


# Supported Docker versions

This image is officially supported on Docker version 17.03.1-CE.

Support for older versions (down to 1.12) is provided on a best-effort basis.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.


# User Feedback

## Issues

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/anope/docker/issues).

You can also reach many of the project maintainers via the `#anope` IRC channel on [Teranova](http://www.teranova.net/).


## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.
