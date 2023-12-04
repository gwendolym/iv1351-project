SELECT person.person_id, person.first_name, person.last_name, les_amount
FROM (
    SELECT instructor.instructor_id, count(*) AS les_amount
        FROM instructor 
        LEFT JOIN lesson 
            ON lesson.instructor_id = instructor.instructor_id 
        WHERE DATE_PART('month', lesson.start_time) = DATE_PART('month', CURRENT_TIMESTAMP (0)) AND DATE_PART('year',lesson.start_time) = DATE_PART('year',CURRENT_TIMESTAMP (0))
        GROUP BY instructor.instructor_id
)
LEFT JOIN person 
        ON instructor_id = person_id 
WHERE les_amount > 3
; 