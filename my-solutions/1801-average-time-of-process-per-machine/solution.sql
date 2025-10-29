# Write your MySQL query statement below
SELECT Ac1.machine_id,ROUND(AVG(Ac2.timestamp - Ac1.timestamp),3) AS processing_time
FROM Activity Ac1
LEFT JOIN Activity Ac2
ON Ac1.machine_id = Ac2.machine_id and  
Ac1.process_id = Ac2.process_id and
Ac1.activity_type = 'start' and
Ac2.activity_type = 'end'
GROUP BY Ac1.machine_id
