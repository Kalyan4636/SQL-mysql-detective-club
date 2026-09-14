-- Step 1: Create Database
CREATE DATABASE employee_db;

-- Step 2: Use Database
USE employee_db;

-- Step 3: Create Employee Table
CREATE TABLE Employee (
Employee_Name VARCHAR(50),
Department VARCHAR(50),
Salary INT
);

-- Step 4: Insert Sample Data
INSERT INTO Employee (Employee_Name, Department, Salary)
VALUES
('A', 'IT', 80000),
('B', 'IT', 90000),
('C', 'IT', 90000),
('D', 'HR', 70000),
('E', 'HR', 80000);

-- Step 5: View the Data
SELECT *
FROM Employee;

-- SOLUTION
SELECT
Employee_Name,
Department,
Salary
FROM
(
SELECT
Employee_Name,
Department,
Salary,
DENSE_RANK() OVER (
PARTITION BY Department
ORDER BY Salary DESC
) AS Salary_Rank
FROM Employee
) AS RankedEmployees
WHERE Salary_Rank = 2;

