Create database faheem_db; 

USE faheem_db; 

-- CREATE TABLE 
CREATE TABLE Student ( 
Student_id int primary key
auto_increment,
Student_name varchar (100) 
not null,
age int, 
gender varchar(10),
city varchar(50)
) 

-- Insert data 
INSERT INTO Student (Student_name, age, gender, city) Values 
('Faheem', 23, 'Male', 'Noida'), 
('Aditya', 23, 'Male', 'Gajiabad'), 
('Rahul', 23, 'Male', 'Kanpur'), 
('Nisha', 23, 'Female', 'Delhi'); 

-- values Viwe all records in data. 
select * FROM Student;  

-- Values view by specific COLUMNS - city
Select Student_name, city 
FROM Student; 

-- View Specific columns by Update a records. 
select Student_name, city 
FROM Student;  

update Student 
SET city = 'Gurgaon'
where Student_id = 1;  

-- Delete a records
delete FROM student
where Student_id = 4; 

-- Drop Table
Drop table Student; 

-- 













