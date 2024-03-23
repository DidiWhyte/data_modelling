-- This is my SQL script
/* My name is Jaykay
And i am a Big Data Consultant */
SELECT * FROM employees;
SELECT * FROM departments;

SELECT * FROM employees
LIMIT 5;

SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

--AGGREGATE FUNCTIONS (MAX,MIN,AVG,SUM,COUNT)
-- Display the minimum salary. 
SELECT MIN(salary) AS minimum_salary FROM employees;

-- Display the highest salary.
SELECT MAX(salary) AS max_salary FROM employees;

-- Display the total salary of all employees.
SELECT SUM(salary) AS total_salary FROM employees;

-- Display the average salary of all employees.
SELECT ROUND(AVG(salary),2) AS avg_salary FROM employees;

-- Issue a query to count the number of row in the employee table. The result should be just one row.
SELECT COUNT(*) AS total_rows FROM employees;

--DISTINCT
-- How many job_id do we have
SELECT DISTINCT job_id FROM employees;
SELECT COUNT(DISTINCT job_id) job_id_count FROM employees;

--How many managers do we have in the employees table
SELECT COUNT(DISTINCT manager_id) no_of_managers FROM employees;

--SET OPERATORS (UNION, UNION ALL, INTERSECT, EXCEPT)
/* Display all the departments that exist in the departments table that are not in the employees table. 
Do not use a where clause */
SELECT department_id FROM departments
EXCEPT
SELECT department_id FROM employees
ORDER BY department_id;

/* Display all the departments that exist in department tables that are also in the employees table.
Do not use a where clause */
SELECT department_id FROM departments
INTERSECT
SELECT department_id FROM employees
ORDER BY department_id;

-- WHERE CLAUSE
SELECT * FROM employees;

SELECT first_name, last_name, salary FROM employees
WHERE employee_id = 101;

-- Issue a query to count the number of employees that make commission. The result should be just one row.
SELECT first_name, last_name, commission_pct FROM employees
WHERE commission_pct IS NOT NULL;

SELECT COUNT(*) FROM employees
WHERE commission_pct IS NOT NULL;

-- Display first name, last name hire date and salary of all employee in department 100
SELECT first_name, last_name, department_id, hire_date, salary
FROM employees
WHERE department_id = 100;

--SUBQUERIES (PARENT CHILD QUERIES)
-- Display all employees that make less than Peter Hall.
SELECT first_name, last_name, salary FROM employees
WHERE salary < (SELECT salary FROM employees WHERE first_name = 'Peter' AND last_name = 'Hall');

-- Display all the employees in the same department as Lisa Ozer.
SELECT first_name, last_name, department_id FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE first_name = 'Lisa' AND last_name='Ozer');

-- Display all the employees in the same department as Martha Sullivan and that make more than TJ Olson.
SELECT first_name, last_name, department_id, salary FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE first_name = 'Martha' AND last_name ='Sullivan')
AND salary > (SELECT salary FROM employees WHERE  first_name = 'TJ' AND last_name = 'Olson');

--LOGICAL OPERATOR (AND, OR, NOT)
-- Display the first_name, last name, hire_date and jobid of all employees in departments 10, 20 and 30.
SELECT first_name, last_name, hire_date, job_id FROM employees
WHERE department_id = 10 OR department_id = 20 OR department_id = 30;

SELECT first_name, last_name, department_id, hire_date, job_id FROM employees
WHERE department_id IN (10, 20, 30);

SELECT first_name, last_name, department_id, hire_date, job_id FROM employees
WHERE department_id NOT IN (10, 20, 30);

-- Display all the employees who were hired before Tayler Fox
SELECT first_name, last_name, hire_date FROM employees
WHERE hire_date < (SELECT hire_date FROM employees WHERE first_name = 'Tayler' AND last_name = 'Fox' );

-- Display all the employees and their salaries that make more than Abel.
SELECT first_name, last_name, salary FROM employees
WHERE salary > (SELECT salary FROM employees WHERE first_name = 'Abel' OR last_name = 'Abel');

--LIKE ILIKE NOT LIKE
-- WildCards - %, _

--Display the names and job id of all employees that the first name starts with L
SELECT first_name, last_name, job_id FROM employees
WHERE first_name LIKE 'L%';

-- Write a query that displays the employee phone number and last names of all employees that their last name contains u
SELECT first_name, last_name, phone_number FROM employees
WHERE last_name ILIKE '%u%';

-- GROUP BY & HAVING CLAUSE
-- Display the sum of salary of all employees in each department.
SELECT department_id, SUM(salary) FROM employees
GROUP BY department_id
ORDER BY 2 DESC;

-- Find the job_id with the highest average salary
SELECT job_id, ROUND(AVG(salary),2) average_salary FROM employees
GROUP BY job_id 
ORDER BY average_salary DESC
LIMIT 1;

SELECT job_id, department_id, AVG(salary) FROM employees
GROUP BY job_id, department_id
ORDER BY 3 DESC;

-- Say i want to display only the department id that has sum salary of more than 50000
SELECT department_id, SUM(salary) FROM employees
GROUP BY department_id
HAVING SUM(salary) > 50000
ORDER BY 2 DESC;

/*Issue a query to display the job title and total monthly salary for each job that has a total salary exceeding $13,000. 
Exclude any job title that looks like rep and sort the result by total monthly salary */
SELECT job_id, SUM(salary) total_salary FROM employees
GROUP BY job_id
HAVING SUM(salary) > 13000
AND job_id NOT LIKE '%rep%'
ORDER BY total_salary DESC;

-- Write a query to display the number of people in each job id.
SELECT job_id, COUNT(*) no_of_emp FROM employees
GROUP BY job_id
ORDER BY no_of_emp DESC;

-- CASE WHEN & BETWEEN
/* Write a query to display the salary level of each employee such that from 2000-4800 is Low salary
From 5000-10500 is medium salary and others are high salary */
SELECT first_name, last_name, salary,
		CASE
		WHEN salary BETWEEN 2000 AND 4800 THEN 'Low Salary'
		WHEN salary BETWEEN 5000 AND 10500 THEN 'Medium Salary'
		ELSE 'High Salary'
		END AS salary_level
FROM employees;

/* Write a query to display how old an employee has been working where 2001-2003 is Old Employee
2004-2006 are Intermediate while the rest are new employees. */
SELECT * FROM employees;
SELECT first_name, last_name, hire_date,
		CASE
		WHEN DATE_PART('YEAR',hire_date) BETWEEN 2001 AND 2003 THEN 'Old Employee'
		WHEN DATE_PART('YEAR',hire_date) BETWEEN 2004 AND 2006 THEN 'Intermediate'
		ELSE 'New Employee'
		END AS emp_hire
FROM employees;

-- DATE FUNCTIONS (EXTRACT, DATE_PART, TO_CHAR)
SELECT hire_date, EXTRACT('YEAR' FROM hire_date) year_hired,
EXTRACT('MONTH' FROM hire_date) month_hired, TO_CHAR(hire_date, 'Month'),
TO_CHAR(hire_date, 'Day')
FROM employees;

SELECT hire_date, DATE_PART('YEAR', hire_date) year_hired,
DATE_PART('MONTH', hire_date) month_hired, TO_CHAR(hire_date, 'Month'),
TO_CHAR(hire_date, 'Day')
FROM employees;

-- STRING FUNCTIONS
--UPPER
--LOWER
--COALESCE
--SUBSTRING
--REPLACE

-- JOINS (EXPLICIT & IMPLICIT)
--INNER JOIN
--OUTER JOIN(LEFT OUTER, RIGHT OUTER,FULL OUTER)
--CROSS JOIN
--ANTI JOIN
--SEMI JOIN
--SELF JOIN
SELECT * FROM employees;
SELECT * FROM departments;
-- Display the first name and salary of all the employees in the Accounting departments. 
SELECT e.first_name, e.salary, e.department_id, d.department_name FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
WHERE d.department_name = 'Accounting';

--Implicit
SELECT e.first_name, e.salary, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND d.department_name = 'Accounting';

-- Display the phone number of all the employees in the Marketing department.
SELECT e.first_name, e.last_name, e.phone_number, d.department_id, d.department_name FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Marketing';

-- Display all the employees in the Shipping and Marketing departments who make more than 3100.
SELECT e.first_name, e.last_name, d.department_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name IN ('Shipping', 'Marketing')
AND e.salary > 3100;

--Issue a query to display all department name whose average salary is greater than $8000 
SELECT d.department_name, ROUND(AVG(e.salary),2) FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name 
HAVING AVG(e.salary) > 8000;

--Issue a query to display the department id, department_name, of departments 20 and 50
SELECT d.department_id, d.department_name FROM departments d
JOIN employees e ON d.department_id = e.department_id
WHERE d.department_id IN (20,50);

--Assignment
-- Issue a query to display all departments whose average salary is greater than 8000 
-- Issue a query to display all departments whose maximum salary is greater than 10000
-- Display the salary of last name, job id and salary of all employees whose salary is equal to the minimum salary.
-- Issue a query to display all employees who make more than Timothy Gates and less than Harrison Bloom
-- Issue a query to display the full name, 10 digit phone number, salary, department name of all employees
/* Issue a query to display all employees who are in Lindsey Smith or Joshua Patel department, 
who make more than Ismael Sciarra and were hired in 1997 and 1998. */

-- VIEWS
CREATE VIEW v_salary_level AS
(SELECT first_name, last_name, salary,
		CASE
		WHEN salary BETWEEN 2000 AND 4800 THEN 'Low Salary'
		WHEN salary BETWEEN 5000 AND 10500 THEN 'Medium Salary'
		ELSE 'High Salary'
		END AS salary_level
FROM employees);

SELECT * FROM v_salary_level;


-- CTE
-- WINDOWS FUNCTION












