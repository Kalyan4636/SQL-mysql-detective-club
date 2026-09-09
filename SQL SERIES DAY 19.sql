-- 1. Create Database 
CREATE DATABASE SQL_DAYS_CHALLENGE;
USE SQL_DAYS_CHALLENGE;

-- 2. Create Table
CREATE TABLE Sales_data (
    Sales_Date DATE,
    customer_id VARCHAR(10),
    item_id VARCHAR(10),
    sales_amount INT
);

-- Insert Data 
INSERT INTO Sales_data 
(Sales_Date, customer_id, item_id, sales_amount)
VALUES 
('2024-02-01', 'C101', 'A1', 200),
('2024-02-03', 'C101', 'A2', 250),
('2024-02-05', 'C102', 'A3', 300),
('2024-02-08', 'C101', 'A1', 150),
('2024-02-15', 'C102', 'A2', 200),
('2024-02-20', 'C103', 'A4', 400);

-- Find First & Second Purchase Dates -  Using ROW_NUMBER(): 
WITH Purchase_Ranked AS (
    SELECT
        customer_id,
        Sales_Date,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY Sales_Date
        ) AS purchase_rank
    FROM Sales_data
)

SELECT
    customer_id,
    MAX(CASE 
        WHEN purchase_rank = 1 
        THEN Sales_Date 
    END) AS first_purchase_date,

    MAX(CASE 
        WHEN purchase_rank = 2 
        THEN Sales_Date 
    END) AS second_purchase_date,

    DATEDIFF(
        MAX(CASE 
            WHEN purchase_rank = 2 
            THEN Sales_Date 
        END),
        MAX(CASE 
            WHEN purchase_rank = 1 
            THEN Sales_Date 
        END)
    ) AS days_between_purchases

FROM Purchase_Ranked
GROUP BY customer_id
HAVING COUNT(*) >= 2;








]