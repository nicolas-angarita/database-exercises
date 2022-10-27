
# 1. Use the join_example_db. Select all the records from both the users and roles tables.
SELECT * FROM roles;
SELECT * FROM users;

/* 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results. */ 

SELECT *
FROM users
JOIN roles ON users.role_id=roles.id; 


SELECT *
FROM users
LEFT JOIN roles
ON users.role_id=roles.id;

SELECT *
FROM users
RIGHT JOIN roles
ON users.role_id=roles.id;


/* 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query. */

SELECT roles.name, COUNT(roles.id) AS total
FROM roles
JOIN users
ON users.role_id=roles.id
GROUP BY roles.name;



/* Employees Database*/

# 1. Use the employees database.

USE employees;


/* 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

  Department Name    | Department Manager
 --------------------+--------------------
  Customer Service   | Yuchang Weedman
  Development        | Leon DasSarma
  Finance            | Isamu Legleitner
  Human Resources    | Karsten Sigstam
  Marketing          | Vishwani Minakawa
  Production         | Oscar Ghazalie
  Quality Management | Dung Pesch
  Research           | Hilary Kambil
  Sales              | Hauke Zhang */

/*SELECT *
FROM employees;

SELECT *
FROM dept_manager;

SELECT * 
FROM departments;*/


SELECT dept_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
JOIN dept_manager
ON dept_manager.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date = '9999-01-01'
ORDER BY dept_name;
 


/*  3. Find the name of all departments currently managed by women.

Department Name | Manager Name
----------------+-----------------
Development     | Leon DasSarma
Finance         | Isamu Legleitner
Human Resources | Karsetn Sigstam
Research        | Hilary Kambil */


SELECT dept_name, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
JOIN dept_manager
ON dept_manager.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date = '9999-01-01'AND employees.gender = 'F'
ORDER BY dept_name;




/* 4. Find the current titles of employees currently working in the Customer Service department.


Title              | Count
-------------------+------
Assistant Engineer |    68
Engineer           |   627
Manager            |     1
Senior Engineer    |  1790
Senior Staff       | 11268
Staff              |  3574
Technique Leader   |   241 */

SELECT title, COUNT(dept_name) AS count
FROM employees
JOIN titles
ON titles.emp_no = employees.emp_no
JOIN dept_emp
ON dept_emp.emp_no = titles.emp_no
JOIN departments
ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date = '9999-01-01' AND titles.to_date = '9999-01-01' AND departments.dept_no = 'd009'
GROUP BY title
ORDER BY title;

/*SELECT * 
FROM employees;


SELECT *
FROM titles;

SELECT *
FROM dept_emp;

SELECT *
FROM departments; */


/* 5. Find the current salary of all current managers.


Department Name    | Name              | Salary
-------------------+-------------------+-------
Customer Service   | Yuchang Weedman   |  58745
Development        | Leon DasSarma     |  74510
Finance            | Isamu Legleitner  |  83457
Human Resources    | Karsten Sigstam   |  65400
Marketing          | Vishwani Minakawa | 106491
Production         | Oscar Ghazalie    |  56654
Quality Management | Dung Pesch        |  72876
Research           | Hilary Kambil     |  79393
Sales              | Hauke Zhang       | 101987 */

SELECT dept_name, CONCAT(first_name, ' ', last_name) AS full_name, salary 
FROM employees
JOIN dept_manager
ON dept_manager.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
JOIN salaries
ON salaries.emp_no = employees.emp_no
WHERE dept_manager.to_date = '9999-01-01'AND salaries.to_date = '9999-01-01'
ORDER BY dept_name;

/* SELECT *
FROM salaries; */


/* 6. Find the number of current employees in each department.


+---------+--------------------+---------------+
| dept_no | dept_name          | num_employees |
+---------+--------------------+---------------+
| d001    | Marketing          | 14842         |
| d002    | Finance            | 12437         |
| d003    | Human Resources    | 12898         |
| d004    | Production         | 53304         |
| d005    | Development        | 61386         |
| d006    | Quality Management | 14546         |
| d007    | Sales              | 37701         |
| d008    | Research           | 15441         |
| d009    | Customer Service   | 17569         |
+---------+--------------------+---------------+ */

SELECT departments.dept_no, dept_name, COUNT(emp_no) AS num_employees
FROM departments
JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date = '9999-01-01'
GROUP BY dept_name
ORDER BY dept_no;

/* SELECT *
FROM departments;

SELECT *
FROM dept_emp;*/


/* 7. Which department has the highest average salary? Hint: Use current not historic information.


+-----------+----------------+
| dept_name | average_salary |
+-----------+----------------+
| Sales     | 88852.9695     |
+-----------+----------------+ */

SELECT departments.dept_name, AVG(salary) AS average_salary
FROM departments
JOIN dept_emp
ON departments.dept_no = dept_emp.dept_no
JOIN salaries
ON dept_emp.emp_no = salaries.emp_no
WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;

/* SELECT *
FROM dept_emp;

SELECT *
FROM salaries; */


/* 8. Who is the highest paid employee in the Marketing department?


+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Akemi      | Warwick   |
+------------+-----------+ */

SELECT first_name, last_name 
FROM employees
JOIN salaries
USING (emp_no)
JOIN dept_emp
USING (emp_no)
JOIN departments
USING (dept_no)
WHERE departments.dept_name = 'Marketing'
ORDER By salary DESC
LIMIT 1;


/* 9. Which current department manager has the highest salary?

+------------+-----------+--------+-----------+
| first_name | last_name | salary | dept_name |
+------------+-----------+--------+-----------+
| Vishwani   | Minakawa  | 106491 | Marketing |
+------------+-----------+--------+-----------+ */

SELECT CONCAT(first_name, ' ', last_name) AS full_name, salary, dept_name  
FROM employees
JOIN dept_manager
ON dept_manager.emp_no = employees.emp_no
JOIN departments
ON departments.dept_no = dept_manager.dept_no
JOIN salaries
ON salaries.emp_no = employees.emp_no
WHERE dept_manager.to_date = '9999-01-01'AND salaries.to_date = '9999-01-01'
ORDER BY salary DESC
LIMIT 1;





/* 10. Determine the average salary for each department. Use all salary information and round your results.


+--------------------+----------------+
| dept_name          | average_salary | 
+--------------------+----------------+
| Sales              | 80668          | 
+--------------------+----------------+
| Marketing          | 71913          |
+--------------------+----------------+
| Finance            | 70489          |
+--------------------+----------------+
| Research           | 59665          |
+--------------------+----------------+
| Production         | 59605          |
+--------------------+----------------+
| Development        | 59479          |
+--------------------+----------------+
| Customer Service   | 58770          |
+--------------------+----------------+
| Quality Management | 57251          |
+--------------------+----------------+
| Human Resources    | 55575          |
+--------------------+----------------+ */

SELECT dept_name, ROUND(AVG(salary)) AS average_salary
FROM salaries
JOIN dept_emp
ON salaries.emp_no = dept_emp.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
GROUP BY dept_name
ORDER BY average_salary DESC;





/* 11. Bonus Find the names of all current employees, their department name, and their current manager's name.


240,124 Rows

Employee Name | Department Name  |  Manager Name
--------------|------------------|-----------------
 Huan Lortz   | Customer Service | Yuchang Weedman */
 
/* SELECT * 
FROM employees;

SELECT *
FROM departments;
 
SELECT *
FROM dept_manager;

SELECT *
FROM dept_emp; */
 
 
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS Employee, dept_name AS Department, CONCAT(e.first_name,' ' ,e.last_name) AS Manager 
FROM employees
JOIN dept_emp
USING (emp_no)
JOIN departments
USING (dept_no)
JOIN dept_manager
USING (dept_no)
JOIN employees AS e
ON e.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date = '9999-01-01' AND dept_emp.to_date = '9999-01-01'; 
 

 /* 12. Bonus Who is the highest paid employee within each department. */
 




