SELECT 
	MAX(invoice_total) AS highest,
	MIN(invoice_total) AS lowest,
	AVG(invoice_total) AS average,
	SUM(invoice_total) AS total,
	COUNT(invoice_total) AS number_of_invoices,
	COUNT(payment_date) AS count_of_payment,
	-- Ignore NULL
	COUNT(*) AS total_record
FROM invoices
WHERE invoice_data > '2019-07-01'

	SUM(invoice_total * 1.1) AS total,
	COUNT(DISTINCT client_id) AS total_record

SELECT
	'First half of 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND'2019-06-01'
UNION
SELECT
	'Second half of 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-06-01' AND '2019-12-31'
UNION
SELECT
	'Total' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
    SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices

SELECT
	client_id,
	SUM(invoice_total) AS total total_sales
FROM invoices
WHERE invoice_date >= '2019-07-01'
GROUP BY client_id
ORDER BY total_sales DESC
 
 SELECT 
	p.date, 
    pm.name AS payment_method,
    SUM(p.amount) AS total_payments
FROM payments p
JOIN payment_methods pm
	ON p.payment_method = pm.payment_method_id
GROUP BY date, payment_method
ORDER BY p.date

SELECT
	client_id,
	SUM(invoice_total) AS total total_sales
	COUNT(*) AS number_of_invoices
FROM invoices
-- WHERE total_sales > 500, cannot apply here
GROUP BY client_id
HAVING total_sales > 500 AND number_of_invoices > 5

SELECT 
	c.first_name AS name,
    SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers c
JOIN orders 
	USING (customer_id)
JOIN order_items oi
	USING (order_id)
WHERE state = 'VA'
GROUP BY c.first_name
HAVING total_spend > 100


SELECT
	client_id,
	SUM(invoice_total) AS total total_sales
FROM invoices
GROUP BY client_id WITH ROLLUP
-- rollup calculate the summary for each group

SELECT 
	pm.name AS payment_method,
    SUM(p.amount) AS total
FROM payments p
JOIN payment_methods pm
	on p.payment_method = pm.payment_method_id
GROUP BY pm.name WITH ROLLUP