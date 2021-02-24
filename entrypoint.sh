#!/bin/bash

BENCH_TYPE=OLTP

wait-for-it $MYSQL_HOST:3306 || exit 1

sysbench --db-driver=mysql --oltp-table-size=100000 --oltp-tables-count=24 --threads=1 --mysql-host=$MYSQL_HOST --mysql-port=$MYSQL_PORT --mysql-user=$MYSQL_USER --mysql-password=$MYSQL_PASSWORD /usr/share/sysbench/tests/include/oltp_legacy/parallel_prepare.lua run

sysbench --db-driver=mysql --report-interval=2 --mysql-table-engine=innodb --oltp-table-size=100000 --oltp-tables-count=24 --threads=64 --time=99999 --mysql-host=$MYSQL_HOST --mysql-port=$MYSQL_PORT --mysql-user=$MYSQL_USER --mysql-password=$MYSQL_PASSWORD /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua run
