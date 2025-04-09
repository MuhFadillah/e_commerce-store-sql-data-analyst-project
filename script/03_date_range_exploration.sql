/*
-------------------------------------------------------------------------------
Date Range Exploration 
-------------------------------------------------------------------------------
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), EXTRACT(MONTH FROM), AGE ()
-------------------------------------------------------------------------------
*/

--- Determine the first and last order date and the total duration in months ---

SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    EXTRACT (MONTH FROM age (MAX(order_date), MIN(order_date))) AS order_range_by_month,
    age(MAX(order_date), MIN(order_date)) AS order_range_by_detail_date
FROM orders o ;