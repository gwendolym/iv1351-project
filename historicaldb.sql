CREATE DATABASE historical;

CREATE TABLE lessons (
 lesson_hist_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lesson_type VARCHAR(50) NOT NULL,
 genre VARCHAR(200),
 instrument VARCHAR(200),
 skill_level VARCHAR(50),
 lesson_price INT,
 student_first_name VARCHAR(200),
 student_last_name VARCHAR(200),
 student_email VARCHAR(200)
);