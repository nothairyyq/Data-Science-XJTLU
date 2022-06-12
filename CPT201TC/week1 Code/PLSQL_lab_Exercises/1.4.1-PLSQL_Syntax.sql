DECLARE

BEGIN
  FOR I IN 1..1000 LOOP
  
  	--Insert data into the employee table
  	INSERT INTO employee (ssn, fname, lname, dno, salary)
  	VALUES (900000000 + I, 'John', 'Doe', 1, 30000 + I);
  	
  END LOOP;
  
  --Commit changes
  commit;
  
EXCEPTION
  --Output when no records are returned
  WHEN OTHERS THEN
    ROLLBACK;
		
END;