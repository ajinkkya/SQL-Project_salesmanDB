-- Display all Records

SELECT * FROM salesman
SELECT * FROM customer
SELECT * FROM customer_data
SELECT * FROM orders


-- 1) Display name and commission for all the salesmen

SELECT s_name, commission
FROM salesman

-- 2) Retrieve salesman id of all salesmen from orders table without any repeats.

SELECT DISTINCT salesman_id
FROM orders

-- 3) Display names and city of salesman, who belongs to the city of Paris.

SELECT s_name, city
FROM salesman
WHERE city = 'Paris'

-- 4) Display all the information for those customers with a grade of 200.

SELECT * 
FROM customer
WHERE grade = 200

/* 5) Display the order number, order date and the purchase amount
for order(s) which will be delivered by the salesman with ID 5001. */

SELECT order_no, order_date, purch_amt
FROM orders
WHERE salesman_id = 5001

-- 6) Show all the details of the customer with city start with 'New'.

SELECT *
FROM customer
WHERE city LIKE 'New%'

-- 7) Show all salesman name who is not belongs to 'London' and 'Rome'

SELECT * 
FROM salesman
WHERE city NOT IN('London', 'Rome')

-- UNION
/* 8) Combines the results from 2 or more SELECT statements and
returns only distinct values. */

SELECT * 
FROM orders
WHERE order_date = '2016-10-10'
UNION
(SELECT * 
FROM orders
WHERE order_date = '2016-07-27')

/* 9) Display all the customers who are either belongs to the city new 
york or not had grade above 100 */

SELECT * 
FROM customer
WHERE (city = 'New York') OR NOT (grade > 100)

-- 12) Select the salesman who get maximum commission

SELECT s_name, commission
FROM salesman
WHERE commission = (SELECT MAX(commission) FROM salesman)

/* 13) Find those salesmen with all information who gets the
commission with in a range of 0.12 and 0.12. */

SELECT * 
FROM salesman
WHERE commission BETWEEN 0.12 AND 0.12

-- 14) Find customers whose name ending with 'n'

SELECT customer_name
FROM customer
WHERE customer_name LIKE '%n'

/* 15) Find those salesman with all information whose name containing the 1st charactor
is 'N' and the 4th charactor is 'l' and rest may be any charactor */

SELECT * 
FROM salesman
WHERE s_name LIKE 'N__l%'

-- 16) Find that customer with all information who does not get any grade except NULL.

SELECT *
FROM customer 
WHERE grade IS NULL

-- 17) Find the total purchase amount of all orders.

SELECT ROUND(SUM(purch_amt)) AS total_purchase
FROM orders

-- 18) Find the number of salesman currently listing for all of their customers.

SELECT COUNT (salesman_id) AS salesman_count
FROM orders

SELECT COUNT (DISTINCT salesman_id) AS salesman_count
FROM orders

-- 19) Find the highest grade for each of the cities of the customers.

SELECT MAX(grade), city
FROM customer
GROUP BY city

/* 20) Find the highest purchase amount ordered by the each
customer with their ID and highest purchase amount. */

SELECT MAX(purch_amt), customer_id
FROM orders
GROUP BY customer_id

/* 21) Find the highest purchase amount ordered by the each customer on a particular 
date with their ID, order date and highest purchase amount. */

SELECT customer_id, order_date, MAX(purch_amt)
FROM orders
GROUP BY customer_id, order_date

-- SECtION 2 Multiple tables Joins Nested Queries

-- 1) Find the name and city of those customers and salesmen who lives in the same city.

SELECT customer.customer_name, salesman.s_name, salesman.city
FROM customer, salesman
WHERE customer.city = salesman.city

-- 2) Find the names of all customers along with the salesmen who works for them.

SELECT customer.customer_name, salesman.s_name
FROM customer, salesman
WHERE customer.salesman_id = salesman.salesman_id

/* 3) Display all those orders by the customers not located in the
same cities where their salesmen live. */

SELECT 
    orders.order_no,
    customer.customer_name,
    orders.customer_id,
    orders.salesman_id,
    customer.city AS cust_city,
    salesman.city AS salesman_city
FROM salesman, customer, orders
WHERE customer.city <> salesman.city
    AND orders.customer_id = customer.customer_id 
    AND orders.salesman_id = salesman.salesman_id;

-- 4) Display all the orders issued by the salesman 'Paul Adam' from the orders table.

SELECT *
FROM orders
WHERE salesman_id = 5007 -- Un-Nested

SELECT *
FROM orders
WHERE salesman_id = (SELECT salesman_id FROM salesman WHERE s_name = 'Paul Adam') -- Nested

-- 5) Display all the orders which values are greater than the average order 
-- value for 10th October 2016.
    
    -- Nested
SELECT *
FROM orders 
WHERE purch_amt > (SELECT AVG(purch_amt) FROM orders WHERE order_date = '2016-10-10')

    -- 
SELECT AVG(purch_amt) FROM orders WHERE order_date = '2016-10-10'
-- Output = 2231.915

    -- Un - Nested
SELECT *
FROM orders 
WHERE purch_amt > 2231.915

-- 6) Find all orders attributed to salesmen in New York.

SELECT *
FROM orders
WHERE salesman_id IN(SELECT salesman_id FROM salesman WHERE city ='New York')