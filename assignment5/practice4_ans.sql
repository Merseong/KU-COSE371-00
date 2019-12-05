-- download files on Blackboard
SET enable_bitmapscan = false;
SET max_parallel_workers_per_gather = 0;

-- Index & Scan
-- 1
CREATE INDEX ON table1 (Sorted);

-- Using Seq Scan
SELECT * FROM table1;
EXPLAIN ANALYZE SELECT * FROM table1;

-- Using Index Scan
SELECT sorted, rndm FROM table1 WHERE sorted = 1999231;
EXPLAIN ANALYZE SELECT sorted, rndm FROM table1 WHERE sorted = 1999231;

-- Using Index Only Scan
SELECT count(sorted) FROM table1 WHERE sorted = 1999231;
EXPLAIN ANALYZE SELECT count(sorted) FROM table1 WHERE sorted = 1999231;

SELECT sorted FROM table1 WHERE sorted = 1999231;
EXPLAIN ANALYZE SELECT sorted FROM table1 WHERE sorted = 1999231;

-- 2
CREATE INDEX ON table1 (Unsorted);
CLUSTER table1 USING table1_sorted_idx;

-- clustered index
EXPLAIN ANALYZE SELECT sorted, rndm FROM table1 WHERE sorted > 1999231;

-- non-clustered index
EXPLAIN ANALYZE SELECT sorted, rndm FROM table1 WHERE unsorted > 1999231;

-- 3
EXPLAIN ANALYZE SELECT sorted , rndm FROM table1 where sorted > 1999231 and rndm= 1005; -- fast
EXPLAIN ANALYZE SELECT sorted , rndm FROM table1 where sorted < 1999231 and rndm= 1005; -- slow
-- Cardinality of sorted is 2000000. So, filtering under 1999231 makes many rows to compare rndm.

-- B+ tree & Hash
SET enable_bitmapscan=false;

-- 1
CREATE INDEX ON table_btree USING btree (recordid);
CREATE INDEX ON table_hash USING hash (recordid);

-- 2
EXPLAIN ANALYZE Select * from table_btree where recordid = 10001;
EXPLAIN ANALYZE Select * from table_hash where recordid = 10001;

-- 3
EXPLAIN ANALYZE Select * from table_btree where recordid > 250 and recordid < 550;
EXPLAIN ANALYZE Select * from table_hash where recordid > 250 and recordid < 550;

-- 4
EXPLAIN ANALYZE UPDATE table_btree
    SET recordid = 9999998
    WHERE recordid = 9999997;
EXPLAIN ANALYZE UPDATE table_noindex
    SET recordid = 9999998
    WHERE recordid = 9999997;

-- 5
EXPLAIN ANALYZE UPDATE table_btree
    SET recordid = recordid * 2
    WHERE recordid > 8000000;
EXPLAIN ANALYZE UPDATE table_noindex
    SET recordid = recordid * 2
    WHERE recordid > 8000000;

-- 6
EXPLAIN ANALYZE UPDATE table_btree
    SET recordid = recordid * 1.1;
EXPLAIN ANALYZE UPDATE table_noindex
    SET recordid = recordid * 1.1;