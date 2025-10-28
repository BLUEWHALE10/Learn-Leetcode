# Write your MySQL query statement below
SELECT Vs.customer_id,COUNT(vs.customer_id) AS count_no_trans 
FROM Visits Vs
LEFT JOIN Transactions  Tr
ON Tr.visit_id = Vs.visit_id
WHERE transaction_id IS NULL
GROUP BY Vs.customer_id
