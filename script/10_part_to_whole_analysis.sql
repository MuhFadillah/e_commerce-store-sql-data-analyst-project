/*
-------------------------------------------------------------------------------
Part-to-Whole Analysis
-------------------------------------------------------------------------------
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
-------------------------------------------------------------------------------
*/

--- Which categories contribute the most to overall sales? ---

WITH category_sales AS (
	SELECT 
	category ,
	sum(amount) AS total_sales 
	FROM details d 
	GROUP BY category 
)
	SELECT 
	category,
	total_sales,
	sum(total_sales) OVER () AS overall_sales,
	round(CAST (total_sales AS NUMERIC) / sum(total_sales) OVER () * 100,2) AS percentage_of_total
	FROM category_sales
	ORDER BY total_sales DESC 