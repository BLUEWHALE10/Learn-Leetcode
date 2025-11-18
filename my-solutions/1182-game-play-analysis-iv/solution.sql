# Write your MySQL query statement below
SELECT
ROUND(COUNT(DISTINCT Ac1.player_id)/(SELECT COUNT(DISTINCT player_id) FROM Activity),2) AS fraction
FROM
Activity Ac1
INNER JOIN Activity Ac2
ON DATEDIFF(Ac2.event_date,Ac1.event_date)=1
AND Ac1.player_id = Ac2.player_id
WHERE 
(Ac1.player_id,Ac1.event_date) IN (SELECT 
    player_id,
    MIN(event_date)
FROM
    Activity
GROUP BY
    player_id
    )
