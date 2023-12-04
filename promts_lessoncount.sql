SELECT
    EXTRACT(MONTH FROM l.start_time) AS month,
    COUNT(*) AS lessons,
    COUNT(DISTINCT il.lesson_id) AS individual,
    COUNT(DISTINCT e.lesson_id) AS ensembles,
    COUNT(DISTINCT gl.lesson_id) AS groups
FROM lesson l
LEFT JOIN individual_lesson il 
ON l.lesson_id = il.lesson_id AND EXTRACT(YEAR FROM l.start_time) = 2023
LEFT JOIN ensemble e 
ON l.lesson_id = e.lesson_id AND EXTRACT(YEAR FROM l.start_time) = 2023
LEFT JOIN group_lesson gl 
ON l.lesson_id = gl.lesson_id AND EXTRACT(YEAR FROM l.start_time) = 2023
WHERE EXTRACT(YEAR FROM l.start_time) = 2023
GROUP BY EXTRACT(MONTH FROM l.start_time)
ORDER BY month ASC;