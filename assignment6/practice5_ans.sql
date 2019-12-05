-- 1 Equivalent SQL Statements Exercise
\c assignment4
SET enable_bitmapscan = false;
SET max_parallel_workers_per_gather = 0;

--- a
SELECT DISTINCT unsorted FROM table1 WHERE unsorted BETWEEN 967 AND 969;

--- b
SELECT DISTINCT unsorted FROM table1 WHERE unsorted IN (967, 968, 969);

--- c
SELECT DISTINCT unsorted FROM table1 WHERE unsorted = 967 OR unsorted = 968 OR unsorted = 969;

--- d
SELECT DISTINCT unsorted FROM table1 WHERE unsorted = 967
UNION 
SELECT DISTINCT unsorted FROM table1 WHERE unsorted = 968
UNION 
SELECT DISTINCT unsorted FROM table1 WHERE unsorted = 969;


--- EXPLAIN ANALYZE
EXPLAIN ANALYZE SELECT DISTINCT unsorted FROM table1 WHERE unsorted BETWEEN 967 AND 969;

EXPLAIN ANALYZE SELECT DISTINCT unsorted FROM table1 WHERE unsorted IN (967, 968, 969);

EXPLAIN ANALYZE SELECT DISTINCT unsorted FROM table1 WHERE unsorted = 967 OR unsorted = 968 OR unsorted = 969;

EXPLAIN ANALYZE (SELECT DISTINCT unsorted FROM table1 WHERE unsorted = 967
UNION 
SELECT DISTINCT unsorted FROM table1 WHERE unsorted = 968
UNION 
SELECT DISTINCT unsorted FROM table1 WHERE unsorted = 969);


-- btree index
CREATE INDEX ON table1 USING btree (unsorted);
-- hash index
CREATE INDEX ON table1 USING hash (unsorted);
-- drop index
DROP INDEX table1_unsorted_idx;


-- 2 Query Plan Exercise
CREATE TABLE pool1 (val integer);
INSERT INTO pool1(val) SELECT random()*500 FROM (SELECT generate_series(1, 5000000)) AS T;
CREATE TABLE pool2 (val integer);
INSERT INTO pool2(val) SELECT random()*500 FROM (SELECT generate_series(1, 5000000)) AS T;

--- 1
---- a
EXPLAIN ANALYZE SELECT count(val) FROM (SELECT val FROM pool1 UNION ALL SELECT val FROM pool2) AS T;
---- b
EXPLAIN ANALYZE SELECT sum(cnt) FROM (SELECT count(val) AS cnt FROM pool1 UNION ALL SELECT count(val) AS cnt FROM pool2) AS T;

--- 2
---- a
EXPLAIN ANALYZE SELECT * FROM (SELECT val FROM pool1 WHERE val > 250 UNION ALL SELECT val FROM pool2 WHERE val > 250) AS T;
---- b
EXPLAIN ANALYZE SELECT * FROM (SELECT val FROM pool1 UNION ALL SELECT val FROM pool2) AS T WHERE val > 250;
