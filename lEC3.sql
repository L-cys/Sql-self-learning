SELECT ROUND(5.73,1)
--   四舍五入结果，第二个参数为位数
SELECT TRUNCATE(5.7345,2)
SELECT CEILING(5.2)
-- the smallest int >= than this one.
SELECT FLOOR(5.2)
SELECT ABS(-5.2)
SELECT RAND()

-- THE LENGTH OF CHARACTERS
SELECT UPPER('sky')
SELECT LENGTH('sky')
SELECT LOWER('SKY')
SELECT LTRIM('   Sky')
SELECT RTRIM('sKY   ')
SELECT TRIM(' SKY ')
SELECT LEFT('Kindergarten',4)
SELECT RIGHT('Kindergarten',4)
SELECT SUBSTRING('kINDERGARTEN',3,5)
SELECT LOCATE('n','Kindergarten')
SELECT REPLACE('Kindergarten','garten','garden')
SELECT CONCAT('first','last')
-- Combine them into a string

SELECT CONCAT(first_name,' ',last_name) AS full_name
FROM customers

SELECT NOW(), CURDATE(), CURTIME()
SELECT YEAR(NOW())
-- similarly, month(),dayname(),day(),hour()
SELECT EXTRACT(DAY FROM NOW())

SELECT *
FROM ORDERS
WHERE order_date >= CURDATE()

-- FORMATTING DATE AND TIME
SELECT DATE_FORMATE(NOW(), '%d %M %Y')
-- Upper means: March, lower means: 03
SELECT TIME_FORMAT(NOW(), '%H:%i %p')

-- CALCULATION
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY)
SELECT DATE_ADD(NOW(), INTERVAL -1 YEAR)
SELECT DATE_SUB(NOW(), INTERVAL 1 YEAR)
SELECT DATEDIFF('2019-01-05','2019-0101')
SELECT TIME_TO_SEC('09:00')
SELECT TIME_TO_SEC('09:00') - TIME_TO_SEC('09:02')

SELECT
	order_id
	IFNULL(shipper_id, 'Not assigned') AS shipper
FROM orders
-- The same as COALESCE(shipper_id, 'Not assigned') AS shipper

SELECT  
	order_id,
    order_date,
    IF(YEAR(order_date) = YEAR(NOW()), 'Active', 'Archived')
From orders

SELECT 
	product_id,
    name,
    COUNT(*) AS orders,
    IF(COUNT(*) > 1, 'Many times','Once') AS category
FROM products p
JOIN order_items oi 
	USING (product_id)
GROUP BY product_id, name
