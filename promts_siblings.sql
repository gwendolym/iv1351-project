SELECT count - 1 AS no_of_siblings, COUNT(student_id) AS no_of_students FROM (
    SELECT student.student_id, t.count FROM student FULL JOIN (
        SELECT sibling_id, COUNT(student_id) FROM student GROUP BY sibling_id
    ) AS t on student.sibling_id = t.sibling_id
) GROUP BY count;
