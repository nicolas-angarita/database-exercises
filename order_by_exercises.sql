USE employees;

/* 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?*/
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name;
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name DESC;
/* Irena Reutenauer is the name of the first row and Vidya Awdeh is the last person in the table*/


/* 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?*/
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name,last_name;
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY first_name DESC,last_name DESC;
/* Irena Acton is the name of the first row and Vidya Zweizig is the last person in the table*/


/* 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?*/
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name,first_name;
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') ORDER BY last_name DESC,first_name DESC;
/* Irena Acton is the name of the first row and Maya Zyda is the last person in the table*/


/* 5. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.*/
SELECT * FROM employees WHERE last_name LIKE 'E%E' ORDER BY emp_no;
SELECT * FROM employees WHERE last_name LIKE 'E%E' ORDER BY emp_no DESC;
/* 899 employees have a last name that starts and ends with 'E'. 10021 is the first employee # and his Ramzi Erde.*/
/* 499648 is the last employee # and her name is Tadahiro Erde.*/


/* 6. Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.*/
SELECT * FROM employees WHERE last_name LIKE 'E%E' ORDER BY hire_date DESC;
SELECT * FROM employees WHERE last_name LIKE 'E%E' ORDER BY hire_date;
/* 899 employees are returned and the newest employee name is Teiji Eldridge.*/
/* Sergi Erde is the oldest employee*/


/* 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.*/
SELECT * FROM employees WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND birth_date LIKE '%-12-25' ORDER BY birth_date,hire_date DESC;
SELECT * FROM employees WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND birth_date LIKE '%-12-25' ORDER BY birth_date DESC,hire_date;
/* 362 results were returned and Khun Bernini is the oldest and last employee hired.*/
/* Douadi Pettis is the youngest employee who was hired first*/



