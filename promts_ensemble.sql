SELECT
    CASE 
        WHEN tble.day = 0 THEN 'Sunday'
        WHEN tble.day = 1 THEN 'Monday'
        WHEN tble.day = 2 THEN 'Tuesday'
        WHEN tble.day = 3 THEN 'Wednesday'
        WHEN tble.day = 4 THEN 'Thursday'
        WHEN tble.day = 5 THEN 'Friday'
        WHEN tble.day = 6 THEN 'Saturday'
    END AS weekday,
    tble.genre,
    CASE
        WHEN tble.available_spots = 0 THEN 'No Seats'
        WHEN tble.available_spots  >= 1 AND tble.available_spots  <= 7  THEN '1 to 7 seats'
        ELSE 'Many Seats'
    END AS free_seats
FROM (
    SELECT 
        DATE_PART('dow', lesson.start_time) AS day,
        ensemble.genre, 
        CASE 
            WHEN ens_stud.numb_of_students IS Null THEN ensemble.max_places
            ELSE (ensemble.max_places - ens_stud.numb_of_students)
        END AS available_spots
    FROM ensemble
    INNER JOIN lesson ON lesson.lesson_id = ensemble.lesson_id
    LEFT JOIN (SELECT lesson_id, count(*) as numb_of_students
        From ensemble_students
        GROUP BY lesson_id) AS ens_stud ON lesson.lesson_id = ens_stud.lesson_id
    WHERE DATE_PART('year', lesson.start_time) = DATE_PART('year', CURRENT_TIMESTAMP (0)) AND DATE_PART('week', lesson.start_time) = DATE_PART('week', CURRENT_TIMESTAMP (0)) +1
    ORDER BY day ASC, genre ASC)
    AS tble
;