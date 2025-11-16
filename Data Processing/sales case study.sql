select * 
from SALES_CASE_STUDY.ANALYSIS.SALES;
-----------------------------------------------------
SELECT AVG(SALES) AS AVERAGE_SALES
FROM SALES_CASE_STUDY.ANALYSIS.SALES;

  ------------------------------------------------
  --STARTING DAY OF A PROMOTION
SELECT
  MIN(date) AS promo_start
  
  FROM  SALES_CASE_STUDY.ANALYSIS.SALES;
  -----------------------------------------------
  

  --LAST DAY OF PROMOTION 
 SELECT
 MAX(date) AS MAX_promo_end 
FROM SALES_CASE_STUDY.ANALYSIS.SALES;

--- COUNTING DAYS PROMOTION LASTED 
SELECT  COUNT(*) AS days_length

FROM SALES_CASE_STUDY.ANALYSIS.SALES;
-----------------------------------------------------------------
--creating/calculaying  a new colomn called unit sales

  SELECT date, sales, cost_of_sales, quantity_sold,
         sales:: NUMERIC / NULLIF(quantity_sold,0) AS unit_price
  FROM SALES_CASE_STUDY.ANALYSIS.SALES;
  --------------------------------------------------

   SELECT date,
   sales, 
   cost_of_sales, 
   quantity_sold,
         sales::numeric / NULLIF(quantity_sold,0) AS unit_price,
         cost_of_sales::numeric / NULLIF(quantity_sold,0) AS unit_cost
  FROM SALES_CASE_STUDY.ANALYSIS.SALES;
  
--------------------------------------------------------
--displaying trend by sales, qty, avg price
SELECT date,
  SUM(sales) AS revenue,
  SUM(quantity_sold) ,
  ROUND(SUM(sales)/NULLIF(SUM(quantity_sold),0),4) AS avg_unit_price,
  ROUND((SUM(sales)-SUM(cost_of_sales))/NULLIF(SUM(sales),0),4) AS pct_gross
FROM SALES_CASE_STUDY.ANALYSIS.SALES
GROUP BY 1
ORDER BY 1;
-----------------------------------------------------
--displaying the daily gross profit
select date,
sum(sales) -sum(cost_of_sales) as gross_profit
from SALES_CASE_STUDY.ANALYSIS.SALES
group by 1;
---------------------------------------------
--Top days by revenue / margin
SELECT
date, sales, quantity_sold, ROUND((sales - cost_of_sales),2) AS gross_profit
FROM SALES_CASE_STUDY.ANALYSIS.SALES
ORDER BY sales DESC
LIMIT 10;
---------------------- 
---calculating unity pric

 SELECT   SALES,
    QUANTITY_SOLD,
    ROUND(SALES / NULLIF(QUANTITY_SOLD, 0), 4) AS UNIT_PRICE,
    lag(quantity_sold) over (order by date) as previous_quantit
    
FROM SALES_CASE_STUDY.ANALYSIS.SALES
ORDER BY DATE;



---------------------------------------------


SELECT date,
SALES::numeric AS SALES,
cost_of_sales, 
quantity_sold,
sales:numeric / NULLIF(quantity_sold,0) AS unit_price,
         cost_of_sales::numeric / NULLIF(quantity_sold,0) AS unit_cost, SUM(sales) AS revenue,
   ROUND(((SALES - COST_OF_SALES)/NULLIF(QUANTITY_SOLD,0)),2) AS GP_PER_UNIT,
   ROUND(SUM(SALES)/NULLIF(SUM(QUANTITY_SOLD),0),2) AS DAILY_UNIT_PRICE,
  ROUND(SUM(sales)/NULLIF(SUM(quantity_sold),0),4) AS avg_unit_price,
  ROUND((SUM(sales)-SUM(cost_of_sales))/NULLIF(SUM(sales),0),4) AS pct_gross,

     CASE
        WHEN DATE BETWEEN '1/1/2014' AND '31/12/2014' THEN 'Year 2014'
        WHEN DATE BETWEEN '1/1/2015' AND '31/12/2015' THEN 'Year 2015'
        WHEN DATE BETWEEN '1/1/2016' AND '9/9/2016' THEN 'Year 2016 '
        ELSE 'Other'
    END AS DATE_GROUP,
    CASE
        WHEN QUANTITY_SOLD BETWEEN 10000 AND 20000 THEN ' high Promo'
        WHEN QUANTITY_SOLD BETWEEN 100 AND 9999 THEN 'Medium promo'
        ELSE 'very high promo'
        end as price_type
FROM SALES_CASE_STUDY.ANALYSIS.SALES
group by date, sales, cost_of_sales, quantity_sold
order by date;
---------------------
--checking the min and max quantity sold
select max(quantity_sold)
from SALES_CASE_STUDY.ANALYSIS.SALES;
select min(quantity_sold)
from SALES_CASE_STUDY.ANALYSIS.SALES;
---------------------------------------------------------------------------
    
select count(cost_of_sales)
from SALES_CASE_STUDY.ANALYSIS.SALES;









  

