-- Identifying Top Trading Customers at Morgan Stanley 

CREATE DATABASE morgan_stanley_sql;
USE morgan_stanley_sql; 

-- Create trades Table 
CREATE TABLE trades (
    trade_id INT PRIMARY KEY,
    customer_id INT,
    trade_date DATE,
    trade_amount DECIMAL(15,2)
);

-- Insert Data
INSERT INTO trades
(trade_id, customer_id, trade_date, trade_amount)
VALUES
(1001, 123, '2022-06-10', 10000),
(1002, 456, '2022-06-11', 20000),
(1003, 789, '2022-06-12', 30000),
(1004, 123, '2022-07-10', 10000),
(1005, 456, '2022-07-12', 15000),
(1006, 789, '2022-07-12', 35000),
(1007, 123, '2022-07-15', 30000);

-- To find the top 5 customers by total trade amount for every month. 
WITH monthly_trades AS (
    SELECT
        MONTH(trade_date) AS month,
        customer_id,
        SUM(trade_amount) AS total_trade_amount
    FROM trades
    GROUP BY
        MONTH(trade_date),
        customer_id
),

ranked_customers AS (
    SELECT
        month,
        customer_id,
        total_trade_amount,
        DENSE_RANK() OVER (
            PARTITION BY month
            ORDER BY total_trade_amount DESC
        ) AS customer_rank
    FROM monthly_trades
)

SELECT
    month,
    customer_id,
    total_trade_amount
FROM ranked_customers
WHERE customer_rank <= 5
ORDER BY
    month,
    customer_rank;
















