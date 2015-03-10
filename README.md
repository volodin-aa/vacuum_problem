
PostgreSQL 9.4 (100K records)
----------------

1. Create table vacuum_table
CREATE TABLE
2. Insert 100000 records into vacuum_table
INSERT 0 100000
3. After insert 100000 records table size is: 5914624
4. Check autovacuum: AUTOVACUUM is off
5. Update table vacuum_table
UPDATE 100000
6. After update 100000 records table size is: 14032896
7. Run long live transaction pid: 25211
8. Run VACUUM FULL
VACUUM
9. After VACUUM FULL table size is: 5890048
10. Killing long live transaction
11. Run VACUUM FULL
VACUUM
12. After VACUUM FULL table size is: 5890048


PostgreSQL 9.3 (1M records)
-------------------

1. Create table vacuum_table
CREATE TABLE
2. Insert 1000000 records into vacuum_table
INSERT 0 1000000
3. After insert 1000000 records table size is: 58769408
4. Check autovacuum: AUTOVACUUM is off
5. Update table vacuum_table
UPDATE 1000000
6. After update 1000000 records table size is: 140017664
7. Run long live transaction pid: 26649
8. Run VACUUM FULL
VACUUM
9. After VACUUM FULL table size is: 58736640
10. Killing long live transaction
11. Run VACUUM FULL
VACUUM
12. After VACUUM FULL table size is: 58736640


PostgreSQL 9.3 (1M records), обновление записей после запуска параллельной транзакции
-------------------

1. Create table vacuum_table
CREATE TABLE
2. Insert 1000000 records into vacuum_table
INSERT 0 1000000
3. After insert 1000000 records table size is: 58769408
4. Check autovacuum: AUTOVACUUM is on
5. Update table vacuum_table
UPDATE 1000000
6. After update 1000000 records table size is: 140017664
7. Run long live transaction pid: 32474
8. Run VACUUM FULL
VACUUM
9. After VACUUM FULL table size is: 58736640
10. New update table vacuum_table
UPDATE 1000000
11. Run VACUUM FULL
VACUUM
12. After new update and VACUUM FULL table size is: 117448704
13. Second update table vacuum_table
UPDATE 1000000
14. Run VACUUM FULL
VACUUM
15. After second update and VACUUM FULL table size is: 176152576
16. Killing long live transaction
17. Run VACUUM FULL
VACUUM
18. After killing and VACUUM FULL table size is: 176152576
