/*
-------------------------------------------------------------------------------
Data Segmentation Analysis
-------------------------------------------------------------------------------
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
-------------------------------------------------------------------------------
*/

/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than 2,000.
	- Regular: Customers with at least 12 months of history but spending 2,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

WITH customer_spending AS (
	SELECT 
	d.order_id ,
	sum(d.amount) AS total_spending,
	min(o.order_date) AS first_order,
	max(o.order_date) AS last_order ,
	EXTRACT (MONTH FROM age(max(o.order_date), min(o.order_date)) ) AS lifespan
	FROM details d 
	LEFT JOIN orders o 
	ON d.order_id  = o.order_id 
	GROUP BY d.order_id
)
SELECT 
customer_segment,
count(order_id) AS total_customer 
FROM
(
	SELECT
		order_id ,
		CASE 
			WHEN lifespan >= 12 AND total_spending > 2000 THEN 'VIP'
			WHEN lifespan >= 12 AND total_spending < 2000 THEN 'Reguler'
			ELSE 'New'
		END  AS customer_segment
	FROM customer_spending 
)AS segmented_customer
GROUP BY customer_segment
ORDER BY total_customer 