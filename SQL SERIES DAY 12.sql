-- Tiger Analytics SQL Assessment Questions  

-- Schema Definition
CREATE TABLE family (
    person_id VARCHAR(10) PRIMARY KEY,
    type VARCHAR(10) NOT NULL,
    age INT NOT NULL
);

-- Sample Dataset Insertion
INSERT INTO family (person_id, type, age) VALUES
('A1', 'Adult', 54),
('A2', 'Adult', 53),
('A3', 'Adult', 58),
('A4', 'Adult', 52),
('C1', 'Child', 20),
('C2', 'Child', 19),
('C3', 'Child', 15);

-- Scenario A : Adults $\ge$ Children (Standard Case) 
WITH RankedAdults AS (
    SELECT 
        person_id AS adult_id,
        age AS adult_age,
        ROW_NUMBER() OVER (ORDER BY age DESC) AS rnk
    FROM family
    WHERE type = 'Adult'
),
RankedChildren AS (
    SELECT 
        person_id AS child_id,
        age AS child_age,
        ROW_NUMBER() OVER (ORDER BY age DESC) AS rnk
    FROM family
    WHERE type = 'Child'
)
SELECT 
    a.adult_id,
    a.adult_age,
    c.child_id,
    c.child_age
FROM RankedAdults a
LEFT JOIN RankedChildren c ON a.rnk = c.rnk; 

-- Scenario B : Fully Dynamic (Handles Children > Adults in MySQL) 
WITH RankedAdults AS (
    SELECT 
        person_id AS adult_id,
        age AS adult_age,
        ROW_NUMBER() OVER (ORDER BY age DESC) AS rnk
    FROM family
    WHERE type = 'Adult'
),
RankedChildren AS (
    SELECT 
        person_id AS child_id,
        age AS child_age,
        ROW_NUMBER() OVER (ORDER BY age DESC) AS rnk
    FROM family
    WHERE type = 'Child'
),
AllRanks AS (
    SELECT rnk FROM RankedAdults
    UNION
    SELECT rnk FROM RankedChildren
)
SELECT 
    a.adult_id,
    a.adult_age,
    c.child_id,
    c.child_age
FROM AllRanks r
LEFT JOIN RankedAdults a ON r.rnk = a.rnk
LEFT JOIN RankedChildren c ON r.rnk = c.rnk
ORDER BY r.rnk; 




















