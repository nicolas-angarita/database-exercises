USE employees;

# 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file. */

SELECT DISTINCT title FROM titles;
# 7 unique titles have existed  


# 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT last_name FROM employees WHERE last_name LIKE 'E%e' GROUP BY last_name;


# 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT CONCAT(first_name, " ", last_name) AS full_name FROM employees WHERE last_name LIKE 'E%e' GROUP BY full_name;


# 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT last_name FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_name;
# Chleq, Lindqvist, and Qiwen are the 3 unique last names.


# 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT last_name, COUNT(last_name) FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%' GROUP BY last_name;
# Chleq = 189, Lindqvist = 190, Qiwen = 168; same number of employees with the same last name.


# 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, gender, COUNT(*) AS count FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') GROUP BY first_name, gender;


# 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4),'_', SUBSTR(birth_date,6,2), SUBSTR(birth_date,3,2))) AS username, COUNT(*) AS n_same_username
FROM employees
GROUP BY username
HAVING n_same_username > 1;
# Yes there are duplicate usernames; There are 13,251 duplicate usernames.


/* 9. Bonus: More practice with aggregate functions: 
- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
- Determine how many different salaries each employee has had. This includes both historic and current.
- Find the maximum salary for each employee.
- Find the minimum salary for each employee.
- Find the standard deviation of salaries for each employee.
- Now find the max salary for each employee where that max salary is greater than $150,000.
- Find the average salary for each employee where that average salary is between $80k and $90k.*/


# Average for each employee 
SELECT emp_no, ROUND(AVG(salary),2) AS average
FROM salaries
GROUP BY emp_no;

# Different salaries each employee has had
SELECT emp_no, COUNT(salary) AS salary_change
FROM salaries
GROUP BY emp_no;

# Number of employees in each department
SELECT dept_no, COUNT(emp_no) 
FROM dept_emp
GROUP BY dept_no;

# Max salary for each employee
SELECT emp_no,MAX(salary) AS max
FROM salaries
GROUP BY emp_no;

# MIN salary for each employee
SELECT emp_no, MIN(salary) AS min
FROM salaries
GROUP BY emp_no;

# Standard Deviation for each employee
SELECT emp_no, STD(salary) AS Std
FROM salaries
GROUP BY emp_no;

# Max salary for each employee making over $150,000
SELECT emp_no, MAX(salary) AS max
FROM salaries
GROUP BY emp_no
HAVING MAX > 150000;

# Average salary of an employee making between $80,000 and $90,000
SELECT emp_no, ROUND(AVG(salary),2) AS average
FROM salaries
WHERE salary BETWEEN 80000 AND 90000
GROUP BY emp_no;




