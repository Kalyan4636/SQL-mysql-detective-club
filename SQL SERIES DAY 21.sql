-- ============================================================
-- SQL Interview Question - Day 3 
-- Scenario: A subscription company wants to find users who
--           have never cancelled their subscription.
-- Concept Tested: LEFT JOIN + Filtering in JOIN Condition +
--                 Finding Missing Records
-- ============================================================

-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS sql_interview_day3;
USE sql_interview_day3;

-- 2. Create the tables
CREATE TABLE users (
    user_id   INT PRIMARY KEY,
    user_name VARCHAR(50) NOT NULL
);

CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id         INT NOT NULL,
    status          VARCHAR(20) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- 3. data
-- Alice   -> only Active subscriptions        -> should appear in result
-- Bob     -> has a Cancelled subscription      -> should NOT appear
-- Charlie -> Active, then later Cancelled      -> should NOT appear
-- Diana   -> no subscription rows at all       -> should appear (never cancelled)
INSERT INTO users (user_id, user_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana');

INSERT INTO subscriptions (subscription_id, user_id, status) VALUES
(101, 1, 'Active'),
(102, 2, 'Cancelled'),
(103, 3, 'Active'),
(104, 3, 'Cancelled'),
(105, 1, 'Active');

-- 4. Solution: find users who have never cancelled their subscription
-- LEFT JOIN only on the 'Cancelled' rows, then keep users where no
-- matching cancelled row was found (s.user_id IS NULL).
SELECT u.*
FROM users u
LEFT JOIN subscriptions s
    ON u.user_id = s.user_id
   AND s.status = 'Cancelled'
WHERE s.user_id IS NULL;

