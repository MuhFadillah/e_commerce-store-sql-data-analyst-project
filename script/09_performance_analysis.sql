/*
-------------------------------------------------------------------------------
Performance Analysis (Month-over-Month)
-------------------------------------------------------------------------------
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track monthly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
-------------------------------------------------------------------------------
*/

/* Analyze the monthly performance of products by comparing their sales 
to both the average sales performance of the product and the previous month sales */

WITH monthly_product_sales AS (
	SELECT 
	EXTRACT (MONTH FROM o.order_date) AS order_month ,
	sum(d.amount) AS total_sales,
	d.sub_category AS product
	FROM details d 
	LEFT JOIN orders o 
	ON d.order_id = o.order_id 
	GROUP BY EXTRACT (MONTH FROM o.order_date) , d.sub_category
	ORDER BY EXTRACT (MONTH FROM o.order_date)
),
monthly_product_sales2 AS (
SELECT
		order_month,
		product,
		total_sales,
		avg(total_sales) OVER (PARTITION BY product )  AS avg_sales,
		total_sales - avg(total_sales) OVER (PARTITION BY product ) AS diff_avg,
		CASE 
			WHEN total_sales - avg(total_sales) OVER (PARTITION BY product ) > 0 THEN 'Above Avg'
			WHEN total_sales - avg(total_sales) OVER (PARTITION BY product ) < 0 THEN 'Below Avg'
			ELSE 'avg'
		END AS avg_change,
		    --- Month-over-Month Analysis ---
		LAG (total_sales) OVER (PARTITION BY product ORDER BY order_month) AS pm_sales,
		total_sales - LAG (total_sales) OVER (PARTITION BY product ORDER BY order_month) AS diff_pm,
		CASE
			WHEN total_sales - LAG (total_sales) OVER (PARTITION BY product ORDER BY order_month) > 0 THEN 'Increace'
			WHEN total_sales - LAG (total_sales) OVER (PARTITION BY product ORDER BY order_month) < 0 THEN 'decreace'
			ELSE 'No change'
		END AS pm_change
FROM monthly_product_sales
ORDER BY order_month, product
)
SELECT 
to_char(to_date(order_month::TEXT , 'MM'), 'month' )AS order_month,
product,
total_sales,
pm_sales,
diff_pm,
pm_change
avg_sales,
diff_avg,
avg_change
FROM monthly_product_sales2