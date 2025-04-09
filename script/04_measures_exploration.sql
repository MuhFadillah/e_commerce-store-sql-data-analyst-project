/*
-------------------------------------------------------------------------------
Measures Exploration (Key Metrics)
-------------------------------------------------------------------------------
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG(),CAST(), ROUND ()
-------------------------------------------------------------------------------
*/

--- Find the Total Sales ---

SELECT 
sum(amount) AS total_sales 
FROM details d 

--- Find how many items are sold ---

SELECT 
sum(quantity) AS total_quantity 
FROM details d 

--- Find the average selling amount ---

SELECT 
round( CAST (avg(amount) AS NUMERIC),2) AS avg_selling_amount 
FROM details d 

--- Find the Total number of Orders ---

SELECT 
count(order_id) AS total_order 
FROM details d 

--- Find the total number of products ---

SELECT 
count(DISTINCT sub_category) AS total_product
FROM details d 

--- Find the total number of customers that has placed an order ---

SELECT 
	count(DISTINCT order_id) AS total_customers 
FROM orders o ;

--- Generate a Report that shows all key metrics of the business ---

SELECT
'Total Sales' AS measure_name,
sum(amount) AS measure_value
FROM details d 
	UNION ALL 
SELECT 
'Total Quantity',
sum(quantity) 
FROM details d 
	UNION ALL 
SELECT 
'avg_selling_amount ',
round( CAST (avg(amount) AS NUMERIC),2)
FROM details d 
	UNION ALL 
SELECT 
'total_order ',
count(order_id)
FROM details d 
	UNION ALL 
SELECT 
'total_product',
count(DISTINCT sub_category)
FROM details d 
	UNION ALL 
SELECT 
'total_customers ',
count(DISTINCT order_id)
FROM orders o ;
