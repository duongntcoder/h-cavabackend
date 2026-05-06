CREATE DATABASE ElearningDB;

\c ElearningDB;

CREATE SCHEMA elearning;

CREATE TABLE elearning.Students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE elearning.Instructors (
    instructor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE elearning.Courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    instructor_id INT,
    CONSTRAINT fk_instructor
        FOREIGN KEY (instructor_id)
        REFERENCES elearning.Instructors(instructor_id)
        ON DELETE SET NULL
);

CREATE TABLE elearning.Enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE NOT NULL,
    CONSTRAINT fk_student
        FOREIGN KEY (student_id)
        REFERENCES elearning.Students(student_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_course
        FOREIGN KEY (course_id)
        REFERENCES elearning.Courses(course_id)
        ON DELETE CASCADE
);

CREATE TABLE elearning.Assignments (
    assignment_id SERIAL PRIMARY KEY,
    course_id INT,
    title VARCHAR(100) NOT NULL,
    due_date DATE NOT NULL,
    CONSTRAINT fk_course_assignment
        FOREIGN KEY (course_id)
        REFERENCES elearning.Courses(course_id)
        ON DELETE CASCADE
);

CREATE TABLE elearning.Submissions (
    submission_id SERIAL PRIMARY KEY,
    assignment_id INT,
    student_id INT,
    submission_date DATE NOT NULL,
    grade DECIMAL(5,2) CHECK (grade >= 0 AND grade <= 100),
    CONSTRAINT fk_assignment
        FOREIGN KEY (assignment_id)
        REFERENCES elearning.Assignments(assignment_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_student_submission
        FOREIGN KEY (student_id)
        REFERENCES elearning.Students(student_id)
        ON DELETE CASCADE
);

DROP TABLE elearning.Submissions;
DROP TABLE elearning.Assignments;
DROP TABLE elearning.Enrollments;
DROP TABLE elearning.Courses;
DROP TABLE elearning.Instructors;
DROP TABLE elearning.Students;