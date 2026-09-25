-- EY SQL INTERVIEW QUESTION
-- Find the highest-revenue product for every month
-- 1. CREATE DATABASE
CREATE DATABASE ey_sql_interview;

-- Select database
USE ey_sql_interview;


-- ============================================================
-- 2. CREATE SALES TABLE
-- ============================================================

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    sale_date DATE,
    product_name VARCHAR(100),
    category VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(10,2)
);
-- ============================================================
-- 3. INSERT DATA
-- ============================================================

INSERT INTO sales
(sale_id, sale_date, product_name, category, quantity, unit_price)
VALUES

-- January
(1, '2026-01-05', 'Laptop', 'Electronics', 5, 70000),
(2, '2026-01-10', 'Mobile', 'Electronics', 10, 30000),
(3, '2026-01-15', 'Headphones', 'Accessories', 20, 2000),
(4, '2026-01-20', 'Laptop', 'Electronics', 3, 70000),

-- February
(5, '2026-02-03', 'Mobile', 'Electronics', 15, 30000),
(6, '2026-02-08', 'Laptop', 'Electronics', 4, 70000),
(7, '2026-02-14', 'Headphones', 'Accessories', 30, 2000),
(8, '2026-02-20', 'Tablet', 'Electronics', 10, 25000),

-- March
(9, '2026-03-02', 'Laptop', 'Electronics', 8, 70000),
(10, '2026-03-07', 'Mobile', 'Electronics', 20, 30000),
(11, '2026-03-15', 'Tablet', 'Electronics', 15, 25000),
(12, '2026-03-25', 'Headphones', 'Accessories', 40, 2000),

-- April
(13, '2026-04-04', 'Mobile', 'Electronics', 25, 30000),
(14, '2026-04-12', 'Laptop', 'Electronics', 6, 70000),
(15, '2026-04-18', 'Tablet', 'Electronics', 20, 25000),
(16, '2026-04-25', 'Headphones', 'Accessories', 50, 2000);
-- ============================================================
-- 4. CHECK THE DATA
-- ============================================================

SELECT *
FROM sales;


-- ============================================================
-- 5. CALCULATE REVENUE FOR EACH SALE     Revenue = Quantity × Unit Price
-- ============================================================
SELECT
    sale_id,
    sale_date,
    product_name,
    quantity,
    unit_price,
    quantity * unit_price AS revenue
FROM sales;


-- ============================================================
-- 6. FIND MONTHLY REVENUE BY PRODUCT
-- ============================================================

SELECT
    DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
    product_name,
    SUM(quantity * unit_price) AS total_revenue
FROM sales
GROUP BY
    DATE_FORMAT(sale_date, '%Y-%m'),
    product_name
ORDER BY
    sales_month,
    total_revenue DESC;


-- ============================================================
-- 7. FINAL ANSWER
-- Find the highest-revenue product for every month
-- ============================================================

WITH monthly_revenue AS (

    SELECT
        DATE_FORMAT(sale_date, '%Y-%m') AS sales_month,
        product_name,
        SUM(quantity * unit_price) AS total_revenue

    FROM sales

    GROUP BY
        DATE_FORMAT(sale_date, '%Y-%m'),
        product_name
),

ranked_products AS (

    SELECT
        sales_month,
        product_name,
        total_revenue,

        DENSE_RANK() OVER (
            PARTITION BY sales_month
            ORDER BY total_revenue DESC
        ) AS revenue_rank

    FROM monthly_revenue
)

SELECT
    sales_month,
    product_name,
    total_revenue

FROM ranked_products

WHERE revenue_rank = 1

ORDER BY sales_month;