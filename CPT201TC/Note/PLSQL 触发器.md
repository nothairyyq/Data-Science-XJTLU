# PL/SQL 触发器

触发器是存储的程序，在发生某些事件时会自动执行或触发；

触发器响应以下任何事件被执行：

- DML语句: `DELETE,INSERT,UPDATE`
- DDL语句：`CREATE,ALTER,DROP`
- `SERVERERROR,LOGON,LOGOFF,STARTUP,SHUTDOWN`

创建触发器的语法：

```plsql
CREATE [OR REPLACE] TRIGGER trigger_name
{BEFORE | AFTER | INSTEAD OF}
{INSERT[OR] | UPDATE[OR] | DELETE}
[OF col_name]
on table_name
[REFERENCING OLD AS o NEW AS n]
[FOR EACH ROW]
when(condition)
DECLARE
 	...
BEGIN
	...
EXCEPTION
	...
END;
```

### Type of triggers

- row-level trigger
- statement-level trigger

statement-level triggers fire once for the entire triggering statement

- The system doesn't care how many rows are effected by the DML event

row-level triggers fire once for each row within a trigger statement

- indicated by the `for each row`
- must consider the performance implications

### INSERT 触发器

- 在INSERT触发器内，引用名为:NEW的虚拟表 访问要插入的行
- 在BEFORE INSERT触发器中，更新:NEW中的值

```plsql
CREATE TABLE orders_log
(
    changed_on timestamp not null,
    change_type char(1) not null,
    order_num int not null
);
```

```plsQL
create or replace trigger orders_after_insert
after insert on orders
for each row
begin
	insert into orders_log(changed_on,change_type,order_num)
	VALUES(SYSDATE,'A',:NEW.order_num);
end;
```

![image-20211108143801202](C:\Users\86133\AppData\Roaming\Typora\typora-user-images\image-20211108143801202.png)

### When to use trigger events

- BEFORE Trigger Event

  -- 适用于创建日志

  --加强应用安全性

- AFTER Trigger Event

  --适用于logging journal