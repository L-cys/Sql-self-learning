SELECT *
FROM products
WHERE unit_price > (
	SELECT unit_price
	FROM products
	WHERE product_id = 3)

SELECT *
FROM employees
WHERE salary > (
	SELECT AVG(salary)
    FROM employees)

SELECT *
FROM products
WHERE product_id NOT IN(
	SELECT DISTINCT product_id
	FROM order_items)

SELECT *
FROM clients
WHERE client_id NOT IN (
	SELECT DISTINCT client_id
	FROM invoices)

-- The same as
SELECT *
FROM clients
LEFT JOIN invoices USING (client_id)
WHERE invoice_id IS NULL

SELECT DISTINCT customer_id, first_name, last_name
FROM customers
LEFT JOIN orders 
	USING (customer_id)
LEFT JOIN order_items
	USING (order_id)
WHERE product_id = 3


SELECT *
FROM customers
WHERE customer_id IN (
	SELECT o.customer_id
    FROM order_items oi
	JOIN orders o USING (order_id)
    WHERE product_id = 3
)

SELECT *
FROM invoices
WHERE invoice_total >(
	SELECT MAX(invoice_total)
	FROM invoices
	WHERE client_id = 3
)

SELECT *
FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
)

SELECT client_id
FROM invoices
GROUP BY client_id
HAVING COUNT(*) >=2

SELECT *
FROM clients
WHERE client_in IN (
SELECT client_id
FROM invoices
GROUP BY client_id
HAVING COUNT(*) >=2
)

-- the same as
SELECT *
FROM clients
WHERE client_in = ANY (
SELECT client_id
FROM invoices
GROUP BY client_id
HAVING COUNT(*) >=2
)
SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id
)
-- First go into every employees in e, than look at its salary,
-- then execute the sub code, to calculate the avg salary fromm the same office.

SELECT *
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = i.client_id
)

SELECT *
FROM clients c
WHERE EXISTS (
	SELECT client_id
    FROM invoices
    WHERE c.client_id = client_id
)

SELECT *
FROM products p
WHERE NOT EXISTS (
	SELECT product_id
    FROM order_items
    WHERE p.product_id = product_id
)

SELECT invoice_id, 
	invoice_total,
    (SELECT AVG(invoice_total)
		FROM invoices) AS invoice_average,
	invoice_total - (SELECT invoice_average) AS difference
FROM invoices

SELECT 
	client_id,
    name,
    (SELECT SUM(invoice_total)
		FROM invoices i
        WHERE i.client_id = c.client_id
	) AS total_sale,
    (SELECT AVG(invoice_total)
    FROM invoices) AS ave_sale,
    (SELECT total_sale - ave_sale) AS difference
FROM clients c



