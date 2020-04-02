-- First class.
USE sql_store;

-- select fisrt. The order could not be changed.
SELECT * 
-- the column. \* means all the columns.
FROM customers
WHERE customer_id = 1
ORDER BY first_name

--Second class.
SELECT 
	last_nam, 
	first_name, 
	points, 
	points + 10 AS discount_factor
	-- give another name to the column.
FROM customers

SELECT DISTINCT state
FROM customers
-- Double click on the table could change the value.
-- How to get unique? Remove duplicate.

-- Excersce
-- Return all the produts, name, unit price, new price(* 1.1)
SELECT name, unit_price, unit_price * 1.1 AS new_price
FROM products

SELECT *
FROM customers
WHERE points > 3000
-- WHERE state = 'VA'
-- != or <>
-- WHERE birth_date > '1990-01-01'

-- Third class
SELECT *
FROM customers
WHERE birth_date > '1990-01-01' AND points > 1000
-- WHERE NOT (birth_date > '1990-01-01' OR points > 1000)

SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30

SELECT *
FROM customers
WHERE state IN ('VA','FL','GA')
-- NOT IN

SELECT *
FROM products
WHERE quantity_in_stock IN (49,38,72)

WHERE points BETWEEN 1000 AND 3000

WHERE last_name LIKE 'b%'
-- %: any number of character. 'brush%', '%e%',
-- _: only represent on character, '_y' only means a two characters word.
-- NOT LIKE.

WHERE last_name LIKE '%field%'
-- means the same with
WHERE last_name REGEXP 'filed'
-- ^: begining of a string, like '^filed'
-- $: the end of a string.
-- pretty much the same with java.
-- | : or
-- []:anything here would be fine.

WHERE phone IS NULL
WHERE phone IS NOT NULL

ORDER BY first_name DESC
-- descending order
ORDER BY state, first_name
-- first by state, then by first name

SELECT first_name, last_name, 10 as points
FROM customers
ORDER BY 1, 2
-- ODER BY first_name, last name.

LIMIT 3
-- page 1: 1-2-3
-- page 2: 4-5-6 .. 
LIMIT 6, 3
-- skip first 6, chose the last 3

SELECT order_id, orders.customer_id, first_name, last_name
-- MYsql would be confused which column you choose.
FROM order_items o
-- abreviate name of your table
INNER JOIN customers 
	ON orders.customers_id = customers.customers_id

USE sql_store;

SELECT *
FROM order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product.id

SELECT e.eployee_id, e.first_name, m.first_name AS manager
FROM employees e
JOIN emplyees m
	on e.reports_to = m.eployee_id
-- Join the table itself, but you have to give a name.

-- How to join mutiple tables.
USE sql_store;
SELECT o.order_id, o.order_date,c.first_name,c.last_name, os.name AS status
FROM orders o 
JOIN customers c 
	ON o.customers_id = c.customers_id
JOIN order_statuses os
	ON o.status = os.order_statuses_id

SELECT *
FROM order_items oi
JOIN order_item_botes oin
	ON oi,order_id = oin.order_id
	AND oi.product_id = oin.product_id

-- Also have the same function with JOIN
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id


SELECT *
FROM customers c
-- Only return the result match the requirment
JOIN orders o 
	ON c.customers_id = o.customer_id
ORDER BY c.customer_id

SELECT *
FROM customers c
LEFT JOIN orders o 
	ON c.customers_id = o.customer_id
ORDER BY c.customer_id
-- All customers' information will show up.

RIGHT JOIN orders o 
	ON c.customers_id = o.customer_id
-- According to the order table

SELECT *
FROM customers c
LEFT JOIN orders o 
	ON c.customers_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id
-- You can use left join on self join

SELECT *
FROM customers c
LEFT JOIN orders o 
--	ON c.customers_id = o.customer_id
	USING (customer_id)
-- USING (product_id, customer_id)

-- Natural join can join automatically
-- Cross join, every item in table one will combine with every item in another
SELECT ph.name
	   p.name
FROM shippers sh, products p
ORDER BY sh.name

-- the same as
SELECT ph.name
	   p.name
FROM shippers sh
CROSS JOIN products p
ORDER BY sh.name


SELECT 
	order_id,
	order_date,
	'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT 
	order_id,
	order_date,
	'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01'

SELECT customer_id,
	first_name,
	points, 
	'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT customer_id,
	first_name,
	points, 
	'Silver' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
SELECT customer_id,
	first_name,
	points, 
	'Gold' AS type
FROM customers
WHERE points > 3000
ORDER BY first_name

INSERT INTO customers
VALUES(DEFAULT, 
		'John',
		'Smith',
		'1990-01-01',
		NULL,
		'address',
		'city',
		'CA',
		DEFAULT)

-- Multiple rows
INSERT INTO shippers(name)
VALUES('Shipper1'),
	  ('Shipper2'),
	  ('Shipper3')

-- Inster data into mutiple tables
INSERT INTO orders(customer_id,
					order_date,
					status)
VALUES(1,'2019-01-02',1);
-- Get the lastesr ID
LAST_INSERT_ID()

INSERT INTO order_items
VALUES(LAST_INSERT_ID(),1,1,2.95),
	  (LAST_INSERT_ID(),2,1,3.95)

-- copy data
CREATE TABLE orders_archived AS
SELECT * FROM orders
-- But now we don't set it NN or AI

INSERT INTO orders_archived
SELECT *
FROM orders
WHERE order_date < '2019-01-01'

CREATE TABLE invoicing_archived
SELECT i.invoice_id,
	   i.number,
       c.name AS client,
       i.invoice_date,
       i.payment_date,
       i.due_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL

UPDATE invoices
SET payment_total = 10, payment_date = '2019-03-01'
WHERE invoice = 1

UPDATE invoices
SET payment_total = invoice_total * 0.5,
    payment_date = due_date
WHERE invoice_id = 3

