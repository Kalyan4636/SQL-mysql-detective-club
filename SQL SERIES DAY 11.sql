CREATE DATABASE Latest_3_Values_DB;
USE Latest_3_Values_DB;

CREATE TABLE data_table (
    id INT,
    date DATE,
    x INT
);

INSERT INTO data_table (id, date, x) VALUES
(1, '2026-01-01', 10),
(1, '2026-01-05', 20),
(1, '2026-01-10', 30),
(1, '2026-01-15', 40),
(1, '2026-01-20', 50),
(2, '2026-01-02', 100),
(2, '2026-01-06', 200),
(2, '2026-01-11', 300),
(2, '2026-01-16', 400),
(2, '2026-01-21', 500);

-- MySQL Query --
WITH ranked_data AS (
    SELECT
        id,
        date,
        x,
        ROW_NUMBER() OVER (
            PARTITION BY id
            ORDER BY date DESC
        ) AS rn
    FROM data_table
)
SELECT
    id,
    MAX(CASE WHEN rn = 1 THEN x END) AS x_1,
    MAX(CASE WHEN rn = 2 THEN x END) AS x_2,
    MAX(CASE WHEN rn = 3 THEN x END) AS x_3
FROM ranked_data
WHERE rn <= 3
GROUP BY id
ORDER BY id;