
PostgreSQL 9.4
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



