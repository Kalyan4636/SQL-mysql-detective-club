-- Find products whose sales increased compared to the previous month

-- 1. Create Database
CREATE DATABASE ecommerce_db;

-- 2. Use Database
USE ecommerce_db;

-- 3. Create Sales Table
CREATE TABLE sales (
    product_id INT,
    sale_month DATE,
    total_sales DECIMAL(10,2)
);

-- 4. Insert Sample Data
INSERT INTO sales (product_id, sale_month, total_sales)
VALUES
(101, '2026-01-01', 10000),
(101, '2026-02-01', 12000),
(101, '2026-03-01', 11000),
(101, '2026-04-01', 15000),
(102, '2026-01-01', 15000),
(102, '2026-02-01', 18000),
(102, '2026-03-01', 20000),
(102, '2026-04-01', 19000),
(103, '2026-01-01', 8000),
(103, '2026-02-01', 7500),
(103, '2026-03-01', 9000);

-- 5. View the Data
SELECT *
FROM sales;

-- 6. Find Products Whose Sales Increased
-- Compared to the Previous Month
WITH monthly_sales AS (
    SELECT
        product_id,
        sale_month,
        total_sales,
        LAG(total_sales) OVER (
            PARTITION BY product_id
            ORDER BY sale_month
        ) AS previous_month_sales
    FROM sales
)

SELECT
    product_id,
    sale_month,
    total_sales,
    previous_month_sales
FROM monthly_sales
WHERE total_sales > previous_month_sales;