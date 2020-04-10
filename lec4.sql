CREATE VIEW sales_by_client AS
SELECT 
	c.client_id,
    c.name,
    SUM(invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name

SELECT *
FROM sales_by_client
JOIN clients USING (client_id)

CREATE VIEW client_balance AS
SELECT 
	i.client_id,
    c.name,
    SUM(invoice_total) - SUM(payment_total) AS balance
FROM invoices i
JOIN clients c USING (client_id)
GROUP BY client_id

DROP VIEW sales_by_client

CREATE OR REPLACE VIEW client_balance AS

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT 
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0

UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invocie_id = 2


UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 2
-- Now invoice_id = 2's row has gone!

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT 
	invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0

UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invocie_id = 2
WITH CHECK OPTION
-- if you modify it, you will get an error.


