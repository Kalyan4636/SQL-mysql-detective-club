-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS SWiggy_Question;
USE SWiggy_Question;

-- 2. Create the table
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id       INT AUTO_INCREMENT PRIMARY KEY,
    driver_id      INT NOT NULL,
    order_time     DATETIME NOT NULL,
    delivered_time DATETIME NULL   -- NULL = not delivered / cancelled
);

-- 3. Insert sample data
INSERT INTO orders (driver_id, order_time, delivered_time) VALUES
(101, '2026-09-20 12:00:00', '2026-09-20 12:32:10'),
(101, '2026-09-20 13:15:00', '2026-09-20 13:41:45'),
(101, '2026-09-20 19:00:00', NULL),
(102, '2026-09-20 12:10:00', '2026-09-20 12:55:00'),
(102, '2026-09-20 14:00:00', '2026-09-20 14:28:30'),
(103, '2026-09-20 20:00:00', '2026-09-20 20:22:15'),
(103, '2026-09-20 21:00:00', '2026-09-20 21:35:40');

-- 4. Run the query
SELECT
    driver_id,
    COUNT(*) AS delivered_orders,
    ROUND(AVG(TIMESTAMPDIFF(SECOND, order_time, delivered_time)) / 60, 2) AS avg_delivery_time_min
FROM orders
WHERE delivered_time IS NOT NULL
  AND delivered_time >= order_time
GROUP BY driver_id
ORDER BY avg_delivery_time_min;