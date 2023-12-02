SELECT norm.part_norm, norm.count_norm, ind.count_indiv, ens.count_ens, gro.count_gro  
FROM (
    Select date_part('month', start_time) AS part_norm, count(*) AS count_norm
    from lesson 
    where date_part('year', start_time) = 2023 
    Group by date_part('month', start_time)
) as norm

LEFT JOIN (
    SELECT date_part('month', lesson.start_time) AS part_ind, count(*) AS count_indiv
        FROM lesson 
        LEFT JOIN individual_lesson ON lesson.lesson_id = individual_lesson.lesson_id 
        WHERE individual_lesson.lesson_id IS NOT NULL AND date_part('year', start_time) = 2023 
        GROUP BY date_part('month', lesson.start_time) 
    
) AS ind
ON norm.part_norm = ind.part_ind
LEFT JOIN (
    SELECT date_part('month', lesson.start_time) AS part_ens, count(*) AS count_ens
        FROM lesson 
        LEFT JOIN ensemble ON lesson.lesson_id = ensemble.lesson_id 
        WHERE ensemble.lesson_id IS NOT NULL AND date_part('year', start_time) = 2023 
        GROUP BY date_part('month', lesson.start_time) 
) AS ens
ON norm.part_norm = ens.part_ens

LEFT JOIN (
    SELECT date_part('month', lesson.start_time) AS part_gro, count(*) AS count_gro
        FROM lesson 
        LEFT JOIN group_lesson ON lesson.lesson_id = group_lesson.lesson_id 
        WHERE group_lesson.lesson_id IS NOT NULL AND date_part('year', start_time) = 2023 
        GROUP BY date_part('month', lesson.start_time) 
) AS gro
ON norm.part_norm = gro.part_gro
ORDER BY norm.part_norm ASC
;