/*
-------------------------------------------------------------------------------
Cumulative Analysis
-------------------------------------------------------------------------------
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER()
-------------------------------------------------------------------------------
*/

--- Calculate the total sales per month ---
--- and the running total of sales over time ---

SELECT
	order_year,
	to_char(to_date(order_month::TEXT , 'MM'), 'month')  AS order_month,
	total_sales,
	sum(total_sales) OVER (ORDER BY order_year, order_month ) AS running_total_sales
FROM 
	(
		SELECT 
		EXTRACT (YEAR FROM o.order_date) AS order_year,
		EXTRACT (MONTH FROM o.order_date) AS order_month,
		sum(d.amount) AS total_sales
		FROM details d 
		LEFT JOIN orders o 
		ON d.order_id = o.order_id 
		GROUP BY EXTRACT (YEAR FROM o.order_date), EXTRACT (MONTH FROM o.order_date)
		ORDER BY min(EXTRACT (MONTH FROM o.order_date)) 
) t