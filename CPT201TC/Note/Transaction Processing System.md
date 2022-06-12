## Transaction Processing System

- Concurrent DB access
- Resilience to system failures

事务是一个构成数据库处理逻辑单元的可执行程序。

一个事务包括一个或多个数据库访问操作（insert,delete,modefy,query）

A transaction is a sequence of one or more SQL operations treated as a unit

- if the system fails, each transaction's changes are reflected either entirely or not at all

如果某个事务设计的数据库操作仅仅对数据进行检索，而不更新数据库，被称为read-only transaction

### Concurrent Access:

- Attribute-level Inconsistency
- Tuple-level Inconsistency
- Table-level Inconsistency
- Multi-statement inconsistency

### Concurrency Problems

- The Lost update Problem

  当访问相同数据库项的两个事务操作，以某种方式交替执行，从而导致数据库项的值不正确时，就会放生lost update problem

- The temporary update(Dirty Read)Problem

  事务更新了某个数据库项，由于某种原因事务故障，然而所更新的项在恢复到原值之前，另一个事务便读取该项

- Incorrect Summary problem

  如果一个transaction在若干record上计算一个聚集求和函数，另一些transaction正在更新期中的某些record，聚集函数可能计算了一些更新前的值，和一些更新后的值

### Concurrency Goal

Execute sequence of SQL statements so they appear to be running in isolation

But want to enable concurrency whenever safe to do so



### Transaction Properties

ACID:

- Atomicity
  - 每个transaction都不会半途而废
- Consistency
  - A transaction must see a consistent  database. During transaction execution the  database may be temporarily  inconsistent. When the transaction completes  successfully the database must be  consistent
- Isolation
  - 事务的执行表现为与其他事务相隔离，即事务的执行不应受到其他并发事务的干扰

- Durability
  - 如果system crashes在事务提交之后，事务的所有影响都保留在数据库中

Serializability(可串行化)：操作可以interleaved，但是执行必须以一种顺序执行所有的事务

### Isolation

隔离性是由DBMS并发控制的子系统实现的，如果每个事务的更新在其提交之前，对其他事务都是不可见的，实现了一种隔离性，由此可以解决临时更新和消除级联回滚问题

### Three read phenomena

The SQL standard defines three read phenomena; issues that can occur when many people read and write to the same rows:

1. Dirty Reads
2. Non-repeatable(fuzzy) Read
3. Phantom Read

#### Dirty Reads

A dirty read is when you see uncommitted rows in another transaction. There is no guarantee the other transaction will commit. So when these are possible, you could return data that was never saved to the database!

Dirty reads are impossible in Oracle Database. You can only view uncommitted rows in your own transaction.

#### Fuzzy Read

当一个数据库事务重新读取他已经读过的数据，然后发现另一个提交的事务修改或删除了相同的数据时，就会发生fuzzy read

A non-repeatable read is when selecting the same row twice returns different results. This happens when someone else updates the row between queries. 

![image-20211117105321519](C:\Users\86133\AppData\Roaming\Typora\typora-user-images\image-20211117105321519.png)

#### Phantom Read

当 Oracle 中的事务重新执行查询，该查询返回满足特定搜索的行并发现另一个提交的事务已经插入了满足条件的其他行时，就会发生幻读。

![image-20211117105336583](C:\Users\86133\AppData\Roaming\Typora\typora-user-images\image-20211117105336583.png)



---



### Weaker "Isolation Levels"

- Read Uncommitted
- Read Committed
- Repeatable Read

![image-20211117105614401](C:\Users\86133\AppData\Roaming\Typora\typora-user-images\image-20211117105614401.png)

#### Read Uncommitted

由于您不能在 Oracle 数据库中进行脏读，因此此隔离级别不相关且未实施。

Read Uncommitted may perform "dirty reads"

```sql
---T1
Update Student 
set gpa=1.1*gpa
where sizeHS>2500

---T2
Set Transaction Isolation Level Read Uncommitted;
select Avg(gap) from Student
```

The update command in T1 can update the values in either order, and the select  command in T2 can compute the average at any point before, between, or after the  updates



#### Read committed

not possible perform dirty reads; still does not guarantee global serializability.

This is the default mode for Oracle Database. Using read committed, you have statement-level consistency

#### Repeatable Read

The intent of repeatable read in the SQL standard is to provide consistent results from a query. But Oracle Database already has this in read committed! So it has no use for this level and doesn't implement it.

If you're using a database without MVCC you may need this mode to get correct results.

None of the three read phenomena are possible using serializable. You use this in Oracle Database to get transaction-level consistency. You can only view changes committed in the database at the time your transaction starts. Any changes made by other transactions after this are hidden from your transaction.



## 
