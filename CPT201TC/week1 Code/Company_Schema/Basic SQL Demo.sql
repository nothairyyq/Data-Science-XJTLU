--Query 0
--Retrieve the birthdate and address of the employee(s) whose name is
--John B. Smith
--
select bdate,address
from   employee
where  fname='John' and minit='B' and lname='Smith';
--
--Query 1
--Retrieve the name and address of all employees who work for the Research
--department.
--
select fname,lname,address
from   employee,department
where  dnumber=dno and
       dname='Research';
--
--Query 2
--For every project located in Stafford, list the project number, the
--controlling department number, and the department manager's last name,
--address, and birthdate.
--
select pnumber,dnum,lname,address,bdate
from   project,department,employee
where  dnum=dnumber and mgrssn=ssn and plocation='Stafford';

--Query 3: Retrieve the salary of every employee and all distinct salary value

SELECT ALL Salary
FROM EMPLOYEE;

-- Distinct Salary
SELECT DISTINCT Salary
FROM EMPLOYEE;

--LIKE comparison operator
--Retrieve all employees whose address is in Houston, Texas.
SELECT Fname, Lname, Address
FROM EMPLOYEE
WHERE Address LIKE '%Houston%';

--Substring Pattern Matching
SELECT Fname, Lname
FROM EMPLOYEE
WHERE Fname LIKE '_a%';

--BETWEEN Operator
SELECT *
FROM EMPLOYEE
WHERE (Salary BETWEEN 30000 AND 40000) AND Dno = 5;

--IN Operator

SELECT *
FROM EMPLOYEE
WHERE Salary IN  (30000 ,40000) ;

--Retrieve the social security numbers of all employees who work on project
--numbers 1, 2, or 3.
--
select distinct essn
from   works_on
where  pno in (1,2,3);

-- order BY clause
--Retrieve a list of employees and the projects they are working on, ordered
--by department and, within each department, ordered alphabetically by last
--name, first name

SELECT D.Dname, E.Lname, E.Fname, P.Pname
FROM DEPARTMENT D, EMPLOYEE E, WORKS_ON W,
PROJECT P
WHERE D.Dnumber= E.Dno AND E.Ssn= W.Essn AND
W.Pno= P.Pnumber
ORDER BY D.Dname Asc, E.Lname, E.Fname;