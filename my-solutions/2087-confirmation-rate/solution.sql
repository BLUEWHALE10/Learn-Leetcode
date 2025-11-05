# Write your MySQL query statement below
SELECT
   s.user_id,
   ROUND(AVG(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END),2) AS confirmation_rate
FROM Signups s

LEFT JOIN Confirmations c
ON c.user_id = s.user_id
GROUP BY s.user_id
ORDER BY confirmation_rate
