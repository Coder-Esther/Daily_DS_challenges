-- Create a customers table
CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    customer_name TEXT,
    region TEXT
);

INSERT INTO customers VALUES
(1, 'Amina', 'Nairobi'),
(2, 'Brian', 'Mombasa'),
(3, 'Carol', 'Nairobi'),
(4, 'David', 'Kisumu'),
(5, 'Esther', 'Nakuru'),
(6, 'Farah', 'Mombasa');

--Create an orders table
CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product TEXT,
    category TEXT,
    quantity INTEGER,
    unit_price REAL,
    order_date TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(101, 1, 'Laptop', 'Electronics', 1, 80000, '2026-11-01'),
(102, 2, 'T-Shirt', 'Clothing', 3, 1200, '2026-11-01'),
(103, 3, 'Phone', 'Electronics', 2, 35000, '2026-11-02'),
(104, 1, 'Chair', 'Home', 2, 7500, '2026-11-03'),
(105, 4, 'T-Shirt', 'Clothing', 5, 1200, '2026-11-03'),
(106, 5, 'Laptop', 'Electronics', 1, 80000, '2026-11-04'),
(107, 6, 'Blender', 'Home', 2, 6000, '2026-11-04'),
(108, 2, 'Phone', 'Electronics', 1, 35000, '2026-11-05'),
(109, 3, 'Chair', 'Home', 4, 7500, '2026-11-05'),
(110, 4, 'Blender', 'Home', 3, 6000, '2026-11-06');


--Display all records from customers.
SELECT *
FROM customers;

--Display all records from orders.
SELECT *
FROM orders;

--Find the total number of orders
SELECT COUNT(order_id)
FROM orders;

--Display only the product, quantity, and unit price from the orders table.
SELECT product,quantity,unit_price
FROM orders;

--Find orders where the category is Electronics.
SELECT *
FROM orders
WHERE category = 'Electronics';

--Find orders with a unit price greater than KSh 10,000.
SELECT *
FROM orders
WHERE unit_price > 10000;

--Sort orders by unit price from highest to lowest
SELECT *
FROM orders
ORDER BY unit_price DESC;

-- Find orders placed on or after 2026-11-04.
SELECT *
FROM orders
WHERE order_date>='2026-11-04';

--Calculate the revenue for each order
SELECT *,quantity*unit_price AS revenue
FROM orders;

--Calculate total store revenue
SELECT sum(quantity*unit_price )AS total_revenue
FROM orders;

--Calculate average order revenue.
SELECT avg(quantity*unit_price) AS average_revenue
FROM orders;

-- Identify the order with the highest revenue.
SELECT *,quantity*unit_price AS revenue
FROM orders
ORDER BY revenue DESC
LIMIT 1;

--Calculate total revenue by product category
SELECT category,sum(quantity * unit_price) AS revenue
FROM orders
GROUP BY category;

--Calculate the number of orders by category
SELECT category,COUNT(order_id)
FROM orders
GROUP BY category;

--Calculate total revenue by product
SELECT product,sum(quantity*unit_price) AS total_revenue
FROM orders
GROUP BY product;

--Find the category generating the highest revenue.
SELECT category,sum(quantity*unit_price) AS total_revenue
FROM orders
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 1;

--Display each order with the customer's name and region
SELECT orders.*,
       customers.customer_name,
	   customers.region
FROM orders
JOIN customers
ON orders.customer_id=customers.customer_id;

--Calculate total revenue by region.
SELECT customers.region,sum(quantity*unit_price) AS revenue 
FROM orders
JOIN customers
ON orders.customer_id=customers.customer_id
GROUP BY region 
ORDER BY revenue DESC;

--Identify the customer who generated the highest total revenue
SELECT customers.customer_id,customers.customer_name,sum(quantity*unit_price) AS revenue
FROM orders
JOIN customers
ON orders.customer_id=customers.customer_id
GROUP BY customers.customer_id
ORDER BY revenue DESC
LIMIT 1;

--Count how many orders each customer placed.
SELECT customers.customer_id,customers.customer_name,COUNT(order_id)
FROM orders
JOIN customers
ON orders.customer_id=customers.customer_id
GROUP BY customers.customer_id;

-- High Value: revenue greater than or equal to KSh 50,000.
-- Medium Value: revenue from KSh 10,000 to less than KSh 50,000.
-- Low Value: revenue below KSh 10,000.
--Display the order ID, product, revenue, and classification.

SELECT order_id,
       product,
	   (quantity*unit_price) AS revenue,

	   CASE 
	       WHEN quantity*unit_price>=50000 THEN 'High-Value'
		   WHEN quantity*unit_price >= 10000 AND quantity*unit_price < 50000 THEN 'Medium-Value'
		   ELSE 'Low-Value'
	   END AS order_classification
FROM orders;


-- Which product category generates the most revenue?Electronics-265000
-- Which region contributes the most revenue?Nairobi-195000
-- Which customer spends the most?Carol-100000
-- What recommendation would you give the store manager?Investigate product-level sales volume, profit margins and customer demand before deciding which products need improvement
 