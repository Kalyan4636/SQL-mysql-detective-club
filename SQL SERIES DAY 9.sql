-- SQL INTERVIEW QUESTION ASKED AT JPMORGAN CHASE

CREATE DATABASE MorganStanley_SQL;
USE MorganStanley_SQL;  

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
); 

INSERT INTO Employees 
(EmployeeID, EmployeeName, Department, Salary)
VALUES
(1, 'Rahul Sharma', 'Technology', 95000),
(2, 'Priya Singh', 'Technology', 120000),
(3, 'Amit Kumar', 'Technology', 110000),
(4, 'Neha Verma', 'Technology', 105000),
(5, 'Rohit Gupta', 'Technology', 85000),

(6, 'Anjali Mehta', 'Finance', 115000),
(7, 'Vikas Jain', 'Finance', 98000),
(8, 'Sneha Roy', 'Finance', 125000),
(9, 'Arjun Das', 'Finance', 90000),
(10, 'Pooja Shah', 'Finance', 105000),

(11, 'Karan Malhotra', 'HR', 75000),
(12, 'Riya Kapoor', 'HR', 85000),
(13, 'Sanjay Rao', 'HR', 95000),
(14, 'Meena Joshi', 'HR', 90000),
(15, 'Varun Sinha', 'HR', 80000); 

-- Interview Question
-- Write a SQL query to find the top 3 highest-paid employees in each department. 
-- Solution Using DENSE_RANK() 
WITH RankedEmployees AS (
    SELECT
        EmployeeID,
        EmployeeName,
        Department,
        Salary,
        DENSE_RANK() OVER (
            PARTITION BY Department
            ORDER BY Salary DESC
        ) AS SalaryRank
    FROM Employees
)
SELECT
    EmployeeID,
    EmployeeName,
    Department,
    Salary
FROM RankedEmployees
WHERE SalaryRank <= 3
ORDER BY Department, Salary DESC;


















