CREATE DATABASE company_db1;

-- Use Database
USE company_db1;
-- Create Table
CREATE TABLE corporate_employees (
    employee_id INT,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    manager_id INT
);
-- Insert Data
INSERT INTO corporate_employees (employee_id, employee_name, department, manager_id) VALUES
(1,'Ramesh','Finance',NULL),
(2,'Sonal','Finance',1),
(3,'Kunal','Finance',1),
(4,'Ritika','Finance',1),
(4,'Ritika','Finance',1),  -- duplicate
(5,'Varun','Finance',1),
(6,'Devika','Finance',1),
(7,'Arpit','IT',NULL),
(8,'Mohit','IT',7),
(9,'Sakshi','IT',7),
(10,'Neeraj','IT',7),
(11,'Priyansh','IT',7),
(12,'Anjali','IT',7),
(13,'Aman','IT',7),
(14,'Rahul','Sales',NULL),
(15,'Isha','Sales',14);

-- Verify Data
SELECT * FROM corporate_employees;

-- Final MySQL Query 
SELECT m.employee_name AS manager_name
FROM corporate_employees e
JOIN corporate_employees m
    ON e.manager_id = m.employee_id
GROUP BY e.manager_id, m.employee_name
HAVING COUNT(DISTINCT e.employee_id) >= 5; 
---------------------------------------------------  day 2 
CREATE DATABASE classroom_db;

USE classroom_db;

--- CREATE TABLE -------------------------
CREATE TABLE classroom_seats (
    seat_number INT PRIMARY KEY,
    student_name VARCHAR(50)
);
------------ INSERT DATA ------------------ 
INSERT INTO classroom_seats (seat_number, student_name) VALUES
(1,'Aarav'),
(2,'Riya'),
(3,'Kabir'),
(4,'Ananya'),
(5,'Dev'),
(6,'Pooja'),
(7,'Ishaan');

---- Verify Data ---
SELECT * FROM classroom_seats;

SELECT 
    CASE 
        WHEN seat_number % 2 = 1 
             AND seat_number != (SELECT MAX(seat_number) FROM classroom_seats)
            THEN seat_number + 1
        WHEN seat_number % 2 = 0 
            THEN seat_number - 1
        ELSE seat_number
    END AS seat_number,
    
    student_name
FROM classroom_seats
ORDER BY seat_number;







-- DAY 4: SQL 15 DAYS CHALLENGE 
-- Create Database 
CREATE DATABASE sql_challenge;
USE sql_challenge;

-- Create Table 
CREATE TABLE Left_table (
    A INT
);

CREATE TABLE Right_table (
    B INT
); 
-- Insert Data 
INSERT INTO Left_table VALUES
(1),(1),(1),(2),(3),(4),(7),(NULL),(NULL),(NULL);

INSERT INTO Right_table VALUES
(1),(1),(2),(3),(3),(5),(NULL),(NULL); 

-- INNER JOIN 
SELECT *
FROM Left_table L
INNER JOIN Right_table R
ON L.A = R.B; 

-- LEFT JOIN 
SELECT *
FROM Left_table L
LEFT JOIN Right_table R
ON L.A = R.B; 

-- FULL JOIN use UNION 
SELECT *
FROM Left_table L
LEFT JOIN Right_table R
ON L.A = R.B

UNION

SELECT *
FROM Left_table L
RIGHT JOIN Right_table R
ON L.A = R.B;

-- CROSS JOIN 
 SELECT *
FROM Left_table
CROSS JOIN Right_table;

-- . RIGHT JOIN 
SELECT *
FROM Left_table L
RIGHT JOIN Right_table R
ON L.A = R.B; 

-- DAY 3 : SQL 15 DAYS CHALLENGE

-- Create Database
CREATE DATABASE sql_challenge_day3;
USE sql_challenge_day3;

-- Create Table 
CREATE TABLE supplier_stock (
    supplier_id INT,
    stock_date DATE,
    stock INT
); 

-- Insert Data 
INSERT INTO supplier_stock VALUES
(101, '2025-07-01', 60),
(101, '2025-07-02', 45),
(101, '2025-07-03', 40),
(101, '2025-07-04', 42),
(101, '2025-07-05', 55),

(102, '2025-07-01', 30),
(102, '2025-07-02', 25),
(102, '2025-07-03', 20),
(102, '2025-07-04', 70),

(103, '2025-07-01', 80),
(103, '2025-07-02', 45),
(103, '2025-07-03', 60),
(103, '2025-07-04', 40),
(103, '2025-07-05', 35),
(103, '2025-07-06', 30); 

-- SQL Query ( Consecutive Days Logic ) 
WITH filtered AS (
    SELECT 
        supplier_id,
        stock_date,
        stock,
        ROW_NUMBER() OVER (
            PARTITION BY supplier_id 
            ORDER BY stock_date
        ) AS rn
    FROM supplier_stock
    WHERE stock < 50
),

grouped AS (
    SELECT 
        supplier_id,
        stock_date,
        DATE_SUB(stock_date, INTERVAL rn DAY) AS grp
    FROM filtered
)

SELECT 
    supplier_id,
    MIN(stock_date) AS start_date,
    MAX(stock_date) AS end_date,
    COUNT(*) AS consecutive_days
FROM grouped
GROUP BY supplier_id, grp
HAVING COUNT(*) >= 2
ORDER BY supplier_id, start_date;

-- DAY 5: SQL 15 DAYS CHALLENGE
-- Create Database 
CREATE DATABASE sql_challenge_day5;
USE sql_challenge_day5;  

-- Create Tables
CREATE TABLE project_team (
    project_identifier INT,
    employee_identifier INT
);

CREATE TABLE employee_experience (
    employee_identifier INT,
    employee_name VARCHAR(50),
    experience_years INT
);

-- insert data 
INSERT INTO project_team VALUES
(1,1),(1,2),(1,3),
(2,1),(2,4),
(3,5),(3,6),(3,7);

INSERT INTO employee_experience VALUES
(1,'Rahul',6),
(2,'Anita',4),
(3,'Sanjay',6),
(4,'Priya',3),
(5,'Kunal',2),
(6,'Ritika',5),
(7,'Aman',5);

-- Method 1: Using Subquery 
SELECT 
    pt.project_identifier,
    pt.employee_identifier
FROM project_team pt
JOIN employee_experience ee 
    ON pt.employee_identifier = ee.employee_identifier
WHERE ee.experience_years = (
    SELECT MAX(ee2.experience_years)
    FROM project_team pt2
    JOIN employee_experience ee2
        ON pt2.employee_identifier = ee2.employee_identifier
    WHERE pt2.project_identifier = pt.project_identifier
); 

-- Method 2: Using Window Function (Advanced )
SELECT project_identifier, employee_identifier
FROM (
    SELECT 
        pt.project_identifier,
        pt.employee_identifier,
        ee.experience_years,
        RANK() OVER (
            PARTITION BY pt.project_identifier 
            ORDER BY ee.experience_years DESC
        ) AS rnk
    FROM project_team pt
    JOIN employee_experience ee
        ON pt.employee_identifier = ee.employee_identifier
) ranked
WHERE rnk = 1;


-- DAY 8: Last 7 Days Rolling Average challenge
CREATE DATABASE sql_challenge8;
USE sql_challenge8; 

-- Create Table
CREATE TABLE daily_sales (
    sale_date DATE,
    category VARCHAR(50),
    sales_amount INT
);

-- import Data 
INSERT INTO daily_sales VALUES
-- Electronics
('2024-01-01', 'Electronics', 1000),
('2024-01-01', 'Electronics', 500),
('2024-01-02', 'Electronics', 1200),
('2024-01-03', 'Electronics', 1100),
('2024-01-04', 'Electronics', 1500),
('2024-01-05', 'Electronics', 1300),
('2024-01-05', 'Electronics', 900),
('2024-01-06', 'Electronics', 1600),
('2024-01-06', 'Electronics', 600),
('2024-01-07', 'Electronics', 1700),
('2024-01-08', 'Electronics', 1800),
('2024-01-09', 'Electronics', 1900),

-- Furniture
('2024-01-01', 'Furniture', 800),
('2024-01-02', 'Furniture', 900),
('2024-01-03', 'Furniture', 850),
('2024-01-04', 'Furniture', 950),
('2024-01-04', 'Furniture', 750),
('2024-01-05', 'Furniture', 1000),
('2024-01-06', 'Furniture', 1100),
('2024-01-07', 'Furniture', 1200),
('2024-01-07', 'Furniture', 200),
('2024-01-08', 'Furniture', 1250),
('2024-01-09', 'Furniture', 1300);

-- Solution Query (Rolling Average) 
WITH daily_totals AS (
    SELECT 
        sale_date,
        category,
        SUM(sales_amount) AS total_sales
    FROM daily_sales
    GROUP BY sale_date, category
)

SELECT 
    sale_date,
    category,
    total_sales,
    
    ROUND(
        AVG(total_sales) OVER (
            PARTITION BY category
            ORDER BY sale_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ), 2
    ) AS rolling_7_day_avg

FROM daily_totals
ORDER BY category, sale_date; 

-- DAY 9: SQL 15 Days Challenge 
-- Topic: Sessionization in SQL (Real Interview Concept) 

-- Create a Database 
CREATE DATABASE sql_challenge9;
USE sql_challenge9; 

-- Create Table 
CREATE TABLE transactions (
    user_id INT,
    txn_date DATE,
    amount INT
);

-- Insert Data
INSERT INTO transactions VALUES
(1, '2024-01-01', 100),
(1, '2024-01-02', 200),
(1, '2024-01-10', 300),
(1, '2024-01-11', 400),
(2, '2024-01-01', 50),
(2, '2024-01-03', 60),
(2, '2024-01-04', 70); 

-- Verify Data
SELECT * FROM transactions;

-- Solve the Session Problem 
WITH txn_with_lag AS (
    SELECT *,
           LAG(txn_date) OVER (PARTITION BY user_id ORDER BY txn_date) AS prev_date
    FROM transactions
),
session_flag AS (
    SELECT *,
           CASE 
               WHEN prev_date IS NULL 
                    OR DATEDIFF(txn_date, prev_date) > 1 
               THEN 1 
               ELSE 0 
           END AS is_new_session
    FROM txn_with_lag
),
session_id_cte AS (
    SELECT *,
           SUM(is_new_session) OVER (PARTITION BY user_id ORDER BY txn_date) AS session_id
    FROM session_flag
)
SELECT 
    user_id,
    session_id,
    MIN(txn_date) AS session_start,
    MAX(txn_date) AS session_end,
    SUM(amount) AS total_amount
FROM session_id_cte
GROUP BY user_id, session_id
ORDER BY user_id, session_id;

-- DAY 10 – SQL Challenge 
-- Create Database 
CREATE DATABASE sql_challenge10;
USE sql_challenge10;

-- Create Table 
CREATE TABLE restaurant_ratings (
    restaurant_id   INT,
    restaurant_name VARCHAR(50),
    rating_month    DATE,
    rating          INT
);

-- Insert Data 
INSERT INTO restaurant_ratings VALUES
(1,'Spice Hub','2024-01-01',4),
(1,'Spice Hub','2024-02-01',5),
(1,'Spice Hub','2024-03-01',4),
(1,'Spice Hub','2024-04-01',4),
(1,'Spice Hub','2024-05-01',5),
(1,'Spice Hub','2024-06-01',4),
(1,'Spice Hub','2024-07-01',3),

(2,'Urban Bites','2024-01-01',4),
(2,'Urban Bites','2024-02-01',4),
(2,'Urban Bites','2024-03-01',5),
(2,'Urban Bites','2024-04-01',4),
(2,'Urban Bites','2024-05-01',4),

(3,'Food Street','2024-01-01',4),
(3,'Food Street','2024-02-01',4),
(3,'Food Street','2024-03-01',3),
(3,'Food Street','2024-04-01',4),
(3,'Food Street','2024-05-01',4),
(3,'Food Street','2024-06-01',4),
(3,'Food Street','2024-07-01',4),
(3,'Food Street','2024-08-01',4),
(3,'Food Street','2024-09-01',4);

-- Verify Data 
SELECT * FROM restaurant_ratings;

-- Filter Ratings ≥ 4 
SELECT *
FROM restaurant_ratings
WHERE rating >= 4;

-- Add Row Number (Sequence) 
SELECT *,
       ROW_NUMBER() OVER (PARTITION BY restaurant_id ORDER BY rating_month) AS rn
FROM restaurant_ratings
WHERE rating >= 4; 

-- Create Group Key (Consecutive Logic) 
SELECT *,
       DATE_SUB(rating_month, INTERVAL rn MONTH) AS grp_key
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY restaurant_id ORDER BY rating_month) AS rn
    FROM restaurant_ratings
    WHERE rating >= 4
) t;

-- Count Consecutive Months 
SELECT restaurant_id, restaurant_name, grp_key, COUNT(*) AS consecutive_months
FROM (
    SELECT *,
           DATE_SUB(rating_month, INTERVAL rn MONTH) AS grp_key
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY restaurant_id ORDER BY rating_month) AS rn
        FROM restaurant_ratings
        WHERE rating >= 4
    ) t1
) t2
GROUP BY restaurant_id, restaurant_name, grp_key;

-- Final Answer (≥ 6 Months) 
SELECT restaurant_id, restaurant_name
FROM (
    SELECT restaurant_id, restaurant_name, grp_key, COUNT(*) AS consecutive_months
    FROM (
        SELECT *,
               DATE_SUB(rating_month, INTERVAL rn MONTH) AS grp_key
        FROM (
            SELECT *,
                   ROW_NUMBER() OVER (PARTITION BY restaurant_id ORDER BY rating_month) AS rn
            FROM restaurant_ratings
            WHERE rating >= 4
        ) t1
    ) t2
    GROUP BY restaurant_id, restaurant_name, grp_key
) final
WHERE consecutive_months >= 6; 

--  

-- QUESTION ASKED BY DELOITTE 
-- Given an event log, find the start date and end date for each consecutive run of the same event. 

CREATE TABLE events (
    event VARCHAR(20),
    event_dt DATE
);
-- Insert Sample Data
INSERT INTO events (event, event_dt)
VALUES
('fail','2020-01-04'),
('success','2020-01-01'),
('success','2020-01-03'),
('success','2020-01-06'),
('fail','2020-01-05'),
('success','2020-01-02'); 

-- solution 
WITH cte AS
(
    SELECT
        event,
        event_dt,
        ROW_NUMBER() OVER(ORDER BY event_dt)
        -
        ROW_NUMBER() OVER(PARTITION BY event ORDER BY event_dt) AS grp
    FROM events
)

SELECT
    event,
    MIN(event_dt) AS start_dt,
    MAX(event_dt) AS end_dt
FROM cte
GROUP BY event, grp
ORDER BY start_dt;

-- Solution (Using LAG) 
WITH cte AS
(
    SELECT *,
           CASE
               WHEN event = LAG(event) OVER(ORDER BY event_dt)
               THEN 0
               ELSE 1
           END AS new_group
    FROM events
),
cte2 AS
(
    SELECT *,
           SUM(new_group) OVER(ORDER BY event_dt) AS grp
    FROM cte
)

SELECT
    event,
    MIN(event_dt) AS start_dt,
    MAX(event_dt) AS end_dt
FROM cte2
GROUP BY event, grp
ORDER BY start_dt;

CREATE database faheem_db; 















