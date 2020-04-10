-- datatypes
-- CHAR(X) fixed length string, like phone num
-- VARCHAR(X) FOR variable length strings, like username
-- VARCHAR(50) short strings like username
-- VARCHAR(225) MEDIUM LENGTH STRINGS like address
-- MEDIUMTEXT
-- LONGTEXT : years of log file
-- TINYTEXT
-- TEXT ~ VARCHAR

-- Integers
-- TINYINT
-- UNSIGNED TINYINT, like ages
-- SMALLINT
-- MEDIUMINT
-- INT
-- BIGINT
-- ZEROFILL INT(4): 0001

-- DECIMAL(p,s): DECIMAL(9,2) would be like 1234567.89
-- DEC
-- NUMERIC
-- FIXED
-- FLOAT
-- DOUBLE

-- BOOLEAN
-- BOOL
UPDATE posts
SET is_published = TRUE
-- or
SET is_published = 1

-- ENUMS
ENUM('small','medium','large')
SET(...)

-- DATE & TIME
-- DATE
-- TIME 
-- DATETIM
-- TIMESTAMP
-- YEAR

-- BLOBS
-- TINYBLOB : binary data
-- BLOG
-- MEDIUMBLOB
-- LONGBLOB

-- JSON document
update products
set properties = '
{
	"dimensions":[1,2,3],
    "weight":10,
    "manufacturer": {"name": "sony"}
}
'
WHERE product_id = 1
-- or
update products
set properties = JSON_OBJECT(
	'weight',10,
    'dimensions', JSON_ARRAY(1,2,3),
    'manufacturer', JSON_OBJECT('name','SONY')
)
    
WHERE product_id = 1

-- query
SELECT 
	product_id,
    JSON_EXTRACT(properties,'$.weight') AS weight
FROM products
WHERE product_id = 1;
-- or
SELECT 
	product_id,
    properties -> '$.dimensions'
    -- dimensions[0]
FROM products
WHERE product_id = 1;

-- will get string without quote ""
SELECT 
	product_id,
    properties ->> '$.manufacturer.name'
FROM products
WHERE product_id = 1;

-- update
update products
set properties = JSON_SET(
	properties,
    '$.weight',20,
    '$.age',10
) 
WHERE product_id = 1

JSON_REMOVE（
	properties ，
	‘$.age'
)
