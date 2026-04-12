-- =========================================
-- EMPLOYEE PERFORMANCE ANALYSIS
-- =========================================

-- 1. Average salary by department
SELECT 
    d.department_name,
    AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;


-- 2. Employee count per department
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS total_employees
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;


-- 3. Top 10 highest paid employees
SELECT TOP 10
    employee_id,
    name,
    salary
FROM employees
ORDER BY salary DESC;


-- 4. Salary ranking (Window Function)
SELECT 
    employee_id,
    name,
    department_id,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;


-- 5. Employees above average salary
WITH avg_salary AS (
    SELECT AVG(salary) AS avg_salary FROM employees
)
SELECT 
    e.employee_id,
    e.name,
    e.salary
FROM employees e
CROSS JOIN avg_salary a
WHERE e.salary > a.avg_salary;


-- 6. Tenure analysis
SELECT 
    employee_id,
    name,
    hire_date,
    DATEDIFF(YEAR, hire_date, GETDATE()) AS years_of_service
FROM employees;