/*
-------------------------------------------------------------------------------
Dimensions Exploration
-------------------------------------------------------------------------------
Purpose:
    - To explore the structure of dimension tables e_commerce.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
-------------------------------------------------------------------------------
*/

--- Retrieve a list of unique state ---

SELECT DISTINCT 
    state 
FROM orders o 
ORDER BY state ;

--- Retrieve a list of unique category,sub_category,payment_mode ---

SELECT DISTINCT 
    category , 
    sub_category , 
    payment_mode 
FROM details d 
ORDER BY category , sub_category , payment_mode  ;
