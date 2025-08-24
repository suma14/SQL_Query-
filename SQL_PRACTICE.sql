-- USE sql_store;

-- SELECT * 
-- FROM customers
-- WHERE customer_id=1
-- ORDER BY first_name

-- SELECT 
-- 	last_name,
-- 	first_name, 
-- 	points, 
-- 	(points+10)*100 AS discount_factor
-- FROM customers

-- SELECT * 
-- FROM sql_store.customers;

-- SELECT DISTINCT state
-- FROM customers

-- SELECT 
-- 	name,
-- 	unit_price, 
-- 	(unit_price*1.1) AS new_price 
-- FROM products

-- gET THE ORDERS PLACED THIS YEAR ASSUISMING 2019 IS CURRENT YR 
-- SELECT *
-- FROM orders
-- WHERE order_date>='2019-01-01'

-- SELECT * 
-- FROM order_items
-- WHERE order_id=6 AND ((quantity*unit_price)>30)

-- IN operator 
-- SELECT * 
-- FROM customers
-- WHERE state IN ('VA','FL','GA')

-- SELECT * 
-- FROM products 
-- WHERE quantity_in_stock IN (49,38,72)

-- BETWEEN operator
-- SELECT * 
-- FROM customers
-- WHERE points BETWEEN 1000 AND 3000

-- SELECT *
-- FROM customers
-- WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01'

-- LIKE operator - TO SEARCH FOR THE SPECIFIC PATTERN %(any number of charcaters) or _(for single charcter )
-- SELECT *
-- FROM customers
-- WHERE last_name LIKE '%y'

-- SELECT *
-- FROM customers
-- WHERE address LIKE '%TRAIL%' OR 
--       address LIKE '%AVENUE%'

-- SELECT *
-- FROM customers
-- WHERE phone LIKE '%9'

-- REGEXP operator - search for more complex expressions
-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP 'field' 

-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP '^field' 

-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP 'field$' 

-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP 'field|mac|rose' 

-- ge,ie,me
-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP '[gim]e' 

-- SELECT *
-- FROM customers
-- WHERE last_name REGEXP '[a-h]e' -- a to h 

-- SELECT *
-- FROM customers
-- WHERE -- (first_name LIKE 'elka' OR first_name LIKE 'ambur') AND 
--     -- (last_name LIKE '%ey' OR last_name LIKE '%on') AND
--     -- (last_name LIKE 'my%' OR last_name LIKE '%se%' ) AND
--     (last_name REGEXP 'b[r|u]' )

-- NULL operator 
-- SELECT *
-- FROM customers
-- WHERE phone IS NULL

-- Get the orders that are not shipped - any order that misses the value for the ship date or shipper id   
-- SELECT *
-- FROM orders
-- WHERE shipper_id IS NULL

-- ORDER BY clause - sorting 
-- SELECT *
-- FROM customers
-- ORDER BY first_name DESC

-- SELECT *
-- FROM customers
-- ORDER BY state, first_name -- first sort by state then by first_name 

-- id =2, total_price in desc order QUANTITY * UNIT PRICE
-- SELECT *, (quantity*unit_price) AS total_price
-- FROM order_items
-- WHERE order_id=2
-- ORDER BY total_price DESC

-- the LIMIT clause -- Its very useful when we want to paginate the data
-- SELECT *
-- FROM customers
-- LIMIT 3

-- page 1: 1-3
-- page 2: 4-6
-- page 3: 7-9 -- we want this 
-- SELECT *
-- FROM customers
-- LIMIT 6,3 -- SKIP FIRST 6 RECORDS THEN SELECT THE 3 RECORDS

-- Get the top three loyal customers 
-- SELECT *
-- FROM customers
-- ORDER BY points DESC
-- LIMIT 3

-- INNER JOIN OR JOIN-- combining orders table with customers table but in order table need the customer name instead of id
-- SELECT order_id, orders.customer_id, first_name, last_name -- or customers.customer_id
-- FROM orders 
-- INNER JOIN customers 
-- 	ON orders.customeorder_itemsr_id=customers.customer_id

-- we can also do alias for tables as below 
-- SELECT order_id, o.customer_id, first_name, last_name 
-- FROM orders o
-- INNER JOIN customers c
-- 	ON o.customer_id=c.customer_id

-- SELECT order_id, oi.product_id, name, quantity, oi.unit_price
-- FROM order_items oi
-- JOIN products p
-- 	ON oi.product_id=p.product_id

-- Joining across databases -- here we are joining sql_inventory products database to the sql_store data base 
-- SELECT *
-- FROM order_items oi
-- JOIN sql_inventory.products p
-- 	ON oi.product_id=p.product_id

-- or
-- USE sql_inventory;
-- SELECT *
-- FROM sql_store.order_items oi
-- JOIN products p
-- 	ON oi.product_id=p.product_id 

-- SELF JOIN
-- USE sql_hr;

-- SELECT 
-- 	e.employee_id,
--     e.first_name,
--     m.first_name AS manager
-- FROM employees e
-- JOIN employees m
-- 	ON e.reports_to=m.employee_id

-- Joining Multiple Tables -- joining orders table with customer table and status table too
-- USE sql_store;

-- SELECT 
-- 	o.order_id,
--     o.order_date,
--     c.first_name,
--     c.last_name,
--     os.name AS status
-- FROM orders o
-- JOIN customers c
-- 	ON o.customer_id=c.customer_id
-- JOIN order_statuses os
-- 	ON 	o.status=os.order_status_id

-- Exercise 

-- USE sql_invoicing;

-- SELECT 
-- 	p.payment_id,
--     c.name,
--     p.amount,
--     pm.name AS payment_method
-- FROM payments p
-- JOIN clients c
-- 	ON p.client_id=c.client_id
-- JOIN payment_methods pm
-- 	ON p.payment_method=pm.payment_method_id

-- Compound Join conditions. -- As the duplicates in the table as there is no unique id
-- Use both columns to make a new unique id 
-- Order_items- composite primary key
-- USE sql_store;

-- SELECT *
-- FROM order_items oi
-- JOIN order_item_notes oin
-- 	   ON oi.order_id=oin.order_Id
--     AND oi.product_id=oin.product_id

-- Implicit Join syntax
-- SELECT *
-- FROM orders o
-- JOIN customers c
-- 	ON o.customer_id=c.customer_id
-- this can also be done by using implicit join syntax
-- SELECT *
-- FROM orders o, customers c
-- WHERE o.customer_id=c.customer_id

-- OUTER JOIN
-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id
-- FROM customers c
-- JOIN orders o
-- 	ON c.customer_id=o.customer_id
-- ORDER BY c.customer_id

-- the above condition is not applicable for all the customers but only for those who have these orders so we use outer join here
-- We have two types of outer joins they are - left join and right join
-- For LEFT JOIN or LEFT OUTER JOIN- it returns all the left table columns wheter the condition statify or not.
-- For RIGHT JOIN or RIGHT OUTER JOIN - its the opposite.
-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id
-- FROM customers c
-- LEFT JOIN orders o
-- 	ON c.customer_id=o.customer_id
-- ORDER BY c.customer_id

-- SELECT 
-- 	p.product_id,
-- 	p.name,
--     oi.quantity
-- FROM products p
-- LEFT JOIN order_items oi
-- 	ON p.product_id=oi.product_id
--     ORDER BY p.product_id

-- Outer joins between multiple tables --  now also join shipper id name for the outer join 
-- SELECT 
-- 	c.customer_id,
--     c.first_name,
--     o.order_id,
--     sh.name AS shipper
-- FROM customers c
-- LEFT JOIN orders o
-- 	ON c.customer_id=o.customer_id
-- LEFT JOIN shippers sh
-- 	ON 	o.shipper_id=sh.shipper_id
-- ORDER BY c.customer_id

-- SELECT 
-- 	o.order_date,
--     o.order_id,
--     c.first_name AS customer,
--     sh.name AS shipper,
-- 	os.name AS status
-- FROM orders o
-- JOIN customers c
-- 	ON o.customer_id=c.customer_id
-- LEFT JOIN order_statuses os
-- 	ON o.status=os.order_status_id
-- LEFT JOIN shippers sh
-- 	ON o.shipper_id=sh.shipper_id
-- ORDER BY order_id

-- Self outer joins OR self join
-- USE sql_hr;

-- SELECT 
-- 	e.employee_id,
--     e.first_name,
--     m.first_name AS manager
-- FROM employees e
-- LEFT JOIN employees m
-- 	ON e.reports_to=m.employee_id

-- The USING clause- simplified method for specifying join conditions in JOIN operations, particularly when the columns used for joining have the same name in both tables.
-- USE sql_store;
-- SELECT 
-- 	o.order_id,
--     c.first_name,
--     sh.name AS shipper
-- FROM orders o
-- JOIN customers c
-- 	-- ON o.customer_id=c.customer_id
--     USING (customer_id)
-- LEFT JOIN shippers sh
-- 	USING (shipper_id)

-- Joining two ids to form a unique id
-- SELECT *
-- FROM order_items oi
-- JOIN order_item_notes oin
-- 	-- ON oi.order_id=oin.order_id AND
-- -- 		oi.product_id=oin.product_id
-- 	USING (order_id,product_id)

-- write a query date, client, amount and paymentmethod
-- USE sql_invoicing;

-- SELECT 
-- 	p.date,
--     c.name,
--     p.amount,
--     pm.name AS payment_method
-- FROM payments p
-- JOIN clients c
-- 	USING (client_id)
-- JOIN payment_methods pm
-- 	ON p.payment_method=pm.payment_method_id
     
-- NATURAL join - easier to code but not recommended 
-- USE sql_store;
-- SELECT 
-- 	o.order_id,
--     c.first_name
-- FROM orders o
-- NATURAL JOIN customers c

-- CROSS JOIN - Every record from one table will be combined with the other table WE dont have a condition here. 
-- it is the explicit join  
-- SELECT 
-- 	c.first_name AS customer,
--     p.name AS product
-- FROM customers c
-- CROSS JOIN products p
-- ORDER BY c.first_name

-- there is the another way of cross join - implicit syntax
-- SELECT 
-- 	c.first_name AS customer,
-- 	p.name AS product
-- FROM customers c, products p
-- ORDER BY c.first_name

-- Do a cross join between shippers and products
-- Using implicit syntax
-- and then using the explicit syntax
-- SELECT *
-- FROM products p
-- CROSS JOIN shippers sh
-- ORDER BY p.name

-- Implicit syntax -CROSS JOIN
-- SELECT *
-- FROM products p, shippers sh
-- ORDER BY p.name

-- UNIONS- WE can combine columns with multiple tables
-- present year -active, for previous years - archieve
-- SELECT 
-- 	order_id,
--     order_date,
--     'Active' AS status
-- FROM orders
-- WHERE order_date>='2019-01-01'

-- This below code is for the same table changes 
-- SELECT 
-- 	order_id,
--     order_date,
--     'Active' AS status
-- FROM orders
-- WHERE order_date>='2019-01-01'
-- UNION
-- SELECT 
-- 	order_id,
--     order_date,
--     'Archived' AS status
-- FROM orders
-- WHERE order_date<'2019-01-01'
-- but we can also do for the different tables too 

-- SELECT first_name 
-- FROM customers 
-- UNION
-- SELECT name
-- FROM shippers

-- Just remember that the number of columns that the each query returns should be equal otherwise we will get error.
 -- SELECT first_name, last_name
--  FROM customers  -- this returns two columns 
--  UNION 
--  SELECT name 
--  FROM shippers -- this returns one column
 -- so we will get an error
 
-- SELECT first_name AS full_name
-- FROM customers 
-- UNION
-- SELECT name 
-- FROM shippers
-- so whatever we have in this firts_query is used to determine the column name 

-- write a query for customer_id, first_name, points, type- <2000 points is bronze, 2000-3000 is silver, >3000 gold
-- and sorted in first_name bases.
-- SELECT 
-- 	customer_id,
--     first_name,
--     points,
--     'Bronze' AS type
-- FROM customers
-- WHERE points<2000 
-- UNION
-- SELECT 
-- 	customer_id,
--     first_name,
--     points,
--     'Silver' AS type
-- FROM customers
-- WHERE (points>=2000 AND points<3000) 
-- UNION
-- SELECT 
-- 	customer_id,
--     first_name,
--     points,
--     'Gold' AS type
-- FROM customers
-- WHERE points>=3000 
-- ORDER BY first_name

-- Column Attributes-- its about the schema
-- Inserting a single row - INSERT INTO
-- INSERT INTO customers (
-- 	first_name, 
-- 	last_name, 
--     birth_date,
--     address,
--     city,
--     state)
-- VALUES (
-- 	-- DEFAULT, 
--     'Suma', 
--     'Gurugubelli',
--     '2001-02-14',
--    --  NULL,
--     'address',
--     'city',
--     'CA')
--     -- DEFAULT)

-- Inserting multiple rows
-- INSERT INTO shippers (name)
-- VALUES ('Shipper1'),
--        ('Shipper2'),
--        ('Shipper3')

-- Insert three rows in the products table
-- INSERT INTO products
-- VALUES (
-- 	DEFAULT,
--     'productname1',
--     15,
--     1.76
-- )

-- Inserting Hierarchical rows- insert data into mutiple tables 
-- if we look at the orders table there are order infromation but we dont have the information about the order items 
-- INSERT INTO orders (customer_id,order_date,status)
-- VALUES(1,'2019-01-02', 1);
-- INSERT INTO order_items 
-- VALUES
-- 	(LAST_INSERT_ID(),1,1,2.95),
--     (LAST_INSERT_ID(),2,1,3.95)

-- Creating a copy of the table -- it will create the table but the attribruites property should be updated 
-- CREATE TABLE orders_archieved AS
-- SELECT * FROM orders

-- we can also use sub query and an insert statement
-- lets say we want to copy the subset of records from the orders table into this table 
-- INSERT INTO orders_archieved
-- SELECT *
-- FROM orders
-- WHERE order_date <'2019-01-01' 

-- Copy of invocies table in a new table called invoices archieve. However in that table instead of client id we wanna have client name column 
-- we need to join the column in the client table and then use that query as the sub query in a create table statement
-- copy only the invoices that do have payment -- payment_date or pauy,emt _totalcolumn
-- USE sql_invoicing;
-- CREATE TABLE invoice_archieved AS 
-- SELECT 
-- 	i.invoice_id,
--     i.number,
--     c.name AS client,
--     i.invoice_total,
--     i.payment_total,
--     i.invoice_date,
--     i.payment_date,
--     i.due_date
-- FROM invoices i
-- JOIN clients c
-- 	USING(client_id)
-- WHERE payment_date IS NOT NULL;

-- Updating a single row
-- UPDATE invoices
-- SET payment_total=10, payment_date='2019-03-01'
-- WHERE invoice_id=1

-- For suppose if we have updated the infromation in wrong id and want to update it in id =3 and also restor the original values of the id=1, then
-- UPDATE invoices
-- SET payment_total=0, payment_date=NULL
-- WHERE invoice_id=1

-- UPDATE invoices
-- SET 
-- 	payment_total=invoice_total*0.5, -- but the number is truncated so we dont have the digits after the decimal point 
-- 	payment_date=due_date
-- WHERE invoice_id=3

-- Updating multiple rows
-- USE sql_invoicing;
-- UPDATE invoices
-- SET 
-- 	payment_total=invoice_total*0.5,  
-- 	payment_date=due_date
-- WHERE client_id IN (3,4)

-- SQL statement to give any customers born after 1990, 50 extra points
-- USE sql_store;
-- UPDATE customers
-- SET points=points+50
-- WHERE birth_date>'1990-01-01'

-- Using subqueries in updates
-- USE sql_invoicing;
-- UPDATE invoices
-- SET 
-- 	payment_total=invoice_total*0.5,  
-- 	payment_date=due_date
-- WHERE client_id =3
-- what if we know the name instead of id then 
-- USE sql_invoicing;
-- UPDATE invoices
-- SET 
-- 	payment_total=invoice_total*0.5,  
-- 	payment_date=due_date
-- WHERE client_id IN       -- AS we are using more than one state 
-- 			(SELECT client_id
-- 			FROM clients
-- 			WHERE state IN ('CA','NY'))

-- without subquery 
-- UPDATE invoices
-- SET 
-- 	payment_total=invoice_total*0.5,
--     payment_date=due_date
-- WHERE payment_date IS NULL
    
-- In sql_store , orders table have only few comments . update the comments for orders for customers who have more than 3000 points.
-- regard them as gold customers ,find their orders, if they have placed an order update the comments column as gold customer.
-- USE sql_store;

-- UPDATE orders
-- SET comments ='Gold Customer'
-- WHERE customer_id IN
-- 			(SELECT customer_id
-- 			FROM customers 
-- 			WHERE points>3000)

-- Deleting Rows
-- DELETE FROM invoices
-- WHERE client_id =
-- 			(SELECT client_id
-- 			FROM clients
-- 			WHERE name='Myworks');

-- Restoring the databases
-- Just go to the file of original file and run the code 






























