-- Self made queries

-- all orders on date 2016-10-10

SELECT * 
FROM orders
WHERE order_date = '2016-10-10'

-- * JOIN's *

-- INNER JOIN 
-- (selects records that have matching values in both tables.)

SELECT orders.order_no, customer.customer_id, customer.customer_name
FROM orders
INNER JOIN customer 
ON orders.customer_id = customer.customer_id

-- LEFT JOIN
/* The LEFT JOIN keyword returns all records from the left table (table1),
and the matching records from the right table (table2).The result is 0 records from the
right side, if there is no match. */

SELECT salesman.s_name, orders.purch_amt
FROM salesman
LEFT JOIN orders
ON salesman.salesman_id = orders.salesman_id


-- Which salesman sales higher

SELECT salesman.s_name, orders.purch_amt
FROM salesman
LEFT JOIN orders
ON salesman.salesman_id = orders.salesman_id
ORDER BY purch_amt DESC

-- Who is the salesman who did'n sales anything

SELECT salesman.s_name, orders.purch_amt
FROM salesman
LEFT JOIN orders
ON salesman.salesman_id = orders.salesman_id
WHERE purch_amt IS NULL

-- AGGREGATE FUNCTION

SELECT ROUND(SUM(purch_amt)) AS Total
FROM orders

SELECT DISTINCT COUNT(*) AS Total_Customers
FROM customer

SELECT MAX(commission)
FROM salesman

SELECT MIN(commission)
FROM salesman

-- * SUB - QUERY *

SELECT s_name, commission
FROM salesman
WHERE commission = (SELECT MAX(commission) FROM salesman)
