USE employees;

SHOW DATABASES;

-- Type of Departments, employee salaries, names, and titles of positions

/* Which table(s) do you think contain a numeric type column? I think the salaries table contains a numeric type column to be able to provide the $ value of the salary. */

/* Which table(s) do you think contain a string type column? I think the departments table contains a string type of column to provide the different departments that are in the company*/

/*Which table(s) do you think contain a date type column? I think there are multiple tables that contain a dat type of column, like in the employeees table. Showing the date the employee was hired*/

/* What is the relationship between the employees and the departments tables? I don't see a relationship between the two tables*/

SHOW CREATE TABLE dept_manager;

/* dept_manager	CREATE TABLE `dept_manager` (↵  `emp_no` int NOT NULL,↵  `dept_no` char(4) NOT NULL,↵  `from_date` date NOT NULL,↵  `to_date` date NOT NULL,↵  PRIMARY KEY (`emp_no`,`dept_no`),↵  KEY `dept_no` (`dept_no`),↵  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,↵  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT↵) ENGINE=InnoDB DEFAULT CHARSET=latin1*/
