INSERT INTO historical.lessons as target_d (lesson_type)
SELECT lesson_type
FROM soundgood.lesson_type as source_d
WHERE source_d.lesson_id = target_d.lesson_id;