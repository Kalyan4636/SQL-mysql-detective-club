-- STEP 0: Create and select database
-- ============================================
CREATE DATABASE sales_db;
USE sales_db;

-- STEP 1: Create the table
-- ============================================
CREATE TABLE employee_sales (
    order_id INT,
    employee_name VARCHAR(50),
    category VARCHAR(50),
    sales_amount INT,
    sales_date DATE
);

-- STEP 2: Insert sample data
-- ============================================
INSERT INTO employee_sales VALUES
(1, 'Amit',  'Electronics', 20000, '2024-01-05'),
(2, 'Amit',  'Electronics', 30000, '2024-01-05'),
(3, 'Ravi',  'Electronics', 40000, '2024-01-10'),
(4, 'Ravi',  'Electronics', 25000, '2024-01-10'),
(5, 'Neha',  'Electronics', 35000, '2024-01-15'),
(6, 'Neha',  'Electronics', 20000, '2024-01-15'),
(7,  'Kiran', 'Furniture', 30000, '2024-01-12'),
(8,  'Kiran', 'Furniture', 25000, '2024-01-12'),
(9,  'Pooja', 'Furniture', 20000, '2024-01-18'),
(10, 'Pooja', 'Furniture', 30000, '2024-01-18'),
(11, 'Suresh','Furniture', 40000, '2024-01-07'),
(12, 'Rahul', 'Clothing', 15000, '2024-01-06'),
(13, 'Rahul', 'Clothing', 15000, '2024-01-06'),
(14, 'Anita', 'Clothing', 25000, '2024-01-14'),
(15, 'Anita', 'Clothing', 20000, '2024-01-14'),
(16, 'Vikas', 'Clothing', 18000, '2024-01-20'),
(17, 'Vikas', 'Clothing', 17000, '2024-01-20');

-- STEP 3: Query to find 2nd highest total daily sales per category
SELECT
    category,
    employee_name,
    sales_date,
    total_sales
FROM (
    SELECT
        category,
        employee_name,
        sales_date,
        total_sales,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS rnk
    FROM (
        SELECT
            category,
            employee_name,
            sales_date,
            SUM(sales_amount) AS total_sales
        FROM employee_sales
        GROUP BY category, employee_name, sales_date
    ) AS daily_sales
) AS ranked_sales
WHERE rnk = 2;

