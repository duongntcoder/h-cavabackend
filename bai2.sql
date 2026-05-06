CREATE DATABASE UniversityDB;

\c UniversityDB;

CREATE SCHEMA university;

CREATE TABLE university.Students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    email VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT check_age 
    CHECK (EXTRACT(YEAR FROM AGE(birth_date)) >= 18)
);

CREATE TABLE university.Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT
);

CREATE TABLE university.Enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE DEFAULT CURRENT_DATE,
    CONSTRAINT fk_student
        FOREIGN KEY (student_id)
        REFERENCES university.Students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_course
        FOREIGN KEY (course_id)
        REFERENCES university.Courses(course_id)
        ON DELETE CASCADE
);

DROP TABLE university.Enrollments;
DROP TABLE university.Students;
DROP TABLE university.Courses;