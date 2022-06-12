# Oracle 特殊函数

## Over(Partition by)

over分析函数用于计算基于组的某种聚合值，和聚合函数的不同之处在于对于每个组返回多行，而聚合函数每个组只返回一行

主要用于对某个字段值进行逐步累加，连续求和

over 不能单独使用，要和分析函数：rank(),dense_rank,row_number,sum()等一起使用

```plsql
SELECT EMP_ID, DEPT_ID,EXPERTISE,SALARY,  
  
SUM(SALARY) OVER (PARTITION BY DEPT_ID) AS DEPT_SALARY,  
  
SUM(SALARY) OVER (PARTITION BY EXPERTISE) AS EXPERTISE_SALARY,  
  
ROW_NUMBER() OVER (PARTITION BY DEPT_ID ORDER BY SALARY DESC ) AS ROW_NUM ,  
  
RANK() OVER (PARTITION BY DEPT_ID ORDER BY SALARY DESC ) AS RANK_NUM,  
  
DENSE_RANK() OVER (PARTITION BY DEPT_ID ORDER BY SALARY DESC ) AS D_RANK_NUM  
  
FROM AB_EMPLOYEE  
  
ORDER BY DEPT_ID,SALARY DESC;
```

row_number,dens_rank,rank这些都是根据over后面分组的字段排序

## RANK(), DENSE_RANK()

RANK（） 有排名并列名次的时候会产生不连续的排名编号，例如数据值 1,2,2,3 排名后发生的编号将是1,2,2,4；

DENSE_RANK() 有并列名次的时候会产生持续的排名编号，例如数据值 1,2,2,3 排名后发生的编号将是1,2,2,3；