let $d:=//companyDB/employees/employee[2]
return $d

(2*3)-(8*7)

concat("Hello"," World")

matches("Monday","^.*da.*$")

current-time()

let $list:=(1,5,10,12,15)
return count($list)


<item ino=”222”><iname>Nut</iname><price>22.50</price></item>

let $d:=companyDB/employees/employee[@worksFor=6]
return 
  <dept6Salary>{$d/salary}
  </dept6Salary>

FLWOR Queriesions
-----------------

Query 1: Get all projects.

let $d:=/companyDB/projects/project
for $p in $d
return $p

Query 2: Get distinct project numbers of projects in which employees work.

<projects>
{
let $d:=distinct-values(/companyDB/employees/employee/projects/worksOn/@pno)
for $p in $d
return 
<project>{$p}</project>
}
</projects>

using order by clause
---------------------

<projects>
{
let $d:=distinct-values(/companyDB/employees/employee/projects/worksOn/@pno)
for $p in $d
order by number($p)
return 
<project>{$p}
</project>
}
</projects>

Query 3: Get social security numbers of employees whose last name 
starts with "S".

let $d:=/companyDB/employees/employee
for $e in $d
where starts-with($e/lname,"S")
return <sssn>{$e/@ssn}</sssn>	

Query 4: Get last names and first names of employees in 
the "Research" department.

let $d:=doc("C:/XML/company.xml")
let $r:=$d/companyDB/departments/department[dname="Research"]
for $e in $d/companyDB/employees/employee
where $e/@worksFor=$r/@dno
return
<ResearchEmp>{$e/lname}{$e/fname}</ResearchEmp>

Query 5: Get employees who work more than 40 hours.

let $d:=companyDB/employees/employee
for $e in $d
where sum($e/projects/worksOn/@hours)>40.0
return
<OverWorkedEmp>{$e/lname}
{$e/fname}<TotalHours>{sum($e/projects/worksOn/@hours)}
</TotalHours>
</OverWorkedEmp>

Query 6: Get department names and the total number of employees 
working in the department.

let $d:=/companyDB/departments/department
for $r in $d
return
<deptNumEmps>{$r/dname}
<numEmps>{count(tokenize($r/employees/@essns,"\s+"))}
</numEmps>
</deptNumEmps>


Query 7: Get last names of employees with dependents.

let $d:=/companyDB/employees/employee[dependents]
for $e in $d
return $e/lname


Query 8: get last names of employees from Milwaukee along with their 
income group: “Low Income Group” (earning < 40000), “Middle Income Group” 
(earning between 40000 and 60000), and “High Income Group” (earning more 
than 80000).

<IncomeGroup>
{
let $d:=/companyDB/employees/employee[contains(address,"Milwaukee")]
for $e in $d
return
<emp>{$e/lname}
<income>
{if  ($e/salary >= 80000) then "High Income"
else if ($e/salary >=60000) then "Middle Income"
else "Low Income" 
}
</income>
</emp>
}
</IncomeGroup>


