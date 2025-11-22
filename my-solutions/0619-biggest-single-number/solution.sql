# Write your MySQL query statement below
SELECT 
    Max(n.num) as num
FROM
    (SELECT
    Max(num) as maxnum,
num
FROM MyNumbers 
GROUP BY num
HAVING count(num) = 1) AS n
