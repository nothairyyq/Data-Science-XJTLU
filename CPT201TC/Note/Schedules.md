### Schedules

### Serial Schedule

 A serial schedule is one in which transactions are executed one after the other,in some sequential order

每个事务的操作都是连续执行的，没有任何来自其他事务的交替操作。

在串行调度中，全部事务都以穿行顺序执行

如果按顺序执行就不会出错，但是我们需要更好的性能，就不会只有这样做。

在串行调度中，同一时刻只有一个事务处于活动状态，当前事务的提交（或撤销）将会启动下一个事务的执行

串行S中，如果T在等待完成某个I/O操作时，CPU处理器无法切换到另外一个T，这样就会浪费宝贵的CPU时间



Serial Schedule is slower but guarantees consistency(correctness)

我们需要找这样的调度：

- as fast as interleaved schedules
- as consistent as serial schedules

### Serializable Schedule

**Focus on conflicting operations**

- A schedule is conflict serializable if it can be transformed into a serial schedule by a series of swapping of adjacent non- conflicting actions 
-  When the schedule is conflict-equivalent to some (any!) serial schedule is called Conflict Serializability. 
-  The schedules S1 and S2 are said to be conflict-equivalent if the following conditions are satisfied: 
  -  Both schedules S1 and S2 involve the same set of transactions (including ordering of actions within each transaction). 
  -  The order of each pair of conflicting actions in S1 and S2 are the same.

![image-20211117163504835](C:\Users\86133\AppData\Roaming\Typora\typora-user-images\image-20211117163504835.png)

### Testing for conflict-serializability

