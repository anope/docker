Anope
===

[![Build Status](https://travis-ci.org/Adam-/anope-docker.svg?branch=master)](https://travis-ci.org/Adam-/anope-docker)

Anope is a set of IRC Services designed for flexibility and ease of use.

Anope is a set of Services for IRC networks that allows users to manage their nicks and channels in a secure and efficient way, and administrators to manage their network with powerful tools.


# How to use this image

This image is not usable as stand alone image. You need some kind of IRCd.

For example you can use [InspIRCd](https://hub.docker.com/r/inspircd/inspircd-docker) like in the [example](https://github.com/Adam-/anope-docker/blob/master/examples/docker-compose.yml).

The minimal configuration looks like this:

```console
$ docker run --name anope -e "ANOPE_UPLINK_IP=irc.example.org" -e "ANOPE_UPLINK_PASSWORD=password"  anope/anope
```

You can use your own configs in this container by mounting them to `/anope/conf/`:

```console
$ docker run --name anope -v /path/to/your/config:/anope/conf/ anope/anope
```


## Generated configuration

This image provides various options to configure it by environment variables.

Use the following environment variables to configure your container:

|Available variables      |Default value                   |Description                                 |
|-------------------------|--------------------------------|--------------------------------------------|
|`ANOPE_SERVICES_NAME`    |`services.localhost.net`        |Name of the services. *Important for uplink*|
|`ANOPE_SERVICES_VHOST`   |`services.localhost.net`        |Host used by services pseudo clients        |
|`ANOPE_UPLINK_IP`        |no default                      |DNS name or IP of the uplink host           |
|`ANOPE_UPLINK_PORT`      |`7000`                          |Port used to connect to uplink host         |
|`ANOPE_UPLINK_PASSWORD`  |no default                      |Password used to authenticate against uplink|


## Database configuration

This image provides two way to configure database handling. You can use sqlite inside a volume or an external mysqldb.

SQLite is used by default to prevent failing of the container, but mysql is recommended.


### SQLite

For very small setup, development and testing SQLite setup should be enough. Simply make sure you mount a volume to `/data`.

```console
$ docker run --name anope -v "/path/to/datastore:/data" -e "ANOPE_UPLINK_IP=irc.example.org" -e "ANOPE_UPLINK_PASSWORD=password"  anope/anope
```

### MySQL

For a production setup MySQL is the recommended way to set this image up. Checkout the [example](https://github.com/Adam-/anope-docker/blob/master/examples/docker-compose.yml) if you want to test it.

|Available variables      |Default value                   |Description                                 |
|-------------------------|--------------------------------|--------------------------------------------|
|`ANOPE_SQL_ENGINE`       |`sqlite`                        |Set it to `mysql` to enable `mysql` backend |
|`ANOPE_MYSQL_DB`         |`anope`                         |Database name for the data                  |
|`ANOPE_MYSQL_HOST`       |`database`                      |Hostname of the database host or container  |
|`ANOPE_MYSQL_PORT`       |`3306`                          |Port used to access the mysql database      |
|`ANOPE_MYSQL_USER`       |`anope`                         |Username for the MySQL database             |
|`ANOPE_MYSQL_PASSWORD`   |no default                      |Password for the `ANOPE_MYSQL_USER`         |
|`ANOPE_SQL_LIVE`         |`no`                            |Enable Anope SQL-DB live feature            |


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

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/Adam-/anope-docker/issues).

You can also reach many of the project maintainers via the `#anope` IRC channel on [Teranova](http://www.teranova.net/).


## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

