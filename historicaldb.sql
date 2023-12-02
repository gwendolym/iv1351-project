CREATE DATABASE historical;

CREATE TABLE lessons (
 lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 lesson_type VARCHAR(50),
 genre VARCHAR(200),
 instrument VARCHAR(200),
 skill_level VARCHAR(50),
 lesson_price INT,
 student_name VARCHAR(200),
 student_email VARCHAR(200)
);