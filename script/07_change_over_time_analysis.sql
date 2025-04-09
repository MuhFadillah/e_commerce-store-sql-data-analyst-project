/*
-------------------------------------------------------------------------------
Change Over Time Analysis
-------------------------------------------------------------------------------
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: EXTRACT (YEAR  FROM),TO_CHAR(),DATE_TRUNC ()
    - Aggregate Functions: SUM(), COUNT()
-------------------------------------------------------------------------------
*/

--- Analyse sales performance over time ---
--- Quick Date Functions ---

SELECT 
EXTRACT (YEAR FROM o.order_date) AS order_year ,
to_char(o.order_date, 'Month') AS order_month,
sum(amount) AS total_revenue,
count(DISTINCT d.order_id) AS total_customer,
sum(quantity) AS total_quantity 
FROM details d 
LEFT JOIN orders o 
ON d.order_id = o.order_id 
GROUP BY order_year ,order_month
ORDER BY min(o.order_date) 

--- DATE_TRUNC () ---

SELECT
	date_trunc('year', order_date) AS order_date ,
	sum(total_sales) AS total_sales ,
	sum(total_customer) AS total_customer,
	sum(total_quantity ) AS total_quantity 
FROM 
		(SELECT 
		o.order_date AS order_date ,
		d.order_id ,
		sum(amount) AS total_sales,
		count(DISTINCT d.order_id) AS total_customer,
		sum(d.quantity) AS total_quantity 
		FROM details d 
		LEFT JOIN orders o 
		ON d.order_id  = o.order_id 
		GROUP BY d.order_id ,o.order_date
		) t
GROUP BY date_trunc('year', order_date) ;
