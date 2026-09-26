-- QUESTION ASKED BY ZS Accociates 

CREATE DATABASE ecommerce_company;
USE ecommerce_company;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    sales_amount DECIMAL(10,2) NOT NULL
);
-- INSERT data 
INSERT INTO products
    (product_id, product_name, category, sales_amount)
VALUES
    (1, 'Laptop',        'Electronics', 85000.00),
    (2, 'Mobile Phone',  'Electronics', 65000.00),
    (3, 'Tablet',        'Electronics', 45000.00),
    (4, 'Headphones',    'Electronics', 30000.00),
    (5, 'Smart Watch',   'Electronics', 30000.00),
    (6, 'Sports Shoes',  'Footwear',    18000.00),
    (7, 'Sneakers',      'Footwear',    18000.00),
    (8, 'Running Shoes', 'Footwear',    15000.00),
    (9, 'Formal Shoes',  'Footwear',    12000.00),
    (10, 'Sandals',      'Footwear',     8000.00),
    (11, 'Jacket',       'Clothing',    20000.00),
    (12, 'Jeans',        'Clothing',    15000.00),
    (13, 'Shirt',        'Clothing',    15000.00),
    (14, 'Hoodie',       'Clothing',    12000.00),
    (15, 'T-Shirt',      'Clothing',    10000.00);

-- FIND TOP 3 PRODUCTS IN EACH CATEGORY
-- USING DENSE_RANK()
WITH ranked_products AS (
    SELECT
        product_id,
        product_name,
        category,
        sales_amount,

        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY sales_amount DESC
        ) AS product_rank

    FROM products
)
SELECT
    product_id,
    product_name,
    category,
    sales_amount,
    product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY
    category,
    product_rank,
    sales_amount DESC;