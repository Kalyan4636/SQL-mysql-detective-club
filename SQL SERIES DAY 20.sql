-- SQL Interview Questions
-- Scenario: Detect if a user has active subscriptions with overlapping start and end dates.

-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS sql_interview_day2;
USE sql_interview_day2;

-- 2. Create the subscriptions table
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id          INT NOT NULL,
    plan_name        VARCHAR(50),
    start_date       DATE NOT NULL,
    end_date         DATE NOT NULL
);

-- 3. insert  data
-- user 101 -> two subscriptions overlap (Jan 10 - Feb 15 & Feb 01 - Mar 05)
-- user 102 -> subscriptions do NOT overlap (back-to-back / gap)
-- user 103 -> single subscription, nothing to compare
INSERT INTO subscriptions (subscription_id, user_id, plan_name, start_date, end_date) VALUES
(1, 101, 'Basic',   '2026-01-10', '2026-02-15'),
(2, 101, 'Premium', '2026-02-01', '2026-03-05'),
(3, 102, 'Basic',   '2026-01-01', '2026-01-31'),
(4, 102, 'Premium', '2026-02-01', '2026-02-28'),
(5, 103, 'Basic',   '2026-01-01', '2026-12-31');

-- 4. Query: find users whose subscriptions have overlapping date ranges
-- Two ranges [s1.start, s1.end] and [s2.start, s2.end] overlap when:
-- s1.start_date <= s2.end_date
-- AND s1.end_date   >= s2.start_date
SELECT DISTINCT
    s1.user_id,
    s1.subscription_id AS subscription_1,
    s2.subscription_id AS subscription_2,
    s1.start_date AS sub1_start,
    s1.end_date   AS sub1_end,
    s2.start_date AS sub2_start,
    s2.end_date   AS sub2_end
FROM subscriptions s1
JOIN subscriptions s2
    ON s1.user_id = s2.user_id
   AND s1.subscription_id < s2.subscription_id   -- avoid self-pairing and duplicate mirror pairs
WHERE s1.start_date <= s2.end_date
  AND s1.end_date   >= s2.start_date;

-- 5. (Optional) Just the list of user_ids that have an overlap
SELECT DISTINCT s1.user_id
FROM subscriptions s1
JOIN subscriptions s2
    ON s1.user_id = s2.user_id
   AND s1.subscription_id < s2.subscription_id
WHERE s1.start_date <= s2.end_date
  AND s1.end_date   >= s2.start_date;