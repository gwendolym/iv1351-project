SELECT
    EXTRACT(MONTH FROM l.start_time) AS part_norm,
    COUNT(*) AS count_norm,
    COUNT(DISTINCT il.lesson_id) AS count_indiv,
    COUNT(DISTINCT e.lesson_id) AS count_ens,
    COUNT(DISTINCT gl.lesson_id) AS count_gro
FROM lesson l
LEFT JOIN individual_lesson il ON l.lesson_id = il.lesson_id AND EXTRACT(YEAR FROM l.start_time) = 2023
LEFT JOIN ensemble e ON l.lesson_id = e.lesson_id AND EXTRACT(YEAR FROM l.start_time) = 2023
LEFT JOIN group_lesson gl ON l.lesson_id = gl.lesson_id AND EXTRACT(YEAR FROM l.start_time) = 2023
WHERE EXTRACT(YEAR FROM l.start_time) = 2023
GROUP BY EXTRACT(MONTH FROM l.start_time)
ORDER BY part_norm ASC;