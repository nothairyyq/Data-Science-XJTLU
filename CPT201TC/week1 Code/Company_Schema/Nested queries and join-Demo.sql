--Query 1
--Retrieve the name and address of all employees who work for the Research
--department.
--
select fname,lname,address, dname
from   employee,department
where  dnumber=dno and
       dname='Research';
       
--Same query can be wriiten using nested query

SELECT Fname, Lname, Address
FROM Employee
WHERE Dno IN (SELECT Dnumber
FROM Department
WHERE dname='Research')

--Retrieve project no of ‘smith’ where he worked as manager or worker

SELECT DISTINCT Pnumber
FROM PROJECT
WHERE Pnumber IN
		( SELECT Pnumber
		FROM PROJECT, DEPARTMENT, EMPLOYEE
		WHERE Dnum=Dnumber AND mgrssn=Ssn AND Lname='Smith' )
		OR Pnumber IN
( SELECT Pno
FROM WORKS_ON, EMPLOYEE
WHERE Essn=Ssn AND Lname='Smith');

--Retrieve Essn of all employee who work in same (Project,Hour) combination on some project that employee whose ssn= ‘12345678

SELECT DISTINCT Essn
FROM WORKS_ON
WHERE (Pno, Hours) IN ( SELECT Pno, Hours
FROM WORKS_ON
WHERE Essn='123456789');

--Returns the names of employees whose salary is greater than the salary of all the employees in department 5:

SELECT Lname, Fname
FROM EMPLOYEE
WHERE Salary > ALL ( SELECT Salary
 FROM EMPLOYEE
 WHERE Dno = 5 )

--Joined Tables in SQL and Outer Joins

select fname,lname,address, dname
from   employee,department
where  dnumber=dno and
       dname='Research';

--with Join
SELECT Fname, Lname, Address
FROM (EMPLOYEE JOIN DEPARTMENT ON Dno = Dnumber)
WHERE Dname = 'Research';

--same if use Inner JOIN

SELECT Fname, Lname, Address
FROM (EMPLOYEE INNER JOIN DEPARTMENT ON Dno=Dnumber)
WHERE Dname='Research';

--Natural Join

SELECT Fname, Lname, Address
FROM (EMPLOYEE NATURAL JOIN DEPARTMENT)
WHERE Dname = 'Research';

--Outer join motivation
--only employees who have a supervisor are included in the result; 
 SELECT E.Lname Employee_name, S.Lname Supervisor_name
FROM EMPLOYEE E, EMPLOYEE S
WHERE E.Superssn = S.Ssn;
-- same query with Join
SELECT E.Lname Employee_name, S.Lname Supervisor_name
FROM EMPLOYEE E INNER JOIN EMPLOYEE S on E.Superssn = S.Ssn;


SELECT E.Lname Employee_name,
 S.Lname Supervisor_name
FROM (EMPLOYEE E LEFT OUTER JOIN EMPLOYEE S
 ON E.Superssn = S.Ssn);

--right outer Join
SELECT E.Lname Employee_name,
 S.Lname Supervisor_name
FROM (EMPLOYEE E RIGHT OUTER JOIN EMPLOYEE S
 ON E.Superssn = S.Ssn);
 
 
 -- full join
 SELECT E.Lname Employee_name,
 S.Lname Supervisor_name
FROM (EMPLOYEE E FULL OUTER JOIN EMPLOYEE S
 ON E.Superssn = S.Ssn);

select * 
FROM (EMPLOYEE left outer JOIN DEPARTMENT ON Dno=Dnumber)


