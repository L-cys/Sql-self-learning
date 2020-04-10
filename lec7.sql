START TRANSACTION;

INSERT INTO orders (customer_id, order_date, status)
VALUES (1,'2019-01-01',1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 1);

COMMIT;
-- Or use 'ROLLBACK;'

SHOW VARIABLES LIKE 'transaction_isolation';
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
-- OR
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Read uncommitted. Will return the value after another transaction's changes that haven't commited yet.
-- Lowest isolation level.
USE sql_store;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT points
FROM customers
WHERE customer_id = 1;

-- Read committed.
-- Don't have dirty read. But have inconsistent read.
-- Value would be changed alfter commited by others.
USE sql_store;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT points FROM customers WHERE customer_id = 1;
SELECT points FROM customers WHERE customer_id = 1;
COMMIT;

-- Repeatable read.
-- Defualt isolation level. So even if you change and committed
-- You will get tha same result.
USE sql_store;
SET TRANSACTION ISOLATION LEVEL repeatable read;
START TRANSACTION;
SELECT points FROM customers WHERE customer_id = 1;
SELECT points FROM customers WHERE customer_id = 1;
COMMIT;

-- SERIALIZABLE
-- Highest isolation level
USE sql_store;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
SELECT * FROM customers WHERE state = 'VA';
COMMIT;


-- Deadlock.
-- Both transaction keeps locking and no one can move on.

-- Lost updates.
-- Dirty reads
-- Non-repeating reads
-- Phantom reads