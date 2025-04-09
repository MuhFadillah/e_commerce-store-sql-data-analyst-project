/*
-------------------------------------------------------------------------------
Ranking Analysis
-------------------------------------------------------------------------------
Purpose:
    - To rank items (e.g., category, subcategory) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), OVER(), LIMIT ()
    - Clauses: GROUP BY, ORDER BY
-------------------------------------------------------------------------------
*/

--- Which 5 products Generating the Highest Revenue? ---
--- Simple Ranking ---

SELECT 
sub_category AS product ,
sum(amount) AS revenue 
FROM details d 
GROUP BY product
ORDER BY revenue DESC 
LIMIT 5

--- What are the 5 worst-performing products in terms of sales? ---

SELECT 
sub_category AS product ,
sum(amount) AS revenue 
FROM details d 
GROUP BY product
ORDER BY revenue ASC 
LIMIT 5

--- Complex but Flexibly Ranking Using Window Functions ---

SELECT * 
FROM 
	(SELECT 
	sub_category AS product,
	sum(amount) AS revenue,
	RANK () OVER (ORDER BY sum (amount) DESC) AS rank_product
	FROM details d 
	GROUP BY product) AS ranked_prodect
WHERE rank_product <= 5

--- Complex but Flexibly Worst Ranking Using Window Functions ---

SELECT * 
FROM 
	(SELECT 
	sub_category AS product,
	sum(amount) AS revenue,
	RANK () OVER (ORDER BY sum (amount) ASC) AS rank_product
	FROM details d 
	GROUP BY product) AS ranked_prodect
WHERE rank_product <= 5