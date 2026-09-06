CREATE DATABASE sql_day15;
USE sql_day15;

CREATE TABLE user_logins (
    user_id INT,
    login_time DATETIME
);

INSERT INTO user_logins (user_id, login_time) VALUES
(1, '2024-01-01 09:00:00'),
(1, '2024-01-03 10:00:00'),
(1, '2024-01-05 11:00:00'),
(2, '2024-01-01 09:00:00'),
(2, '2024-01-02 09:30:00'),
(2, '2024-01-04 10:00:00'),
(3, '2024-01-01 08:00:00'),
(3, '2024-01-03 08:00:00');

-- 4. SQL Query 
WITH distinct_logins AS (
    SELECT DISTINCT
        user_id,
        DATE(login_time) AS login_date
    FROM user_logins
),

user_days AS (
    SELECT
        user_id,
        login_date,
        LAG(login_date) OVER (
            PARTITION BY user_id
            ORDER BY login_date
        ) AS previous_login_date
    FROM distinct_logins
),

user_summary AS (
    SELECT
        user_id,
        COUNT(*) AS login_days,
        MAX(
            CASE
                WHEN DATEDIFF(login_date, previous_login_date) = 1
                THEN 1
                ELSE 0
            END
        ) AS has_consecutive_days
    FROM user_days
    GROUP BY user_id
)

SELECT user_id
FROM user_summary
WHERE login_days >= 3
  AND has_consecutive_days = 0;