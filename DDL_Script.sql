CREATE TABLE superstore(
	order_id VARCHAR(255),
	order_line VARCHAR(255),
	order_date DATE,
	ship_date DATE,
	ship_mode VARCHAR(50),
	order_priority VARCHAR(50),
	customer_id VARCHAR(20),
	customer_name VARCHAR(50),
	customer_email VARCHAR(255),
	gender CHAR(1),
	birth_date DATE,
	segment VARCHAR(255),
	country VARCHAR(100),
	city VARCHAR(255),
	state VARCHAR(255),
	postal_code INT,
	region VARCHAR(20),
	product_id VARCHAR(50),
	product_category VARCHAR(50),
	product_sub_category VARCHAR(100),
	sales FLOAT,
	quantity SMALLINT,
	discount NUMERIC(3,2),
	profit FLOAT	
);

CREATE TABLE departments(
	department_id INT NOT NULL PRIMARY KEY,
	department_name VARCHAR(100) NOT NULL UNIQUE,
	manager_id INT,
	location_id INT
);

SELECT * FROM departments;


CREATE TABLE employees(
	employee_id INT NOT NULL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(255) UNIQUE,
	phone_number VARCHAR(50) UNIQUE,
	hire_date DATE,
	job_id VARCHAR(20),
	salary INT,
	commission_pct FLOAT,
	manager_id INT,
	department_id INT REFERENCES departments(department_id)
	-- CONSTRAINT FK_employee_department FOREIGN KEY(department_id)
    -- REFERENCES departments(department_id)
);

SELECT * FROM employees;

--this is my sql script
/* my name is Edidiong
and i am big data consultant*/
SELECT* FROM employees
LIMIT 5;

select first_name,last_name,salary
from employees
order by salary desc;

--aggregate functions=max,min,sum,avg
--display the minimum salary
SELECT MIN(salary)AS minimum_salary FROM employees;

--Display the highest salary
SELECT MAX(salary)AS maximum_salary FROM employees;
--display the total salary of all employees
SELECT SUM(salary) AS total_salary FROM employees;

--display the average salary of all employees
SELECT ROUND(AVG(salary),2) AS average_salary FROM employees;

--issue a query to count the number of row in the employee table.the result shold be just one row
SELECT COUNT(*)AStotal_rows FROM employees;

--DISTINCT
--how many job_ids do we have
SELECT COUNT(DISTINCT job_id) job_id_count FROM employees;
--how many managers do we have on employees table
SELECT COUNT (DISTINCT manager_id)AS no_of_managers FROM employees;
--SET OPERATORS =UNION, UNIONALL, INTERSECT AND EXCEPT
/* Display all the departments that exist in the departments table that are not in the employers table.
do not use a where clause*/
SELECT department_id FROM departments;
SELECT DISTINCT department_id FROM employees
ORDER BY department_id ASC;

SELECT department_id FROM departments
EXCEPT
SELECT department_id FROM employees
ORDER BY 1;

/* Display all the departments that exist in the departments table that are also in the employers table.
do not use a where clause*/
SELECT department_id FROM departments
INTERSECT
SELECT department_id FROM employees
ORDER BY 1;

--WHERE CLAUSE allows us filter our table.allows you to activate a fxn to filter

SELECT * FROM employees;
--display the first_name and last_name of employee with employe_id 101
SELECT first_name,last_name,salary FROM employees
WHERE employee_id=101;

--issue a query to count the number of employee that make commission.the result should only be one row
SELECT * FROM departments;

SELECT first_name, last_name,commission_pct FROM employees
WHERE commission_pct IS NOT NULL;

select count(*) from employees
where commission_pct is not null;

--display the first_name, last_name, hire_date of all the employees in department 100
SELECT first_name, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id=100;

--SUBQUERRIES-query inside a query(a select inside a select)
---display all the employees that earn les than Peter Hall
SELECT first_name,last_name,salary FROM employees
WHERE salary is > 9000

SELECT salary FROM employees
WHERE first_name='Peter'AND last_name='Hall';

--display all the employees in the same department as Lisa Ozer
SELECT first_name,last_name,department_id from employees
WHERE department_id=(SELECT department_id from employees WHERE first_name='lisa' AND last_name='ozer');

--Display all the employees in the same department as Martha Sullivan and that make more than TJ Olson
SELECT first_name, last_name,department_id,salary FROM employees
WHERE department_id=(SELECT department_id FROM employees WHERE first_name='Martha' and last_name='Sullivan')
AND salary >(SELECT salary FROM employees WHERE first_name='TJ' and last_name='Olson');

--LOGICAL OPERATOR (AND, OR, NOT)
--Display the first_name,last_name,hire_date and jobid of all employees in department 10,20 and 30

SELECT first_name, last_name,department_id, hire_date,job_id FROM employees
WHERE department_id=10 or department_id=20 or department_id=30;

SELECT first_name, last_name,department_id, hire_date,job_id FROM employees
WHERE department_id IN (10,20,30);

SELECT first_name, last_name,department_id, hire_date,job_id FROM employees
WHERE department_id NOT IN (10,20,30);

--Display all the employees who were hired before Tayler Fox
SELECT first_name,last_name,hire_date FROM employees
WHERE hire_date<(SELECT hire_date FROM employees WHERE first_name='Tayler' and last_name='Fox');

--Display all the employees and their salaries that make more than Abel
SELECT first_name,last_name,salary FROM employees
WHERE salary>(SELECT salary FROM employees WHERE first_name='Abel'OR last_name='Abel');

--LIKE,ILIKE,NOT LIKE
--Wildcards %_
--Display names of all employees and their jobid ,whose first name starts with L
SELECT first_name,last_name,job_id FROM employees
WHERE first_name LIKE '%e';
--write a query that displays the employee phone number and last names of ll employees that their last name contains u
SELECT first_name, last_name,phone_number FROM employees
WHERE last_name LIKE '%u%';

--GROUP BY & HAVING CLAUSE
SELECT * FROM employees;
SELECT DISTINCT job_id FROM employees;
--display the sum of salary of all employees in each department
SELECT department_id,SUM(salary)FROM employees
GROUP BY department_id
ORDER BY 2 DESC;
--find the job id with the highest average salary
SELECT job_id, ROUND(avg(salary),2) average_salary FROM employees
GROUP BY job_id
ORDER BY 2 DESC
LIMIT 1;

SELECT job_id,department_id, AVG(salary) FROM employees
GROUP BY job_id,department_id
ORDER BY 3 DESC;

--say i want to display the department id that has sum salary of more than 50000
SELECT department_id, SUM(salary) FROM employees
GROUP BY department_id
HAVING SUM (salary)>50000
ORDER BY 2 DESC;

/*issue a query to display the job title and total monthly salary for each job that has atotal salary exceeding $13,000.Exclude any job title that looks like rep and sort the result by total monthly salary*/
SELECT job_id,SUM(salary) total_salary FROM employees
GROUP BY  job_id
HAVING SUM (salary)>13000
AND job_id NOT LIKE'%rep%'
ORDER BY total_salary DESC;
--write a query to display the number of people each job 
SELECT job_id, COUNT(*) no_of_emp FROM employees
GROUP BY job_id
ORDER BY no_of_emp DESC;

--CASE WHEN & BETWEEN
/* write a query to display the salary level of each employee such that from 2000-4000 is low salary 
from 5000-10500 is medium salary and others are high salary*/
SELECT first_name,last_name,salary,
        CASE
		WHEN salary BETWEEN 2000 AND 4000 THEN'low salary'
		WHEN salary BETWEEN 5000 AND 10500 THEN'medium salary'
		ELSE 'high salary'
		END AS salary_level
FROM employees;

/*write a query to display how old an employee has been working since 2001-2003 is old employee
2004-2006 are intermediate while the rest are new employees.*/
SELECT *FROM employees;
SELECT first_name, last_name,hire_date,
       CASE
	   WHEN DATE_PART('YEAR',hire_date) BETWEEN 2001 TO 2003 THEN 'old employees'
	   WHEN DATE_PART('YEAR',hire_date) BETWEEN 2004 TO 2006 THEN 'intermediate'
	   ELSE 'new employee'
FROM employees;


--DATE FUNCTIONS (EXTRACT,DATE_PART,TO_CHAR)
SELECT hire_date, EXTRACT('YEAR'FROM hire_date)year_hired
EXTRACT ('MONTH' FROM hire_date) month_hired, TO_CHAR(hire_date.'Month'),
TO_CHAR(hire_date,'Day')
FROM employees;

SELECT hire_date, DATE_PART('YEAR'FROM hire_date)year_hired
EXTRACT ('MONTH' FROM hire_date) month_hired, TO_CHAR(hire_date.'Month'),
TO_CHAR(hire_date,'Day')
FROM employees;
--STRING FUNCTIONS
--UPPER
--LOWER
--COALESCE
--SUBSTRING
--REPLACE

--JOINS (COMBINING MULTIPLE TABLES TOGETHER) (EXPLICIT AND IMPLICIT)
--INNER JOINS
---OUTER JOINS(LEFT OUTER,RIGHT OUTER,FULL OUTER)
--CROSS JOIN
--ANTI JOIN
--SEMI JOIN
--SELF JOIN
--VIEWS
--CTE
--WINDOWS FUNCTIONS
