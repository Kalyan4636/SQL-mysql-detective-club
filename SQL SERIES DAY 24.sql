-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS ride_sharing;
USE ride_sharing;

-- 2. Create tables
CREATE TABLE drivers (
    driver_id     INT PRIMARY KEY,
    signup_date   DATE NOT NULL
);

CREATE TABLE rides (
    ride_id       INT PRIMARY KEY,
    driver_id     INT NOT NULL,
    ride_date     DATE NOT NULL,
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id)
);

-- 3. Sample data
INSERT INTO drivers (driver_id, signup_date) VALUES
(1, '2026-01-01'),   -- first ride 2 days later  -> qualifies
(2, '2026-01-05'),   -- first ride 15 days later -> does NOT qualify
(3, '2026-02-01'),   -- first ride same day      -> qualifies
(4, '2026-02-10'),   -- no rides at all          -> excluded
(5, '2026-03-01');   -- first ride exactly 7 days -> qualifies

INSERT INTO rides (ride_id, driver_id, ride_date) VALUES
(101, 1, '2026-01-03'),
(102, 1, '2026-01-10'),
(103, 2, '2026-01-20'),
(104, 2, '2026-01-25'),
(105, 3, '2026-02-01'),
(106, 3, '2026-02-05'),
(107, 5, '2026-03-08'),
(108, 5, '2026-03-15');

-- 4. Solution query
WITH first_ride AS (
    SELECT
        driver_id,
        MIN(ride_date) AS first_ride_date
    FROM rides
    GROUP BY driver_id
)
SELECT
    d.driver_id,
    d.signup_date,
    f.first_ride_date
FROM drivers d
JOIN first_ride f
    ON d.driver_id = f.driver_id
WHERE DATEDIFF(f.first_ride_date, d.signup_date) <= 7;