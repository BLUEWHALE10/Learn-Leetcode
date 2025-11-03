# Write your MySQL query sta 
SELECT

    S.student_id AS student_id,
    S.student_name AS student_name,
    sub.subject_name AS subject_name,
    COUNT(e.student_id) AS attended_exams
    
FROM Students S
CROSS JOIN Subjects sub
LEFT JOIN Examinations e ON
e.student_id = S.student_id and
sub.subject_name = e.subject_name

GROUP BY 

S.student_id,
sub.subject_name

ORDER BY 

S.student_id,
sub.subject_name



