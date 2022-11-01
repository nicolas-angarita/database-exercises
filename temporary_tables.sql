USE noether_2038;

/* 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read. */

DROP TABLE IF EXISTS noether_2038.employees_with_departments;

CREATE TEMPORARY TABLE noether_2038.employees_with_departments AS(
SELECT first_name, last_name, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no)
);



/* 1a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns*/
DESCRIBE employees;

ALTER TABLE noether_2038.employees_with_departments ADD full_name VARCHAR(31);



/* 1b. Update the table so that full name column contains the correct data */
SELECT *
FROM noether_2038.employees_with_departments;

UPDATE noether_2038.employees_with_departments SET full_name = CONCAT(first_name, ' ',last_name);

/* 1c. Remove the first_name and last_name columns from the table. */

SELECT * 
FROM noether_2038.employees_with_departments
LIMIT 10;

ALTER TABLE noether_2038.employees_with_departments DROP COLUMN first_name;
ALTER TABLE noether_2038.employees_with_departments DROP COLUMN last_name;

/* 1d. What is another way you could have ended up with this same table? */

# We could have done a concat function in the 1st query.


/* 2. Create a temporary table based on the payment table from the sakila database. */
DROP TABLE IF EXISTS noether_2038.payment;


CREATE TEMPORARY TABLE noether_2038.payment AS (
SELECT *
FROM payment);


/* Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199. */

SELECT *
FROM noether_2038.payment;

DESCRIBE payment;

ALTER TABLE noether_2038.payment MODIFY amount decimal(7,2);

UPDATE noether_2038.payment SET amount = amount * 100;

ALTER TABLE noether_2038.payment MODIFY amount int; 

/* 3. Find out how the current average pay in each department compares to the overall current pay for everyone at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst? */

DROP TABLE IF EXISTS noether_2038.avg_salary_per_department;


CREATE TEMPORARY TABLE noether_2038.overall_agg AS (
SELECT AVG(salary) AS avg_salary, STD(salary) AS std_salary
FROM employees.salaries
WHERE to_date > CURDATE()
);

SELECT *
FROM noether_2038.overall_agg;

CREATE TEMPORARY TABLE noether_2038.metrics AS (
SELECT dept_name, AVG(salary) AS dept_average
FROM employees.salaries
JOIN employees.dept_emp USING (emp_no)
JOIN employees. departments USING (dept_no)
WHERE employees.dept_emp.to_date > CURDATE()
AND employees.salaries.to_date > CURDATE()
GROUP BY dept_name
);

SELECT *
FROM noether_2038.metrics;

ALTER TABLE noether_2038.metrics ADD overall_avg  FLOAT (10,2),
								 ADD overall_std FLOAT (10,2),
								 ADD dept_zscore FLOAT (10,2);

SELECT *
FROM noether_2038.metrics;

UPDATE noether_2038.metrics SET overall_avg = (SELECT avg_salary FROM noether_2038.overall_agg);

SELECT *
FROM noether_2038.metrics;

UPDATE noether_2038.metrics SET overall_std = (SELECT std_salary FROM noether_2038.overall_agg);

SELECT *
FROM noether_2038.metrics;


UPDATE noether_2038.metrics SET dept_zscore = (dept_average - overall_avg) / overall_std;

SELECT *
FROM noether_2038.metrics
ORDER BY dept_zscore DESC;

-- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;


/* BONUS To your work with current salary zscores, determine the overall historic average departement average salary, the historic overall average, and the historic zscores for salary. Do the zscores for current department average salaries tell a similar or a different story than the historic department salary zscores?*/



