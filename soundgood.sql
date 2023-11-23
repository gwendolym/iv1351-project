CREATE DATABASE soundgood;

CREATE TABLE address (
 address_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 address_line_1 VARCHAR(200) NOT NULL,
 address_line_2 VARCHAR(200),
 zip_code VARCHAR(200) NOT NULL,
 city VARCHAR(200) NOT NULL,
 country VARCHAR(200) NOT NULL
);

ALTER TABLE address ADD CONSTRAINT PK_address PRIMARY KEY (address_id);


CREATE TABLE instrument_skill (
 skill_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 level CHAR(1) NOT NULL,
 instrument VARCHAR(200)
);

ALTER TABLE instrument_skill ADD CONSTRAINT PK_instrument_skill PRIMARY KEY (skill_id);


CREATE TABLE instrument_to_rent (
 instrument_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 brand VARCHAR(200),
 model VARCHAR(200),
 fee INT NOT NULL,
 stock INT NOT NULL,
 instrument VARCHAR(200)
);

ALTER TABLE instrument_to_rent ADD CONSTRAINT PK_instrument_to_rent PRIMARY KEY (instrument_id);


CREATE TABLE lesson_price (
 lesson_price_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 skill_id INT,
 lesson_type CHAR(1) NOT NULL,
 price INT NOT NULL
);

ALTER TABLE lesson_price ADD CONSTRAINT PK_lesson_price PRIMARY KEY (lesson_price_id);


CREATE TABLE person (
 person_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 personal_number CHAR(12) NOT NULL UNIQUE,
 last_name VARCHAR(200),
 first_name VARCHAR(200),
 email VARCHAR(200) UNIQUE,
 phone_number VARCHAR(200) UNIQUE,
 address_id INT 
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE student (
 person_id INT  NOT NULL,
 sibling_id INT NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (person_id);


CREATE TABLE student_skills (
 person_id INT NOT NULL,
 skill_id INT NOT NULL
);

ALTER TABLE student_skills ADD CONSTRAINT PK_student_skills PRIMARY KEY (person_id,skill_id);


CREATE TABLE contact_person (
 person_id INT NOT NULL,
 last_name VARCHAR(200),
 first_name VARCHAR(200),
 email VARCHAR(200),
 phone_number VARCHAR(200)
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (person_id);


CREATE TABLE instructor (
 person_id INT NOT NULL,
 can_teach_ensemble BOOL NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (person_id);


CREATE TABLE instructor_instruments (
 person_id INT NOT NULL,
 instrument VARCHAR(200) NOT NULL
);

ALTER TABLE instructor_instruments ADD CONSTRAINT PK_instructor_instruments PRIMARY KEY (person_id,instrument);


CREATE TABLE lesson (
 lesson_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL,
 start_time TIMESTAMP(6) NOT NULL,
 duration TIME(6) NOT NULL,
 price INT NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE rental_agreement (
 person_id INT ,
 agreement_id BOOL NOT NULL,
 instrument_id INT NOT NULL,
 rental_date DATE NOT NULL,
 lease_period INT NOT NULL,
 agreement_fee INT NOT NULL
);

ALTER TABLE rental_agreement ADD CONSTRAINT PK_rental_agreement PRIMARY KEY (person_id,agreement_id);


CREATE TABLE timespan (
 person_id INT NOT NULL,
 start_time TIMESTAMP(6) NOT NULL,
 duration TIME(6) NOT NULL
);

ALTER TABLE timespan ADD CONSTRAINT PK_timespan PRIMARY KEY (person_id,start_time);


CREATE TABLE ensemble (
 lesson_id INT NOT NULL,
 min_places INT NOT NULL,
 max_places INT NOT NULL,
 genre VARCHAR(200) NOT NULL
 );

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (lesson_id);


CREATE TABLE ensemble_students (
 person_id INT NOT NULL,
 lesson_id INT NOT NULL
);

ALTER TABLE ensemble_students ADD CONSTRAINT PK_ensemble_students PRIMARY KEY (person_id,lesson_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 min_places INT NOT NULL,
 max_places INT NOT NULL,
 skill_id INT NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE group_students (
 person_id INT NOT NULL,
 lesson_id INT NOT NULL
);

ALTER TABLE group_students ADD CONSTRAINT PK_group_students PRIMARY KEY (person_id,lesson_id);


CREATE TABLE individual_lesson (
 lesson_id INT NOT NULL,
 student_person_id INT NOT NULL,
 skill_id INT NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


ALTER TABLE lesson_price ADD CONSTRAINT FK_lesson_price_0 FOREIGN KEY (skill_id) REFERENCES instrument_skill (skill_id);


ALTER TABLE person ADD CONSTRAINT FK_person_0 FOREIGN KEY (address_id) REFERENCES address (address_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE student_skills ADD CONSTRAINT FK_student_skills_0 FOREIGN KEY (person_id) REFERENCES student (person_id);
ALTER TABLE student_skills ADD CONSTRAINT FK_student_skills_1 FOREIGN KEY (skill_id) REFERENCES instrument_skill (skill_id);


ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (person_id) REFERENCES student (person_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id);


ALTER TABLE instructor_instruments ADD CONSTRAINT FK_instructor_instruments_0 FOREIGN KEY (person_id) REFERENCES instructor (person_id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (person_id) REFERENCES instructor (person_id);


ALTER TABLE rental_agreement ADD CONSTRAINT FK_rental_agreement_0 FOREIGN KEY (person_id) REFERENCES student (person_id);
ALTER TABLE rental_agreement ADD CONSTRAINT FK_rental_agreement_1 FOREIGN KEY (instrument_id) REFERENCES instrument_to_rent (instrument_id);


ALTER TABLE timespan ADD CONSTRAINT FK_timespan_0 FOREIGN KEY (person_id) REFERENCES instructor (person_id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);


ALTER TABLE ensemble_students ADD CONSTRAINT FK_ensemble_students_0 FOREIGN KEY (person_id) REFERENCES student (person_id);
ALTER TABLE ensemble_students ADD CONSTRAINT FK_ensemble_students_1 FOREIGN KEY (lesson_id) REFERENCES ensemble (lesson_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (skill_id) REFERENCES instrument_skill (skill_id);


ALTER TABLE group_students ADD CONSTRAINT FK_group_students_0 FOREIGN KEY (person_id) REFERENCES student (person_id);
ALTER TABLE group_students ADD CONSTRAINT FK_group_students_1 FOREIGN KEY (lesson_id) REFERENCES group_lesson (lesson_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (student_person_id) REFERENCES student (person_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_2 FOREIGN KEY (skill_id) REFERENCES instrument_skill (skill_id);


