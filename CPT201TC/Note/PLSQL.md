# PL/SQL

[TOC]



### Ⅰ. 变量

一个变量是程序中可以操纵的存储区域的名称

PL/SQL中的每个变量都有一个指定的数据类型，决定变量内存的大小和布局

#### 1. 变量声明

在声明部分声明`PL/SQL`变量当作全局变量。当声明一个变量时，`PL/SQL`为变量的值分配内存，并且存储位置由变量名称标识。

```plsql
variable_name [constant] datatype [NOT NULL] [:= | DEFAULT initial_value];
```

`datatype`必须是有效的PL/SQL数据类型或者任何用户定义的数据类型

```plsql
x_salary employee.salary %type;
pi constant double precision := 3.1415;
name varchar2(25);
```

如果使用`not null`必须为变量显式分配初始值



#### 2. 变量作用域

PL/SQL允许块的嵌套，每个程序块可以包含另一个内部块。

如果在一个内部块中声明了一个变量，外部块不可以访问内部变量。

- 局部变量，在内部块中声明的变量，外部块不可访问；
- 全局变量，在最外部块中生命的变量



#### 3. 将SQL查询结果分配给PL/SQL变量

`SELECT INTO`语句；对于`SELECT`列表中的每个项目，`INTO`列表中必须有一个对应的类型兼容变量。

```plsql
DECLARE
    E_SSN EMPLOYEE.SSN %TYPE := 888665555;
    E_FNAME EMPLOYEE.FNAME %TYPE;
    E_ADDRESS EMPLOYEE.ADDRESS %TYPE;
    E_SAL EMPLOYEE.SALARY %TYPE;
BEGIN
    SELECT fname,address,salary
    into e_fname,e_address,e_sal
    from employee
    where ssn=e_ssn;
    dbms_output.put_line('employee' || e_fname || 'from' || e_address ||'earns' || e_sal);
END;
```

### Ⅱ. 存储过程

#### 1.创建存储过程

```plsql
CREATE [OR REPLACE] PROCEDURE procedure_name
[(parameter_name [IN|OUT|IN OUT] TYPE [,...] )]
{IS | AS}
BEIGN
	...
END procedure_name;
```

- procedure_name: 要创建的存储过程的名字
- [OR REPLACE]： 选项允许修改现有的进程
- 可选参数列表包含参数的名称，模式和类型。 IN表示将从外部传递的值，OUT表示将用于返回过程外的值的参数

```plsql
PROCEDURE GREETINGS 
AS 
begin 
    dbms_output.put_line('hello world'); 
end;
```

#### 2. 执行独立程序

- 使用`EXECUTE`关键字
- 在`PL/SQL`块中调用过程的名称

```plsql
EXECUTE greetings;
```

```plsql
BEGIN
	greetings;
END;
/
```

#### 3.删除独立存储过程

```plsql
DROP PROCEDURE procedure_name;
```

#### 4. 子程序中的参数模式

1. IN
2. OUT
3. IN OUT

![image-20211107154559443](C:\Users\86133\AppData\Roaming\Typora\typora-user-images\image-20211107154559443.png)

```plsql
create or replace procedure greeting is
h number;
g char(20);

begin
    select extract(hour from current_timestamp)
    into h from dual;
    
    if h>=20 or h<=5 then 
    g:='goodnight';
    elsif h>5 and h<=12 then
    g:='goodmorning';
    elsif h>12 and h<=17 then
    g:='goodafternoon';
    else 
    g:='good evening';
    end if;
    
    dbms_output.put_line(g);
end;
```

### Ⅲ. 游标

Oracle创建一个称为上下文区域的内存区域，用于处理SQL语句，包含处理该语句所需的所有信息；例如，处理的行数等。

游标是指向此上下文区域的指针，`PLSQL`通过游标控制上下文区域，游标保存sql语句返回的行（一个或多个），游标所在的行集称为活动集

#### 常用属性

![image-20211108105430833](C:\Users\86133\AppData\Roaming\Typora\typora-user-images\image-20211108105430833.png)

任何SQL游标属性将被访问为`sql%attribute_name`

#### 隐式游标

```plsql
SET SERVEROUTPUT ON SIZE 99999;
DECLARE  
   total_rows number(2); 
BEGIN 
   UPDATE customers 
   SET salary = salary + 500; 
   IF sql%notfound THEN 
      dbms_output.put_line('没有找到客户信息~'); 
   ELSIF sql%found THEN 
      total_rows := sql%rowcount;
      dbms_output.put_line('一共有：' || total_rows || ' 个客户的工资被更新！ '); 
   END IF;  
END; 
/
```




### Ⅲ. Record

记录可以容纳不同种类的数据项的数据结构。记录由不同的字段组成，类似于数据库的一行。

- 基于表的记录
- 基于游标的记录
- 用户定义的记录

#### 1. 基于表的记录

`rowtype`属性能够创建基于表和基于游标的记录

```plsql
SET SERVEROUTPUT ON SIZE 99999;
DECLARE 
   customer_rec customers%rowtype; 
BEGIN 
   SELECT * into customer_rec 
   FROM customers 
   WHERE id = 5;  
   dbms_output.put_line('客户ID: ' || customer_rec.id); 
   dbms_output.put_line('客户姓名: ' || customer_rec.name); 
   dbms_output.put_line('客户地址: ' || customer_rec.address); 
   dbms_output.put_line('客户薪资: ' || customer_rec.salary); 
END; 
/
```

#### 2.用户定义的记录

```plsql
TYPE
type_name IS RECORD
( field_name1  datatype1  [NOT NULL]  [:= DEFAULT EXPRESSION], 
   field_name2   datatype2   [NOT NULL]  [:= DEFAULT EXPRESSION], 
   ... 
   field_nameN  datatypeN  [NOT NULL]  [:= DEFAULT EXPRESSION); 
record-name  type_name;
```

```plsql
declare
    TYPE EmpRecord
    IS RECORD(SSN employee.ssn%type,
              lname employee.lname%type,
              dname department.dname%type,
              bounspayment number(6));
    
    InactiveEmp EmpRecord;          

begin
    select essn,lname,dname,0 
    into InactiveEmp
    from employee e 
    inner join department d on e.dno=d.dnumber
    inner join works_on w on e.ssn=w.essn
    where hours = (select MIN(hours) from works_on)
    and rownum<=1;

    update employee
    set superssn=null
    where superssn=inactiveemp.ssn;
    
    update department
    set mgrssn=null
    where mgrssn=inactiveemp.ssn;
    
    delete from dependent
    where essn=inactiveemp.ssn;
    
    delete from works_on
    where essn=inactiveemp.ssn;
    
    delete from employee
    where ssn=inactiveemp.ssn;
    
    dbms_output.put_line('Least active employee has been transferred: ' ||
                       InactiveEmp.LName);
end;
```

