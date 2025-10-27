# Write your MySQL query statement below
SELECT prd.product_name, sle.year, sle.price 
FROM Sales sle
RIGHT JOIN Product prd 
ON sle.product_id = prd.product_id
WHERE sle.price IS NOT NULL AND sle.year IS NOT NULL
