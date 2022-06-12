

/**************************************************************
  Full star join
--Grouping and aggregation on sales table
**************************************************************/

Select CUSTID, STOREID, SUM(SALESDOLLAR)
from SSSALES
group by CUSTID, STOREID;

--using cube operator

Select CUSTID, STOREID, SUM(SALESDOLLAR)
from SSSALES
group by CUBE (CUSTID, STOREID)
order by CUSTID, STOREID;

--using rollup

Select CUSTID, STOREID, SUM(SALESDOLLAR)
from SSSALES
group by ROLLUP (CUSTID, STOREID)
order by CUSTID, STOREID;

--Drill down--no special operator, just can add additional attribute to get more detail

Select CUSTID, STOREID, ITEMID, SUM(SALESDOLLAR)
from SSSALES
group by CUSTID, STOREID, ITEMID;



/**************************************************************
  "Slice"
  Total sales by store, item, and customer for CO stores only
**************************************************************/

Select F.STOREID, ITEMID, CUSTID, SUM(SALESDOLLAR)
from SSSALES F, SSSTORE S
WHERE F.STOREID=S.STOREID and STORESTATE='CO'
group by F.STOREID,ITEMID,CUSTID;

/**************************************************************
  "Dice"
  Total sales by store, item, and customer for CO stores
    and Printing category only
**************************************************************/

select F.STOREID, I.ITEMID, CUSTID, sum(SALESDOLLAR)
from SSSALES F, SSSTORE S, SSITEM I
where F.STOREID = S.STOREID and F.ITEMID = I.ITEMID
and STORESTATE = 'CO' and ITEMCATEGORY = 'Printing'
group by F.STOREID, I.ITEMID, CUSTID;


/************************************/

-- More complex query.
-- Summarize sum of store sales for USA and Canada in 2016 by store zip and month
-- Only include groups with more than one row

SELECT StoreZip, TimeMonth, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear = 2016
 GROUP BY StoreZip, TimeMonth
 HAVING COUNT(*) > 1
 ORDER BY StoreZip, TimeMonth;

-- Example 1 using CUBE.
SELECT StoreZip, TimeMonth, 
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2016
 GROUP BY CUBE (StoreZip, TimeMonth)
 ORDER BY StoreZip, TimeMonth;

-- Example 2.
-- Summarize sales for USA and Canada in 2016 by store zipcode, month, and division
SELECT StoreZip, TimeMonth, DivId,
       SUM(SalesDollar) AS SumSales, MIN(SalesDollar) AS MinSales,
       COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
    OR StoreNation = 'Canada') 
   AND TimeYear = 2016
 GROUP BY CUBE (StoreZip, TimeMonth, DivId)
 ORDER BY StoreZip, TimeMonth, DivId;

--Roll Up

--Summarize (SUM, COUNT, and MIN) store sales for USA and Canada between 2016 and 2017 by year and month
--Generate partial subtotals for year and month


 SELECT TimeYear, TimeMonth, SUM(SalesDollar) AS SumSales,
       MIN(SalesDollar) AS MinSales, COUNT(*) AS RowCount
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' OR StoreNation = 'Canada') 
   AND TimeYear BETWEEN 2016 AND 2017
 GROUP BY ROLLUP(TimeYear, TimeMonth)
 ORDER BY TimeYear, TimeMonth;

--Summarize (SUM, COUNT, and MIN) store sales for USA and Canada between 2016 and 2017 by year, Quarter and month
 SELECT TimeYear, TimeQuarter, TimeMonth, 
       SUM(SalesDollar) AS SumSales
 FROM SSSales, SSStore, SSTimeDim
 WHERE SSSales.StoreId = SSStore.StoreId 
   AND SSSales.TimeNo = SSTimeDim.TimeNo
   AND (StoreNation = 'USA' 
     OR StoreNation = 'Canada') 
   AND TimeYear BETWEEN 2016 AND 2017
 GROUP BY ROLLUP(TimeYear, TimeQuarter, TimeMonth)
 ORDER BY TimeYear, TimeQuarter, TimeMonth;


