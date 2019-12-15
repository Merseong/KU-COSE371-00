-- Exercise 1

/*
using
BEGIN;
COMMIT;
ROLLBACK;
*/

--- 1
BEGIN;
INSERT INTO customer VALUES ('Pepsiman', 'Main', 'Harrison');
INSERT INTO account VALUES ('B-000', 'Downtown', 1024);
INSERT INTO depositor VALUES ('Pepsiman', 'B-000');
COMMIT;

--- 2
BEGIN;
DELETE FROM depositor
WHERE account_number = 'B-000';
DELETE FROM account
WHERE account_number = 'B-000';
DELETE FROM customer -- 반복을 위해 customer도 같이 지움
WHERE customer_name = 'Pepsiman';
COMMIT;

--- 3
BEGIN;
UPDATE account
    SET balance = balance - 200
    WHERE account_number = 'A-222';
UPDATE branch
    SET assets = assets - 200
    WHERE branch_name IN (
        SELECT branch_name
        FROM account
        WHERE account_number = 'A-222'
    ); -- 'Redwood'
UPDATE branch
    SET assets = assets + 200
    WHERE branch_name IN (
        SELECT branch_name
        FROM account
        WHERE account_number = 'A-101'
    ); -- 'Downtown'
UPDATE account
    SET balance = balance + 200
    WHERE account_number = 'A-101';
COMMIT;


-- Exercise 2
--- 1
BEGIN;
UPDATE account
    SET balance = balance - 500
    WHERE account_number IN (
        SELECT account_number
        FROM account NATURAL JOIN depositor
        WHERE customer_name = 'Johnson'
        );
UPDATE account
    SET balance = balance + 500
    WHERE account_number IN (
        SELECT account_number
        FROM account NATURAL JOIN depositor
        WHERE customer_name = 'Turner'
        );
COMMIT;

--- 2
BEGIN;
UPDATE account
    SET balance = balance + 500;
SELECT * FROM account;
-- crash at here (quit psql)
SELECT * FROM account;


-- Exercise 3
--- 1. Dirty read
-- in window B
BEGIN;
UPDATE account
    SET balance = balance + 1000
    WHERE account_number = 'A-215';

-- in window A
BEGIN;
SELECT * FROM account WHERE account_number = 'A-215';
COMMIT;

-- in window B
ROLLBACK;

--- 2. Non-repeatable read
-- in window A
BEGIN;
SELECT * FROM account WHERE account_number = 'A-201';

-- in window B
BEGIN;
UPDATE account
    SET balance = balance + 1000
    WHERE account_number = 'A-201';
COMMIT;

-- in window A
SELECT * FROM account WHERE account_number = 'A-201';
COMMIT;

--- 3. Phantom read
-- in window A
BEGIN;
SELECT * FROM account;

-- in window B
BEGIN;
INSERT INTO account VALUES ('A-999', 'Anam', 1000);
COMMIT;

-- in window A
SELECT * FROM account;
COMMIT;

DELETE FROM account WHERE account_number = 'A-999';

-- Exercise 4
--- 1. Dirty read
-- in window B
BEGIN;
UPDATE account
    SET balance = balance + 1000
    WHERE account_number = 'A-215';

-- in window A
BEGIN;
SET TRANSACTION isolation level Serializable;
SELECT * FROM account WHERE account_number = 'A-215';
COMMIT;

-- in window B
ROLLBACK;

--- 2. Non-repeatable read
-- in window A
BEGIN;
SET TRANSACTION isolation level Serializable;
SELECT * FROM account WHERE account_number = 'A-201';

-- in window B
BEGIN;
UPDATE account
    SET balance = balance + 1000
    WHERE account_number = 'A-201';
COMMIT;

-- in window A
SELECT * FROM account WHERE account_number = 'A-201';
COMMIT;

--- 3. Phantom read
-- in window A
BEGIN;
SET TRANSACTION isolation level Serializable;
SELECT * FROM account;

-- in window B
BEGIN;
INSERT INTO account VALUES ('A-999', 'Anam', 1000);
COMMIT;

-- in window A
SELECT * FROM account;
COMMIT;

DELETE FROM account WHERE account_number = 'A-999';
