10. Find Names of All Employees
--Create a SQL query that finds the full name of all employees whose salary is exactly 25000, 14000, 12500 or 23600. 
--The result should be displayed in a column, named "Full Name",
-- which is a combination of the first, middle and last names, separated by a single space. 
SELECT  CONCAT_WS(' ',FirstName,MiddleName,LastName) AS [Full Name]
FROM Employees
WHERE Salary IN (25000, 14000, 12500 ,23600)