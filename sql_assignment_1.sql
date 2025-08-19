SET SQL_SAFE_UPDATES=0;
/*1. Create new database & employee table (based on give sample data)
create employee table with primary key (EmployeeID)*/
CREATE DATABASE my_assignment1;
use  my_assignment1;
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    salary DECIMAL(10,2),
    joining_date DATE,
    department VARCHAR(20),
    gender VARCHAR(10),
    job_title VARCHAR(20));

#2.Insert sample data into the table.
INSERT INTO staff (staff_id, first_name, last_name, salary, joining_date, department, gender, job_title  ) VALUES (1, 'Vikas',   'Kumar',    65000.00, '2021-07-01', 'IT',      'Male',   'Software Engineer'),
(2, 'Nikita',  'Sharma',   52000.00, '2020-11-15', 'HR',      'Female', 'HR Executive'),
(3, 'Meena',   'Verma',    48000.00, '2022-04-10', 'Finance', 'Female', 'Accountant'),
(4, 'Anjali',  'Jain',     57000.00, '2021-01-04', 'IT',      'Female', 'System Analyst'),
(5, 'Malli',   'Rao',      80000.00, '2019-06-22', 'IT',      'Male',   'Project Manager'),
(6, 'Ashish',  'Gupta',    60000.00, '2023-01-20', 'HR',      'Male',   'Recruiter'),
(7, 'Nikhil',  'Mehra',    46000.00, '2024-03-18', 'Finance', 'Male',   'Finance Analyst'),
(8, 'Anish',   'Sen',      70500.00, '2022-10-05', 'Finance', 'Male',   'Finance Manager'),
(9, 'Vivek',   'Patel',    54000.00, '2021-08-14', 'IT',      'Male',   'Data Scientist'),
(10, 'Sneha',  'Das',      43000.00, '2024-05-07', 'HR',      'Female', 'HR Associate');   

#3. Write a query to create a clone of an existing table using Create Command. 
CREATE TABLE staff_clone LIKE staff;

#4. Write a query to get all employee detail from "employee" table
select * from staff;

#5. Select only top 1 record from employee table
SELECT * FROM staff LIMIT 1;

#6. Select only bottom 1 record from employee table
SELECT * FROM staff ORDER BY staff_id DESC LIMIT 1;

#7. How to select a random record from a table?
SELECT * FROM staff ORDER BY RAND() LIMIT 1;

-- 8. Write a query to get
-- “first_name” in upper case as "first_name_upper"
-- ‘first_name’ in lower case as ‘first_name_lower”
-- Create a new column “full_name” by combining “first_name” &
-- “last_name” with space as a separator.
-- Add 'Hello ' to first_name and display result
-- Upper and lower
SELECT UPPER(first_name) AS first_name_upper, LOWER(first_name) AS first_name_lower FROM staff;

-- Add full_name column and update
ALTER TABLE staff ADD COLUMN full_name VARCHAR(45);
UPDATE staff SET full_name = CONCAT(first_name, ' ', last_name);

-- Add 'Hello '
SELECT CONCAT('Hello ', first_name) AS hello_name FROM staff;

-- 9.Select the employee details of
-- Whose “first_name” is ‘Malli’
-- Whose “first_name” present in ("Malli","Meena", "Anjali")
-- Whose “first_name” not present in ("Malli","Meena", "Anjali")
-- Whose “first_name” starts with “v”
-- Whose “first_name” ends with “i”
-- Whose “first_name” contains “o”
-- Whose "first_name" start with any single character between 'm-v'
-- Whose "first_name" not start with any single character between 'm-v'
-- Whose "first_name" start with 'M' and contain 5 letters 
SELECT * FROM staff WHERE first_name = 'Malli';
SELECT * FROM staff WHERE first_name IN ('Malli','Meena','Anjali');
SELECT * FROM staff WHERE first_name NOT IN ('Malli','Meena','Anjali');
SELECT * FROM staff WHERE first_name LIKE 'v%';
SELECT * FROM staff WHERE first_name LIKE '%i';
SELECT * FROM staff WHERE first_name LIKE '%o%';
SELECT * FROM staff WHERE first_name REGEXP '^[m-v]';
SELECT * FROM staff WHERE first_name NOT REGEXP '^[m-v]';
SELECT * FROM staff WHERE first_name LIKE 'M____';

# 10. Write a query to get all unique values of"department" from the employee table.
SELECT DISTINCT department FROM staff;

#11. Query to check the total records present in a table.
SELECT COUNT(*) AS total_staff FROM staff;

#12. Write down the query to print first letter of a Name in Upper Case and all otherletter in Lower Case.(EmployDetail table)
SELECT CONCAT(UPPER(SUBSTRING(first_name,1,1)), LOWER(SUBSTRING(first_name,2))) AS nice_name FROM staff;

#13. Write down the query to display all employee name in one cell separated by ',' ex:-"Vikas, nikita, Ashish, Nikhil , anish"(EmployDetail table).
SELECT GROUP_CONCAT(first_name SEPARATOR ', ') AS names_list FROM staff;

-- 14.Query to get the below values of "salary" from employee table
-- Lowest salary
-- Highest salary
-- Average salary
-- Highest salary - Lowest salary as diff_salary
-- % of difference between Highest salary and lowest salary. (sample output
-- format: 10.5%)
SELECT 
    MIN(salary) AS min_sal,
    MAX(salary) AS max_sal,
    ROUND(AVG(salary),2) AS avg_sal,
    MAX(salary) - MIN(salary) AS diff_salary,
    CONCAT(ROUND((MAX(salary)-MIN(salary))/MIN(salary)*100,2),'%') AS percent_diff
FROM staff;

/*15. Select “first_name” from the employee table after removing white spaces from
Right side spaces
Left side spaces
Both right & left side spaces
*/
SELECT RTRIM(first_name) AS right_trim, LTRIM(first_name) AS left_trim, TRIM(first_name) AS trimmed FROM staff;

#16. Query to check no.of records present in a table where employees having 50k salary.
SELECT COUNT(*) FROM staff WHERE salary>50000;

#17. Find the most recently hired employee in each department
SELECT * FROM staff s
WHERE joining_date = (SELECT MAX(joining_date) FROM staff WHERE department=s.department);

#-------Case When Then End Statement Queries
#1.Display first_name and gender as M/F.(if male then M, if Female then F)
SELECT first_name, CASE WHEN gender='Male' THEN 'M' WHEN gender='Female' THEN 'F' END AS gender_shorT FROM STAFF;

-- 2.4Display first_name, salary, and a salary category. (If salary is below 50,000, categorize
-- as 'Low'; between 50,000 and 60,000 as 'Medium'; above 60,000 as 'High')
SELECT first_name, salary, 
  CASE 
    WHEN salary < 50000 THEN 'Low'
    WHEN salary BETWEEN 50000 AND 60000 THEN 'Medium'
    ELSE 'High'
  END AS salary_category FROM staff;
  
-- 3.Display first_name, department, and a department classification. (If department is
-- 'IT', display 'Technical'; if 'HR', display 'Human Resources'; if 'Finance', display
-- 'Accounting'; otherwise, display 'Other')
SELECT first_name, department,
  CASE 
    WHEN department = 'IT' THEN 'Technical'
    WHEN department = 'HR' THEN 'Human Resources'
    WHEN department = 'Finance' THEN 'Accounting'
    ELSE 'Other'
  END AS dept_class FROM staff;
  
-- 4.Display first_name, salary, and eligibility for a salary raise. (If salary is less than
-- 50,000, mark as 'Eligible for Raise'; otherwise, 'Not Eligible')
SELECT first_name, salary,
  CASE WHEN salary < 50000 THEN 'Eligible for Raise' ELSE 'Not Eligible' END AS raise_eligibility FROM staff;
  
--   5.Display first_name, joining_date, and employment status. (If joining date is before
-- '2022-01-01', mark as 'Experienced'; otherwise, 'New Hire')
SELECT first_name, joining_date,
  CASE WHEN joining_date < '2022-01-01' THEN 'Experienced' ELSE 'New Hire' END AS status FROM STAFF;
  
 -- 6.\Display first_name, salary, and bonus amount. (If salary is above 60,000, add10%
-- bonus; if between 50,000 and 60,000, add 7%; otherwise, 5%)
SELECT first_name, salary,
  CASE 
    WHEN salary > 60000 THEN salary * 1.10
    WHEN salary BETWEEN 50000 AND 60000 THEN salary * 1.07
    ELSE salary * 1.05
  END AS bonus_amount FROM STAFF;
  
#7.Display first_name, salary, and seniority level.
SELECT first_name,salary,seniority_level FROM STAFF;

-- 8.(If salary is greater than 60,000, classify as 'Senior'; between 50,000 and 60,000 as
-- 'Mid-Level'; below 50,000 as 'Junior')
SELECT first_name, salary,
  CASE 
    WHEN salary > 60000 THEN 'Senior'
    WHEN salary BETWEEN 50000 AND 60000 THEN 'Mid-Level'
    ELSE 'Junior'
  END AS seniority_level FROM STAFF;


#9. Display first_name, salary, and seniority leveL
SELECT first_name,salary,seniority_level FROM STAFF;
  
--  10. (If salary is greater than 60,000, classify as 'Senior'; between 50,000 and 60,000 as
-- 'Mid-Level'; below 50,000 as 'Junior')
SELECT first_name, salary,
  CASE 
    WHEN salary > 60000 THEN 'Senior'
    WHEN salary BETWEEN 50000 AND 60000 THEN 'Mid-Level'
    ELSE 'Junior'
  END AS seniority_level FROM STAFF;
  
 --  11.Display first_name, department, and job level for IT employees. (If department is 'IT'
-- and salary is greater than 55,000, mark as 'Senior IT Employee'; otherwise, 'Other').
SELECT first_name, department, 
  CASE
    WHEN department = 'IT' AND salary > 55000 THEN 'Senior IT Employee'
    ELSE 'Other'
  END AS level_it_employees
FROM staff
WHERE department='IT';

-- 12. Display first_name, joining_date, and recent joiner status. (If an employee joined
-- after '2024-01-01', label as 'Recent Joiner'; otherwise, 'Long-Term Employee')
SELECT first_name, joining_date,
  CASE WHEN joining_date >= '2024-01-01' THEN 'Recent Joiner' ELSE 'Long-Term Employee' END AS join_status FROM STAFF;

-- 13. Display first_name, joining_date, and leave entitlement. (If joined before '2021-01-
-- 01', assign '10 Days Leave'; between '2021-01-01' and '2023-01-01', assign '20 Days
-- Leave'; otherwise, '25 Days Leave')
 SELECT first_name, joining_date,
  CASE 
    WHEN joining_date < '2021-01-01' THEN '10 Days Leave'
    WHEN joining_date BETWEEN '2021-01-01' AND '2023-01-01' THEN '20 Days Leave'
    ELSE '25 Days Leave'
  END AS leave_days FROM STAFF;
  
-- 14. Display first_name, salary, department, and promotion eligibility. (If salary is above
-- 60,000 and department is 'IT', mark as 'Promotion Eligible'; otherwise, 'Not Eligible')
SELECT first_name, salary, department,
  CASE WHEN department='IT' AND salary > 60000 THEN 'Promotion Eligible' ELSE 'Not Eligible' END AS promotion_eligibility FROM STAFF;

-- 15. Display first_name, salary, and overtime pay eligibility. (If salary is below 50,000,
-- mark as 'Eligible for Overtime Pay'; otherwise, 'Not Eligible')
SELECT first_name, salary,
  CASE WHEN salary < 50000 THEN 'Eligible for Overtime Pay' ELSE 'Not Eligible' END AS overtime_eligibility FROM STAFF;
  
-- 16.Display first_name, department, salary, and job title. (If department is 'HR' and salary
-- is above 60,000, mark as 'HR Executive'; if department is 'Finance' and salary is above
-- 55,000, mark as 'Finance Manager'; otherwise, 'Regular Employee')
SELECT first_name, department, salary,
  CASE 
    WHEN department='HR' AND salary>60000 THEN 'HR Executive'
    WHEN department='Finance' AND salary>55000 THEN 'Finance Manager'
    ELSE 'Regular Employee'
  END AS job_title_corrected FROM STAFF;
  
--   17. Display first_name, salary, and salary comparison to the company average. (If salary is
-- above the company’s average salary, mark as 'Above Average'; otherwise, 'Below
-- Average')
SELECT first_name, salary,
  CASE
    WHEN salary > (SELECT AVG(salary) FROM staff) THEN 'Above Average'
    ELSE 'Below Average'
  END AS salary_cmp FROM STAFF;
  
##-------------Group by
-- 1.Write the query to get the department and department wise total(sum) salary,
-- display it in ascending and descending order according to salary.
SELECT department, SUM(salary) AS total_salary FROM staff GROUP BY department ORDER BY total_salary;
SELECT department, SUM(salary) AS total_salary FROM staff GROUP BY department ORDER BY total_salary DESC;

#2.Write down the query to fetch Project name assign to more than one Employee
SELECT project_name FROM project_details GROUP BY project_name HAVING COUNT(staff_id_no) > 1;

-- 3.Write the query to get the department, total no. of departments, total(sum) salary
-- with respect to department from "employee table" table.
SELECT department, (SELECT COUNT(DISTINCT department) FROM staff) AS total_departments, SUM(salary) FROM STAFF GROUP BY department;

-- 4.Get the department-wise salary details from the "employee table" table:
-- What is the average salary? (Order by salary ascending)
-- What is the maximum salary? (Order by salary ascending)
SELECT department, ROUND(AVG(salary),2) AS avg_dept_salary, MAX(salary) AS max_dept_salary FROM staff GROUP BY department ORDER BY avg_dept_salary;

-- 5. Display department-wise employee count and categorize based on size. (If a department
-- has more than 5 employees, label it as 'Large'; between 3 and 5 as 'Medium'; otherwise,
-- 'Small')
 SELECT department, COUNT(staff_id) AS total_employees,
   CASE 
     WHEN COUNT(staff_id)>5 THEN 'Large'
     WHEN COUNT(staff_id) BETWEEN 3 AND 5 THEN 'Medium'
     ELSE 'Small'
   END AS dept_size FROM STAFF GROUP BY department;

-- 6. Display department-wise average salary and classify pay levels. (If the average salary in a
-- department is above 60,000, label it as 'High Pay'; between 50,000 and 60,000
-- as 'Medium Pay'; otherwise, 'Low Pay').
SELECT department, ROUND(AVG(salary),2) AS avg_dept_salary,
  CASE
   WHEN AVG(salary) > 60000 THEN 'High Pay'
     WHEN AVG(salary) BETWEEN 50000 AND 60000 THEN 'Medium Pay'
  ELSE 'Low Pay'
  END AS pay_level FROM STAFF GROUP BY department;

-- 7. Display department, gender, and count of employees in each category. (Group by
-- department and gender, showing total employees in each combination)
SELECT department,gender, COUNT(staff_id) FROM staff GROUP BY department,gender ORDER BY department,gender;

-- 8. Display the number of employees who joined each year and categorize hiring trends. (If a
-- year had more than 5 hires, mark as 'High Hiring'; 3 to 5 as 'Moderate Hiring'; otherwise,
-- 'Low Hiring')
SELECT YEAR(joining_date) AS joined_year, COUNT(staff_id) AS total_staff,
  CASE
     WHEN COUNT(staff_id) > 5 THEN 'High Hiring'
     WHEN COUNT(staff_id) BETWEEN 3 AND 5 THEN 'Moderate Hiring'
     ELSE 'Low Hiring'
  END AS hiring_trend FROM STAFF GROUP BY joined_year;

-- 9. Display department-wise highest salary and classify senior roles. (If the highest salary in a
-- department is above 70,000, label as 'Senior Leadership'; otherwise, 'Mid-Level')
SELECT department,
 CASE WHEN MAX(salary) > 70000 THEN 'Senior Leadership' ELSE 'Mid-Level' END AS leadership_level FROM STAFF GROUP BY department;

-- 10. Display department-wise count of employees earning more than 60,000. (Group
-- employees by department and count those earning above 60,000, labeling departments
-- with more than 2 such employees as 'High-Paying Team')
SELECT department, COUNT(staff_id) AS num_high_salary,
  CASE WHEN COUNT(staff_id) > 2 THEN 'High-Paying Team' ELSE 'Low Paying Team' END AS team_label
FROM staff WHERE salary > 60000 GROUP BY department;

##--------------Date time related queries
-- 1.Query to extract the below things from joining_date column. (Year, Month, Day, Current
-- Date)
SELECT YEAR(joining_date) AS year_joining, MONTH(joining_date) AS joining_month, DAY(joining_date) AS joining_day, CURDATE() AS today FROM STAFF;

-- 2.Create two new columns that calculate the difference between joining_date and the
-- current date. One column should show the difference in months, and the other should
-- show the difference in days

ALTER TABLE staff ADD COLUMN month_diff INT;
ALTER TABLE staff ADD COLUMN day_diff INT;
UPDATE staff SET day_diff = DATEDIFF(CURDATE(), joining_date);
UPDATE staff SET month_diff = TIMESTAMPDIFF(MONTH, joining_date, CURDATE());

#3.Get all employee details from the employee table whose joining year is 2020.
SELECT * FROM staff WHERE YEAR(joining_date)=2020;

#4.Get all employee details from the employee table whose joining month is Feb.
SELECT * FROM staff WHERE MONTH(joining_date)=2;

-- 5.Get all employee details from employee table whose joining date between "2021-01-01"
-- and "2021-12-01"
SELECT * FROM staff WHERE joining_date BETWEEN '2021-01-01' AND '2021-12-01';

##------------Joins Related queries
-- 1.Get the employee name and project name from the "employee table" and
-- "ProjectDetail" for employees who have been assigned a project, sorted by first name.
SELECT s.first_name, p.project_name
FROM staff s
JOIN project_details p ON s.staff_id = p.staff_id_no ORDER BY s.first_name;

-- 2.Get the employee name and project name from the "employee table" and
-- "ProjectDetail" for all employees, including those who have not been assigned a project,
-- sorted by first name.
SELECT s.first_name, p.project_name
FROM staff s
LEFT JOIN project_details p ON s.staff_id = p.staff_id_no ORDER BY s.first_name;

-- 3.Get the employee name and project name from the "employee table" and
-- "ProjectDetail" for all employees. If an employee has no assigned project, display "-No
-- Project Assigned," sorted by first name.
SELECT s.first_name, IFNULL(p.project_name, 'Not Assigned') AS project_name
FROM staff s
LEFT JOIN project_details p ON s.staff_id = p.staff_id_no ORDER BY s.first_name;

-- 4.Get all project names from the "ProjectDetail" table, even if they are not linked to any
-- employee, sorted by first name from the "employee table" and "ProjectDetail" table.
SELECT p.project_name, s.first_name
FROM project_details p
LEFT JOIN staff s ON p.staff_id_no = s.staff_id ORDER BY s.first_name;

-- 5.FIND the project names from the "ProjectDetail" table that have not been assigned to
-- any employee using the "employee table" and "ProjectDetail" table.
SELECT p.project_name, COUNT(s.first_name) AS assigned_to
FROM staff s
RIGHT JOIN project_details p ON s.staff_id = p.staff_id_no
GROUP BY project_name
HAVING COUNT(s.staff_id)<1;

-- 6.Get the employee name and project name for employees who are assigned to more than
-- one project.
SELECT p.project_name, COUNT(s.staff_id) AS staff_on_project
FROM staff s
RIGHT JOIN project_details p ON s.staff_id = p.staff_id_no
GROUP BY p.project_name
HAVING COUNT(s.staff_id)>=2;

-- 7Get the project name and the employee names of employees working on projects that
-- have more than one employee assigned.
SELECT p.project_name, s.first_name
FROM staff s
RIGHT JOIN project_details p ON s.staff_id = p.staff_id_no
WHERE p.project_name IN (
    SELECT project_name 
    FROM project_details 
    GROUP BY project_name 
    HAVING COUNT(staff_id_no) > 1
) ORDER BY p.project_name;

-- 8.Get records from the "ProjectDetail" table where the corresponding employee ID does
-- not exist in the "employee table."
SELECT p.*
FROM project_details p
LEFT JOIN staff s ON p.staff_id_no = s.staff_id
WHERE s.staff_id IS NULL;

##-----------Ranking Functions
-- 1.Get all project names from the "ProjectDetail" table, even if they are not linked to any
-- employee, sorted by first name from the "employee table" and "ProjectDetail" table.
SELECT p.project_name, s.first_name
FROM project_details p
LEFT JOIN staff s ON p.staff_id_no = s.staff_id ORDER BY s.first_name;

-- 2.FIND the project names from the "ProjectDetail" table that have not been assigned to
-- any employee using the "employee table" and "ProjectDetail" table.
SELECT p.project_name, COUNT(s.first_name) AS assigned_to
FROM staff s
RIGHT JOIN project_details p ON s.staff_id = p.staff_id_no
GROUP BY project_name
HAVING COUNT(s.staff_id)<1;

-- 3.Get the employee name and project name for employees who are assigned to more than
-- one project.
SELECT p.project_name, COUNT(s.staff_id) AS staff_on_project
FROM staff s
RIGHT JOIN project_details p ON s.staff_id = p.staff_id_no
GROUP BY p.project_name
HAVING COUNT(s.staff_id)>=2;

-- 7Get the project name and the employee names of employees working on projects that
-- have more than one employee assigned.
SELECT p.project_name, s.first_name
FROM staff s
RIGHT JOIN project_details p ON s.staff_id = p.staff_id_no
WHERE p.project_name IN (
    SELECT project_name 
    FROM project_details 
    GROUP BY project_name 
    HAVING COUNT(staff_id_no) > 1
) ORDER BY p.project_name;

-- 8.Get records from the "ProjectDetail" table where the corresponding employee ID does
-- not exist in the "employee table."
SELECT p.*
FROM project_details p
LEFT JOIN staff s ON p.staff_id_no = s.staff_id
WHERE s.staff_id IS NULL;

##---------------Partitioning Data
-- 1.Assign a row number to each employee within their department based on salary in
-- descending order.
SELECT *, ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rownum_in_dept FROM STAFF;

#2.Rank employees within each department based on salary using RANK().
SELECT *, RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_in_dept FROM STAFF;

#3.Rank employees within each department based on salary using DENSE_RANK().
SELECT *, DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank_in_dept FROM STAFF;

#4.Find the highest-paid employee in each department using RANK().
SELECT * FROM (
    SELECT *, RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk 
    FROM staff) x WHERE rnk=1;
    
-- 5.Find the second highest-paid employee in each department using RANK().
SELECT * FROM (
    SELECT *, RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk 
    FROM staff) x WHERE rnk=2;


-- 6.Rank employees based on their years of experience within each department
SELECT *, RANK() OVER (PARTITION BY department ORDER BY joining_date) AS exp_rank FROM STAFF;

#7.Find the employee with the earliest join date in each department using RANK()
SELECT * FROM (
    SELECT *, RANK() OVER (PARTITION BY department ORDER BY joining_date) AS rnk 
    FROM staff) x WHERE rnk=1;
    
##----------------Complex Ranking Scenarios
#1.Find the employees who earn more than the average salary of their department.
SELECT first_name, salary, department, avg_salary_dept
FROM (
    SELECT *, AVG(salary) OVER (PARTITION BY department) AS avg_salary_dept
    FROM staff
) y
WHERE salary >= avg_salary_dept;

#2.Rank employees within each job title in every department based on salary.
SELECT *, RANK() OVER (PARTITION BY department, job_title ORDER BY salary DESC) AS job_rank FROM STAFF;

#3.Find the top 3 highest-paid employees in each department
SELECT first_name, department, salary, rankk
FROM (
    SELECT *, RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rankk
    FROM staff
) x WHERE rankk BETWEEN 1 AND 3;

-- 4.Find employees who belong to the top 10% earners within their department using
-- PERCENT_RANK().
SELECT * FROM (
    SELECT staff_id, department, salary, PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS pct_rank
    FROM staff
)z WHERE pct_rank<=0.1;

-- 5.Assign row numbers to employees based on their joining year using PARTITION BY
-- YEAR(join_date)
SELECT *, ROW_NUMBER() OVER (PARTITION BY YEAR(joining_date) ORDER BY joining_date) AS row_in_year FROM STAFF;

#6.Rank employees based on the number of projects handled within each department
 SELECT 
    s.staff_id, s.department, COUNT(DISTINCT p.project_id) AS project_count,
    DENSE_RANK() OVER (PARTITION BY s.department ORDER BY COUNT(DISTINCT p.project_id) DESC) AS project_rank
FROM staff s
LEFT JOIN project_details p ON s.staff_id = p.staff_id_no
GROUP BY s.staff_id, s.department;   

-- 7.Find employees who are the only ones in their department (departments with only one
-- employee).
SELECT * FROM (
    SELECT*, COUNt(*) OVER (PARTITION BY department) AS dept_size
    FROM staff
) t WHERE dept_size=1; 

#8.Find the highest-paid employee in each job role within a department
SELECT * FROM (
    SELECT *, RANK() OVER (PARTITION BY department, job_title ORDER BY salary DESC) AS job_rank 
    FROM staff
) u WHERE job_rank=1;
    
#9.Find employees who have been working in the company the longest in each department.
 SELECT * FROM (
    SELECT *, RANK() OVER (PARTITION BY department ORDER BY joining_date) AS join_rank 
    FROM staff
) v WHERE join_rank=1;  
    
    
    
    
    
    
    
    
