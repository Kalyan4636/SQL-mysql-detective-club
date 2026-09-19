-- Create Database
CREATE DATABASE employee_salary_analysis;

-- Use Database
USE employee_salary_analysis;

-- Create Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(100),
    salary DECIMAL(10,2)
);

-- Insert Sample Data
INSERT INTO employees
(employee_id, employee_name, department, salary)
VALUES
(101, 'Rahul', 'IT', 60000),
(102, 'Priya', 'HR', 50000),
(103, 'Amit', 'Finance', 60000),
(104, 'Sneha', 'IT', 70000),
(105, 'Rohit', 'HR', 60000),
(106, 'Neha', 'Finance', 80000);

-- Find employees who have the same salary
-- but belong to different departments
SELECT DISTINCT
    e1.employee_id,
    e1.employee_name,
    e1.department,
    e1.salary
FROM employees e1
JOIN employees e2
    ON e1.salary = e2.salary
    AND e1.department <> e2.department
WHERE e1.employee_id <> e2.employee_id; 