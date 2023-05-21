-- create EmployeeDetails table
CREATE TABLE EmployeeDetails (
  EmpId INT NOT NULL PRIMARY KEY,
  FullName VARCHAR(255) NOT NULL,
  ManagerId INT,
  DateOfJoining DATE,
  City VARCHAR(255)
);


-- Insert values into EmployeeDetails
INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, DateOfJoining, City)
VALUES
    (1, 'viru', NULL, '2022-01-01', 'kochi'),
    (2, 'surya kumar', 1, '2021-02-15', 'hyderabad'),
    (3, 'dhoni', 1, '2020-08-24', 'bangalore'),
    (4, 'jonhcena' , 1, '2022-02-29', 'delhi');



 -- create EmployeeDetails table      
    CREATE TABLE EmployeeSalary (
  EmpId INT NOT NULL,
  Project VARCHAR(255) NOT NULL,
  Salary DECIMAL(10, 2) NOT NULL,
  Variable DECIMAL(10, 2),
  PRIMARY KEY (EmpId, Project),
  FOREIGN KEY (EmpId) REFERENCES EmployeeDetails(EmpId)
);



-- Insert values into EmployeeSalary
INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable)
VALUES
    (1, 'Project A', 6000.00, 1500.00),
    (2, 'Project B', 7000.00, 2500.00),
    (3, 'Project C', 8000.00, 3500.00),
    (4, 'Project D', 9000.00, 4000.00),
    (3, 'Project C', 10000.00, 3000.00);
    
--1. SQL Query to fetch records that are present in one table but not in another table.

SELECT EmployeeDetails.*
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId
WHERE EmployeeSalary.EmpId IS NULL;



--2. SQL query to fetch all the employees who are not working on any project.

SELECT *
FROM EmployeeDetails
WHERE EmpId NOT IN (SELECT EmpId FROM EmployeeSalary WHERE Project IS NOT NULL)


--3. SQL query to fetch all the Employees from EmployeeDetails who joined in the Year 2020.

SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020


--4. Fetch all employees from EmployeeDetails who have a salary record in EmployeeSalary.

SELECT *
FROM EmployeeDetails
WHERE EmpId IN (SELECT EmpId FROM EmployeeSalary)


--5. Write an SQL query to fetch a project-wise count of employees.

SELECT Project, COUNT(*) AS EmployeeCount
FROM EmployeeSalary
GROUP BY Project


--6. Fetch employee names and salaries even if the salary value is not present for the employee.

SELECT EmployeeDetails.FullName, EmployeeSalary.Salary
FROM EmployeeDetails
LEFT JOIN EmployeeSalary ON EmployeeDetails.EmpId = EmployeeSalary.EmpId


--7. Write an SQL query to fetch all the Employees who are also managers.

SELECT e1.*
FROM EmployeeDetails e1
INNER JOIN EmployeeDetails e2 ON e1.EmpId = e2.ManagerId


--8. Write an SQL query to fetch duplicate records from EmployeeDetails.

SELECT EmpId, FullName, COUNT(*) AS DuplicateCount
FROM EmployeeDetails
GROUP BY EmpId, FullName
HAVING COUNT(*) > 1


--9. Write an SQL query to fetch only odd rows from the table.

SELECT *
FROM (
  SELECT *, ROW_NUMBER() OVER (ORDER BY EmpId) AS RowNum
  FROM EmployeeDetails
) AS T
WHERE T.RowNum % 2 = 1


--10. Write a query to find the 3rd highest salary from a table without top or limit keyword.

SELECT DISTINCT Salary
FROM EmployeeSalary e1
WHERE 3 = (
  SELECT COUNT(DISTINCT Salary)
  FROM EmployeeSalary e2
  WHERE e2.Salary > e1.Salary
);