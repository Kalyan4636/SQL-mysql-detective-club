-- SQL INTERVIEW QUESTION

 --  Question:
-- Write a SQL query to find all customers who placed
 --  orders on two consecutive days at least once.

 --   Companies:
--   Cognizant | Infosys | PwC | CGI

--  STEP 1: CREATE DATABASE

CREATE DATABASE consecutive_orders_db;

--   STEP 2: USE DATABASE
   
USE consecutive_orders_db;
--  STEP 3: CREATE TABLE

CREATE TABLE orders_data (
    customer_id VARCHAR(5),
    order_date DATE
);

--  STEP 4: INSERT DATA
INSERT INTO orders_data (customer_id, order_date)
VALUES
('A', '2024-01-01'),
('A', '2024-01-02'),
('A', '2024-01-05'),

('B', '2024-01-01'),
('B', '2024-01-03'),
('B', '2024-01-04'),

('C', '2024-01-01'),
('C', '2024-01-02'),
('C', '2024-01-03'),

('D', '2024-01-01'),
('D', '2024-01-10'),

('E', '2024-01-01'),

('F', '2024-01-01'),
('F', '2024-01-03'),
('F', '2024-01-05'),
('F', '2024-01-07');

--  STEP 5: CHECK THE TABLE
SELECT *
FROM orders_data;

-- STEP 6: FIND CUSTOMERS WHO PLACED ORDERS ON CONSECUTIVE DAYS
SELECT DISTINCT customer_id
FROM
(
    SELECT
        customer_id,
        order_date,
        
        LAG(order_date) OVER (
            PARTITION BY customer_id
            ORDER BY order_date
        ) AS previous_order_date
        
    FROM orders_data
) AS order_history

WHERE DATEDIFF(order_date, previous_order_date) = 1;
