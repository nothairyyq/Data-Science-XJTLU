**Employee Salary Check Example**

This example will only allow an employee salary to exceed $70,000 if he/she is a manager.

This condition cannot be implemented with a simple declarative constraint.

Application logic could perform this test before the update is ever processed.

```plsql
CREATE OR REPLACE TRIGGER EMPLOYEE_SALARY_CHECK
  BEFORE INSERT OR UPDATE OF salary ON employee
  FOR EACH ROW
  WHEN (new.salary > 70000)
DECLARE

  --Declare variables
  x_mgrssn      department.mgrssn%TYPE;
  message_text  VARCHAR2(100);
  
BEGIN

  --Execute query to determine whether the ssn refers to a manager
	SELECT MGRSSN
	INTO X_MGRSSN
  
	FROM department
	WHERE mgrssn = :new.ssn;

EXCEPTION
	WHEN NO_DATA_FOUND THEN
    --Set the message text
    message_text := 'Must be manager for salary of ' || TO_CHAR(:NEW.SALARY);
    
    --Raise application error to cancel operation
		RAISE_APPLICATION_ERROR(-20001, message_text);
    
END;
```

```plsql
--Attempt to update Smith
--This should fail because Smith is not a manager
UPDATE employee
SET salary = 71000
WHERE lname = 'Smith';

--Attempt to update Borg
--This should succeed because Borg is a manager
UPDATE employee
SET salary = 71000
WHERE lname = 'Borg';

/*SELECT * from employee
where lname='Borg';*/
```

#### Exercise2

**Create a row level trigger after Insert or Update to record an entry in budget for any employee whose salary is greater than $70,00** 

**Create a row level trigger AFTER INSERT OR UPDATE to request additional money for a department budget when a raise is given or new employee is hired. **

在INSERT或UPDATE之后创建行级触发器，以便在加薪或雇用新员工时请求部门预算的额外资金。

This AFTER INSERT OR UPDATE Row-Level Trigger will record an audit entry of any employee whose salary has been raised above $70,000.

Requires a new table to hold the journal entries

It will use the OLD and NEW Column values

```plsql
CREATE TABLE audit_entry (
  entry_date  DATE,
  entry_user  VARCHAR2(30),
  entry_text  VARCHAR2(2000),
  old_value   VARCHAR2(2000),
  new_value   VARCHAR2(2000));
```

```plsql
CREATE OR REPLACE TRIGGER employee_journal
  AFTER INSERT OR UPDATE OF salary ON employee
  FOR EACH ROW
  WHEN (new.salary > 70000)
  
BEGIN

  --Insert the new row into the audit_entry table
  INSERT INTO audit_entry 
    (entry_date, entry_user, entry_text, old_value, new_value)
  VALUES
    (SYSDATE, USER, 'Salary > 70000 for ' || :NEW.ssn, 
     :OLD.salary,
     :NEW.salary);
    
END;
```

```plsql
--Update the employee Borg
UPDATE employee
SET salary = 75000
WHERE lname = 'Borg';

--See if the record was added to the audit table
SELECT * FROM audit_entry;
```

#### Exercise3

**Create a row level trigger AFTER INSERT OR UPDATE to request additional money for a department budget when a raise is given or new employee is hired. **

