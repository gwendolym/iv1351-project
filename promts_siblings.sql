EXPLAIN ANALYZE Select count - 1 AS no_of_siblings, count(*) * count AS no_of_students 
FROM (
    SELECT sibling_id, count(student_id) 
    FROM student 
    GROUP BY sibling_id) 
Group by count;