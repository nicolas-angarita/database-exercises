USE employees;

/* 2. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.*/
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');
/* There are a total of 709 employees with the names 'Irena', 'Vidya', or 'Maya'*/


/* 3. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2? */
SELECT * FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';
/* There are the same amount of employees (709) as in Q2. */


/* 4. Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned. */
SELECT * FROM employees WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya') AND gender = 'M';
/* The amount of records returned are 441. */


/* 5. Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E. */
SELECT * FROM employees WHERE last_name LIKE 'E%';
/*7330 employees have a last name that starts wtih 'E'.*/


/* 6. Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?*/
SELECT * FROM employees WHERE last_name LIKE 'E%' OR last_name LIKE '%E';
SELECT * FROM employees WHERE last_name LIKE '%E' AND last_name NOT LIKE 'E%';
/* 30723 have either last name starting or ending with 'E'. 
23393 have a last name that ends with 'E', but does not start with 'E'.*/


/* 7. Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?*/
SELECT * FROM employees WHERE last_name LIKE 'E%E';
SELECT * FROM employees WHERE last_name LIKE '%E';
/* 899 employees have a last name that starts and ends with 'E'. 
24292 employees last names end with an 'E' regardless if they start with an 'E'*/


/* 8. Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.*/
SELECT * FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
/* 135214 employees were hired in the 1990's*/


/* 9. Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.*/
SELECT * FROM employees WHERE birth_date LIKE '%-12-25';
/* 842 employees were born on Christmas*/


/* 10. Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned*/
SELECT * FROM employees WHERE (hire_date BETWEEN '1990-01-01' AND '1999-12-31') AND birth_date LIKE '%-12-25';
/* 362 employees were born on Christmas and hired in the 90's*/


/* 11. Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.*/
SELECT * FROM employees WHERE last_name LIKE '%q%';
/* 1873 employees have a 'q' in their last name*/


/* 12. Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?*/
SELECT * FROM employees WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
/* 547 employees have a 'q' in their last name and don't inlcude a 'qu'.*/


