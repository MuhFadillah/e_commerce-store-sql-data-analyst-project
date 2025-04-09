/*
-------------------------------------------------------------------------------
Magnitude Analysis
-------------------------------------------------------------------------------
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
-------------------------------------------------------------------------------
*/

--- Find total products by category ---

SELECT
    category,
    COUNT(DISTINCT sub_category) AS total_products
FROM details d 
GROUP BY category
ORDER BY total_products DESC;

--- What is the average amount in each category? ---

SELECT 
category ,
avg(amount) AS avg_amount 
FROM details d 
GROUP BY category 
ORDER BY avg_amount

--- What is the total revenue generated for each category? ---

SELECT 
category ,
sum(amount) AS total_revenue 
FROM details d 
GROUP BY category 
ORDER BY total_revenue
