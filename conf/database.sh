#!/bin/sh

if [ "$ANOPE_SQL_LIVE" = "yes" ]; then
    ANOPE_SQL_LIVE="_live"
else
    ANOPE_SQL_LIVE=""
fi

cat <<EOF

/*
 * db_sql and db_sql_live
 *
 * db_sql module allows saving and loading databases using one of the SQL engines.
 * This module loads the databases once on startup, then incrementally updates
 * objects in the database as they are changed within Anope in real time. Changes
 * to the SQL tables not done by Anope will have no effect and will be overwritten.
 *
 * db_sql_live module allows saving and loading databases using one of the SQL engines.
 * This module reads and writes to SQL in real time. Changes to the SQL tables
 * will be immediately reflected into Anope. This module should not be loaded
 * in conjunction with db_sql.
 *
 */
module
{
	name = "db_sql${ANOPE_SQL_LIVE}"

	/*
	 * The SQL service db_sql(_live) should use, these are configured in modules.conf.
	 * For MySQL, this should probably be mysql/main.
	 */
	engine = "${ANOPE_SQL_ENGINE:-sqlite}/main"

	/*
	 * An optional prefix to prepended to the name of each created table.
	 * Do not use the same prefix for other programs.
	 */
	#prefix = "anope_db_"

	/* Whether or not to import data from another database module in to SQL on startup.
	 * If you enable this, be sure that the database services is configured to use is
	 * empty and that another database module to import from is loaded before db_sql.
	 * After you enable this and do a database import you should disable it for
	 * subsequent restarts.
	 *
	 * Note that you can not import databases using db_sql_live. If you want to import
	 * databases and use db_sql_live you should import them using db_sql, then shut down
	 * and start services with db_sql_live.
	 */
	import = false
}
EOF

if [ "$ANOPE_SQL_ENGINE" = "mysql" ]; then

cat <<EOF
/*
 * m_mysql [EXTRA]
 *
 * This module allows other modules to use MySQL.
 */
module
{
	name = "m_mysql"

	mysql
	{
		/* The name of this service. */
		name = "mysql/main"
		database = "${ANOPE_MYSQL_DB:-anope}"
		server = "${ANOPE_MYSQL_HOST:-database}"
		port = ${ANOPE_MYSQL_PORT:-3306}
		username = "${ANOPE_MYSQL_USER:-anope}"
		password = "$ANOPE_MYSQL_PASSWORD"
	}
}
EOF

# Use SQLite as default
else

cat <<EOF
/*
 * m_sqlite [EXTRA]
 *
 * This module allows other modules to use SQLite.
 */
module
{
	name = "m_sqlite"

	/* A SQLite database */
	sqlite
	{
		/* The name of this service. */
		name = "sqlite/main"

		/* The database name, it will be created if it does not exist. */
		database = "anope.db"
	}
}
EOF
fi
