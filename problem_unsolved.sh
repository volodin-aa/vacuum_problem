#!/bin/bash


RECORDS=1000000

PSQL="psql -p 5433 -X"



echo 1. Create table vacuum_table

$PSQL -1 -c "drop table if exists vacuum_table; create table vacuum_table (id integer primary key)"

echo 2. Insert $RECORDS records into vacuum_table

$PSQL -1 -c "insert into vacuum_table (id) (select generate_series(1, $RECORDS) id)"

TSIZE=$($PSQL -At -v table_schema="'public'" -v table_name="'vacuum_table'" -f table_size.sql)

echo 3. After insert $RECORDS records table size is: $TSIZE

echo 4. Check autovacuum: AUTOVACUUM is $($PSQL -At -c 'show autovacuum')

echo 5. Update table vacuum_table

$PSQL -1 -c "update vacuum_table set id = id"

TSIZE=$($PSQL -X -At -v table_schema="'public'" -v table_name="'vacuum_table'" -f table_size.sql)

echo 6. After update $RECORDS records table size is: $TSIZE

$PSQL -1 -c 'select pg_sleep(120)' &
PID=$!

echo 7. Run long live transaction pid: $PID

echo 8. Run VACUUM FULL

$PSQL -1 -c 'VACUUM FULL'

TSIZE=$($PSQL -X -At -v table_schema="'public'" -v table_name="'vacuum_table'" -f table_size.sql)

echo 9. After VACUUM FULL table size is: $TSIZE

echo 10. New update table vacuum_table

$PSQL -1 -c "update vacuum_table set id = id"

TSIZE=$($PSQL -X -At -v table_schema="'public'" -v table_name="'vacuum_table'" -f table_size.sql)

echo 11. Run VACUUM FULL

$PSQL -1 -c 'VACUUM FULL'

TSIZE=$($PSQL -X -At -v table_schema="'public'" -v table_name="'vacuum_table'" -f table_size.sql)


echo 12. After new update and VACUUM FULL table size is: $TSIZE

echo 13. Second update table vacuum_table

$PSQL -1 -c "update vacuum_table set id = id"

TSIZE=$($PSQL -X -At -v table_schema="'public'" -v table_name="'vacuum_table'" -f table_size.sql)

echo 14. Run VACUUM FULL

$PSQL -1 -c 'VACUUM FULL'

TSIZE=$($PSQL -X -At -v table_schema="'public'" -v table_name="'vacuum_table'" -f table_size.sql)


echo 15. After second update and VACUUM FULL table size is: $TSIZE

echo 16. Killing long live transaction

kill -9 $PID
$PSQL -1 -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE query='select pg_sleep(120)'"

echo 17. Run VACUUM FULL

$PSQL -1 -c 'VACUUM FULL'

TSIZE=$($PSQL -X -At -v table_schema="'public'" -v table_name="'vacuum_table'" -f table_size.sql)

echo 18. After killing and VACUUM FULL table size is: $TSIZE

