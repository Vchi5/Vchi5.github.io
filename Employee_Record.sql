SELECT *
FROM [dbo].['Employee Info$']

SELECT *
FROM [dbo].['Employee position$']


--QUESTIONS 1

--(1) Write a query to fetch the EmpFname from the EmployeeInfo table in the upper case and use the ALIAS name as EmpName

SELECT UPPER(EmpFname) AS EmpName
FROM [dbo].['Employee Info$']

--(2) Write a query to fetch the number of employees working in the department ‘HR’

SELECT COUNT(*) 
FROM [dbo].['Employee Info$']
WHERE Department = 'HR'

--(3) Write a query to get the current date
 SELECT GETDATE()

--(4) Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table

SELECT SUBSTRING(EmpLname, 1, 4) AS EmpLnamePrefix
FROM [dbo].['Employee Info$']

--(5) Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.

SELECT SUBSTRING(Address, 1, CHARINDEX('(', Address) - 1) AS PlaceName
FROM [dbo].['Employee Info$']

--(6) Write a query to create a new table that consists of data and structure copied from the other table

SELECT *
INTO EmployeeInfoBackup
FROM [dbo].['Employee Info$']

-- then if you want to create a new table and filter it to get only requred column
SELECT *
INTO EmployeeInfoBackup
FROM [dbo].['Employee Info$']
where Gender = 'M'

--(7) Write q query to find all the employees whose salary is between 50000 to 100000
SELECT*
FROM [dbo].['Employee position$']
WHERE Salary BETWEEN 50000 AND 100000

--(8) Write a query to find the names of employees that begin with ‘S’
SELECT EmpFname, EmpLname
FROM [dbo].['Employee Info$']
WHERE  EmpFname LIKE 'S%' OR EmpLname LIKE 'S%'

--(9) Write a query to fetch top N records
SELECT TOP (3)* 
FROM [dbo].['Employee position$']
ORDER BY [Salary] DESC

--(1O)Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and the last name must be separated with space
--IT CAN BE DONE IN TWO WAYS. 
SELECT CONCAT(EmpFname,' ', EmpLname) AS FullName
FROM [dbo].['Employee Info$']

SELECT EmpFname + ' ' + EmpLname AS FullName
FROM [dbo].['Employee Info$']


--QUESTIONS 2

--(1) Write a query to find number of employees whose DOB is between 02/05/1970 to 31/12/1995 and are grouped according to gender

--THIS ANSWERS THE QUESTION BY FINDING THE NUMBERS
SELECT Gender, COUNT(*) AS NumberOfEmployees
FROM [dbo].['Employee Info$']
WHERE DOB BETWEEN '1970-05-02' AND '1995-12-31'
GROUP BY Gender

--BUT THIS DISPLAYS THERE NAMES 
select DOB,
       GENDER
FROM [dbo].['Employee Info$']
WHERE [DOB] BETWEEN '1970-05-02' AND '1995-12-31' 
GROUP BY GENDER, DOB

--(2) Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order and Department in the ascending order
SELECT *
FROM [dbo].['Employee Info$']
ORDER BY [EmpFname] DESC, [Department] ASC

--(3) Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets
SELECT*
FROM [dbo].['Employee Info$']
WHERE EmpLname LIKE '_____A'

--(4) Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” from the EmployeeInfo table
SELECT*
FROM [dbo].['Employee Info$']
WHERE[EmpFname] NOT IN ('Sanjay','Sonia')

--(5) Write a query to fetch details of employees with the address as “DELHI(DEL)”
SELECT*
FROM [dbo].['Employee Info$']
WHERE[Address] = 'DELHI(DEL)'

--(6) Write a query to fetch all employees who also hold the managerial position.
SELECT* 
FROM[dbo].['Employee position$']
WHERE[EmpPosition] = 'MANAGER'

--(7) Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order
SELECT COUNT(Department) 
From [dbo].['Employee Info$']
order by [Department] ASC 

SELECT Department
    ,COUNT(*) AS EmployeeCount
FROM [dbo].['Employee Info$']
GROUP BY Department
ORDER BY EmployeeCount ASC

--(8) Write a query to fecth Male employees in HR department
SELECT *
FROM [dbo].['Employee Info$']
WHERE[Gender] = 'M' AND [Department] = 'HR'

--(9) Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table

SELECT*
FROM [dbo].['Employee Info$']
INNER JOIN [dbo].['Employee position$']
    ON [dbo].['Employee Info$'].EmpId =[dbo].['Employee position$'].EmpId
WHERE[dbo].['Employee position$'] .DateOfJoining IS NOT NULL


--(10) Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table

WITH SALARY_NEW as(
SELECT 
      [Salary]
      ,RANK() OVER(ORDER BY[Salary]ASC) AS SALARY_ASCENDING
	  ,RANK() OVER(ORDER BY[Salary]DESC) AS SALARY_DESCENDING
	  FROM[dbo].['Employee position$']
)
SELECT [Salary]
FROM[SALARY_NEW]
WHERE SALARY_ASCENDING <=2 OR  SALARY_DESCENDING <=2
