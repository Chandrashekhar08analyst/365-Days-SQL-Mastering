/* 
📝 Problem Scenario:

🎯 Imagine you're a Data Analyst at Oracle, and the Oracle team has assigned you a task to perform a 
salary analysis. The goal is to gain insights into each employee's earnings compared to 
their manager's salary as well as the average department salary (excluding managers). 
This analysis will help Oracle's HR and Management teams understand compensation structures and 
hierarchy dynamics.

🔍 Your Task:
You have access to the employee_o table, which contains details on each employee's department,
ID, salary, and manager's ID. Here’s what the Oracle team needs:

🔻 Compare each employee’s salary with:
Their manager’s salary.
The average salary of their department (excluding the manager’s salary).

🔻 Display the following details for each employee:
Department, Employee ID, Employee's Salary, Manager's Salary
Department's Average Salary (excluding the manager's salary)                                                */

-- Sample Schema and Dataset:
CREATE TABLE employee_o (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    employee_title VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    manager_id INT
);

INSERT INTO employee_o (id, first_name, last_name, age, gender, employee_title, department, salary, manager_id) VALUES
(1, 'Alice', 'Smith', 45, 'F', 'Manager', 'HR', 9000, 1),
(2, 'Bob', 'Johnson', 34, 'M', 'Assistant', 'HR', 4500, 1),
(3, 'Charlie', 'Williams', 28, 'M', 'Coordinator', 'HR', 4800, 1),
(4, 'Diana', 'Brown', 32, 'F', 'Manager', 'IT', 12000, 4),
(5, 'Eve', 'Jones', 27, 'F', 'Analyst', 'IT', 7000, 4),
(6, 'Frank', 'Garcia', 29, 'M', 'Developer', 'IT', 7500, 4),
(7, 'Grace', 'Miller', 30, 'F', 'Manager', 'Finance', 10000, 7),
(8, 'Hank', 'Davis', 26, 'M', 'Analyst', 'Finance', 6200, 7),
(9, 'Ivy', 'Martinez', 31, 'F', 'Clerk', 'Finance', 5900, 7),
(10, 'John', 'Lopez', 36, 'M', 'Manager', 'Marketing', 11000, 10),
(11, 'Kim', 'Gonzales', 29, 'F', 'Specialist', 'Marketing', 6800, 10),
(12, 'Leo', 'Wilson', 27, 'M', 'Coordinator', 'Marketing', 6600, 10);

-- Query Solution:

WITH DepartmentAvgSalary AS (
	SELECT Department , 
	ROUND(AVG(CASE WHEN id!= manager_id THEN salary END), 0) AS Department_AvgSalary
	FROM employee_o
	GROUP BY Department
),
ManagerSalary AS (
	SELECT e.id AS employeeid,
	e.department,
	e.salary AS employee_salary,
	m.salary AS manager_salary
	FROM employee_o AS e
	LEFT JOIN employee_o AS m
	ON e.manager_id = m.id AND e.id != m.manager_id
)
SELECT e.department, e.id AS employeeid,
e.salary AS employee_salary, m.manager_salary,
d.department_avgsalary
FROM employee_o AS e
JOIN ManagerSalary AS m 
ON e.id = m.employeeid
JOIN DepartmentAvgSalary AS d
ON e.department = d.department
ORDER BY department, e.salary DESC;
