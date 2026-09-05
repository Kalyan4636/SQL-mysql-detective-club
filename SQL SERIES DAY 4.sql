-- Interview Question:
-- Write a query to display the customer name, transaction type, transaction amount, 
-- and transaction date for all transactions.
CREATE DATABASE IF NOT EXISTS sql_practice;
USE sql_practice;

-- Create customers Table
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    created_at DATE
);

-- Create transactions Table
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    transaction_type VARCHAR(50),
    transaction_amount DECIMAL(10,2),
    transaction_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Answer to the interview question
SELECT 
    c.customer_name,
    t.transaction_type,
    t.transaction_amount,
    t.transaction_date
FROM transactions t
JOIN customers c ON t.customer_id = c.customer_id;








