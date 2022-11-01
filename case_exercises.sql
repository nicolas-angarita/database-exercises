

/* 1. Write a query that returns all employees, their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.*/

SELECT *,
    IF(to_date = '9999_01_01', True, False) AS is_current_employee
FROM dept_emp;


/* 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.*/

SELECT last_name,
    CASE
        WHEN last_name BETWEEN 'A%' AND 'I%' THEN 'A-H'
        WHEN last_name BETWEEN 'I%' AND 'R%' THEN 'I-Q'
       ELSE 'R-Z' 
    END AS alpha_group
FROM employees
ORDER BY last_name ASC;


/* 3. How many employees (current or previous) were born in each decade? */

SELECT birth_date
FROM employees
ORDER BY birth_date DESC;



SELECT  COUNT(*) AS total,
  CASE
	WHEN birth_date BETWEEN '1950-01-01' AND '1959-12-31' THEN "50's"
	WHEN birth_date BETWEEN '1960-01-01' AND '1969-12-31' THEN "60's"
  END AS decade	
FROM employees
GROUP BY decade;



/* 4. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service? */

SELECT ROUND(AVG(salary), 2) AS avg_salary,
  CASE
       WHEN dept_name IN ('Research', 'Development') THEN 'R&D'
       WHEN dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
       WHEN dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
       WHEN dept_name IN ('Finance', 'Human Resources') THEN 'Finance & HR'
       ELSE dept_name
   END AS dept_group
FROM departments AS d
JOIN dept_emp USING(dept_no)
JOIN salaries AS s USING (emp_no)
WHERE s.to_date > CURDATE()
GROUP BY dept_group
ORDER BY avg_salary DESC;

