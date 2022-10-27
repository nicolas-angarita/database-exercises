
/* 1. Find all the current employees with the same hire date as employee 101010 using a sub-query. */

SELECT hire_date
FROM employees
WHERE emp_no = 101010;

SELECT *
FROM employees
WHERE hire_date IN (SELECT hire_date
				FROM employees
				WHERE emp_no = 101010
				);

/* 2. Find all the titles ever held by all current employees with the first name Aamod.*/

SELECT emp_no
FROM salaries
JOIN employees
USING (emp_no)
WHERE first_name = 'Aamod' AND to_date > CURDATE();

SELECT title, COUNT(title) AS number_of_titles_held
FROM titles
WHERE emp_no IN (SELECT emp_no
				FROM salaries
					JOIN employees
					USING (emp_no) 
				WHERE first_name = 'Aamod' AND 
					to_date > CURDATE()
				)
GROUP BY title;				


/* 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. */

SELECT emp_no
FROM salaries
WHERE to_date > CURDATE();

SELECT COUNT(*) AS number_of_employees
FROM employees
WHERE emp_no NOT IN (
					SELECT emp_no
					FROM salaries
					WHERE to_date > CURDATE());
					
# returned 59900 are the employees no longer working for the company

/* 4. Find all the current department managers that are female. List their names in a comment in your code.*/

SELECT CONCAT(first_name, ' ', last_name)
FROM employees AS e
JOIN dept_manager AS dm
ON e.emp_no = dm.emp_no AND to_date > CURDATE() AND e.gender = 'F';

SELECT CONCAT(first_name, ' ', last_name)
FROM employees
WHERE emp_no IN (
   				SELECT emp_no 
    			FROM dept_manager
    			WHERE to_date > now()
				) AND gender = 'F';

# Isamu Legleitner, Karsten Sigstam, Leon DasSarma, and Hilary Kambil are the 4 current female department managers 


/* 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.*/


# Subquery 1 average salary is $63,811
SELECT ROUND(AVG(salary), 0)
FROM salaries;

# Subquery 2 returned 154543 rows
SELECT emp_no
FROM salaries
WHERE salary >= (
				SELECT ROUND(AVG(salary), 0)
   				FROM salaries
   				) AND to_date > now();

# Result - all the employees with a higher salary than the compaines average salary
SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
				SELECT emp_no
				FROM salaries
				WHERE salary >= (
								SELECT avg(salary)
   				 				FROM salaries
   				 				) AND to_date > now()
				);

/* 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

Hint You will likely use multiple subqueries in a variety of ways
Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries. */

SELECT ROUND(MAX(salary) - STD(salary), 2) AS 1_STDDEV
FROM salaries
WHERE to_date > CURDATE();

SELECT COUNT(salary) AS number_of_salaries
FROM salaries 
WHERE to_date > CURDATE()
AND salary > (	
			 SELECT MAX(salary) - STD(salary)
    		FROM salaries
    		WHERE to_date > CURDATE());
# returns 83 salaries

# to find the percentage of all salaries
SELECT (SELECT COUNT(salary)
FROM salaries 
WHERE to_date > CURDATE()
AND salary > (
			SELECT MAX(salary) - STD(salary)
    		FROM salaries
    		WHERE to_date > CURDATE()))
    /
			(SELECT count(salary)
    		FROM salaries 
    		WHERE to_date > now()
   			 ) 
* 100 AS percent_of_salaries;

# 0.0346% of salaries are 1 STD DEV of the current highest salary

SELECT COUNT(salary)
    		FROM salaries 
    		WHERE to_date > now();
    		
  SELECT (83 / 240124) * 100;  		

/* BONUS

Find all the department names that currently have female managers.*/

SELECT dept_name
FROM departments;

SELECT emp_no
FROM dept_manager;

SELECT dept_name, CONCAT(first_name, ' ', last_name)
FROM employees AS e
JOIN dept_manager AS dm
ON e.emp_no = dm.emp_no AND gender = 'F' AND to_date > CURDATE()
JOIN departments AS d
ON dm.dept_no = d.dept_no;

SELECT dept_name, CONCAT(first_name, ' ', last_name)
FROM employees AS e



/*Find the first and last name of the employee with the highest salary.*/



/*Find the department name that the employee with the highest salary works in. */





