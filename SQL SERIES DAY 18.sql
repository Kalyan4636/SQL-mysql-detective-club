-- 1. Create Database
CREATE DATABASE SQL_20_Day_Challenge;

-- Use Database
USE SQL_20_Day_Challenge;

-- 2. Create Table
CREATE TABLE Loyal_Customer (
    order_id      INT PRIMARY KEY,
    customer_id   INT,
    customer_name VARCHAR(50),
    order_date    DATE,
    order_amt     INT
);

-- 3. Insert Sample Data
INSERT INTO Loyal_Customer
(order_id, customer_id, customer_name, order_date, order_amt)
VALUES
(1,  101, 'Ratan Kumar',  '2025-01-15', 3000),
(2,  101, 'Ratan Kumar',  '2025-04-10', 4500),
(3,  101, 'Ratan Kumar',  '2025-08-22', 2800),
(4,  101, 'Ratan Kumar',  '2025-11-05', 3600),
(5,  102, 'Priya Singh',  '2025-02-18', 2200),
(6,  102, 'Priya Singh',  '2025-05-30', 1900),
(7,  102, 'Priya Singh',  '2025-09-12', 4100),
(8,  102, 'Priya Singh',  '2025-12-20', 3300),
(9,  103, 'Amit Sharma',  '2025-01-08', 1500),
(10, 103, 'Amit Sharma',  '2025-06-14', 2700),
(11, 103, 'Amit Sharma',  '2025-10-25', 3200),
(12, 104, 'Sneha Gupta',  '2025-03-05', 4000),
(13, 104, 'Sneha Gupta',  '2025-04-22', 2100),
(14, 105, 'Karan Mehta',  '2025-02-28', 1800),
(15, 105, 'Karan Mehta',  '2025-07-17', 5000),
(16, 105, 'Karan Mehta',  '2025-09-03', 2600),
(17, 105, 'Karan Mehta',  '2025-10-11', 3900),
(18, 105, 'Karan Mehta',  '2025-12-31', 4200),
(19, 106, 'Rohit Verma',  '2025-11-19', 1700);

-- 4. Check the Data
SELECT *
FROM Loyal_Customer;

-- 5. SQL Challenge
-- Find customers who placed at least one
-- order in every quarter of 2025 
SELECT
    customer_id,
    customer_name
FROM Loyal_Customer
WHERE YEAR(order_date) = 2025
GROUP BY
    customer_id,
    customer_name
HAVING COUNT(DISTINCT QUARTER(order_date)) = 4; 