--
--Query 19
--Find the sum of the salaries of all employees, the maximum salary, the
--minimum salary, and the average salary.
--
select sum(salary),max(salary),min(salary),avg(salary)
from   employee
--
--Query 20
--Find the sum of the salaries of all employees of the Research department,
--as well as the maximum salary, the minimum salary, and the average salary
--in this department.
select sum(salary),max(salary),min(salary),avg(salary)
from   employee, department
where  dno=dnumber and dname='Research';
--
--Query 21
--Retrieve the total number of employees in the company.
--
select count(*)
from   employee;
--
--Query 22
--Retrieve the total number of employees in the Research department.
-- 
select count(*)
from   employee,department
where  dno=dnumber and dname='Research';
--
--Query 23
--Count the number of distinct salary values in the database.
--
select count(distinct salary)
from   employee;
--
--Query 24
--For each department, retrieve the department number, the number of
--employees in the department, and their average salary
--
select dno,count(*),avg(salary)
from   employee
group by dno;
--
--Query 25
--For each project, retrieve the project number, the project name, and the
--number of employees who work on that project.
--
select pnumber,pname,count(*)
from   project,works_on
where  pnumber=pno
group by pnumber,pname;
--order by project number

--Query 26
--For each project on which more than two employees work, retrieve the project
--number, the project name, and the number of employees who work on the project.
--
select pnumber,pname,count(*)
from   project,works_on
where  pnumber=pno
group by pnumber,pname
having count(*)>2
ORDER BY pnumber Asc;;

--
--Query 27
--For each project, retrieve the project number, the project name,
--and the number of employees from department 5 who work on the project.
--
select pnumber,pname,count(*)
from   project,works_on,employee
where  pnumber=pno and ssn=essn and dno=5
group by pnumber,pname;
--
--Query 28
--For each department that has more than five employees, retrieve the
--department number and the number of its employees who are making more
--than $40,000.
--
select dnumber,count(*)
from   department,employee
where  dnumber=dno and salary>40000 and 
  dno in (select dno from employee group by dno having count(*)>5)
group by dnumber;
--
