SELECT id_tog, count(*)
FROM (
    SELECT sibling_id, count(*) as id_tog
    FROM student 
    GROUP BY  sibling_id
)
GROUP BY id_tog
ORDER BY id_tog ASC
 
;