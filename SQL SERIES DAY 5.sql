-- ============================================
-- 1. CREATE DATABASE
-- ============================================
CREATE DATABASE IF NOT EXISTS flight_tracker;
USE flight_tracker;

-- ============================================
-- 2. CREATE TABLE
-- ============================================
DROP TABLE IF EXISTS flights;

CREATE TABLE flights (
    flight_id   INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    origin      VARCHAR(10) NOT NULL,
    destination VARCHAR(10) NOT NULL
);

-- ============================================
-- 3. INSERT SAMPLE DATA
-- ============================================
-- Customer 1: JFK -> ORD -> DEN -> SFO (multi-hop)
-- Customer 2: LHR -> DXB -> SIN (multi-hop)
-- Customer 3: BOM -> DEL (single hop)
INSERT INTO flights (customer_id, origin, destination) VALUES
(1, 'ORD', 'DEN'),
(1, 'JFK', 'ORD'),
(1, 'DEN', 'SFO'),
(2, 'DXB', 'SIN'),
(2, 'LHR', 'DXB'),
(3, 'BOM', 'DEL');
-- 4. QUERY: RESOLVE TRUE START & END PER CUSTOMER
SELECT 
    s.customer_id,
    s.true_start,
    e.true_end
FROM (
    SELECT DISTINCT f.customer_id, f.origin AS true_start
    FROM flights f
    WHERE NOT EXISTS (
        SELECT 1 
        FROM flights f2
        WHERE f2.customer_id = f.customer_id
          AND f2.destination = f.origin
    )
) s
JOIN (
    SELECT DISTINCT f.customer_id, f.destination AS true_end
    FROM flights f
    WHERE NOT EXISTS (
        SELECT 1 
        FROM flights f2
        WHERE f2.customer_id = f.customer_id
          AND f2.origin = f.destination
    )
) e
ON s.customer_id = e.customer_id
ORDER BY s.customer_id;