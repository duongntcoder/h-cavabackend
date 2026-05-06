CREATE DATABASE HospitalDB;

\c HospitalDB;

CREATE SCHEMA hospital;

CREATE TABLE hospital.Patients (
    patient_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10),
    birth_date DATE,
    phone VARCHAR(20),
    address TEXT
);

CREATE TABLE hospital.Departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE hospital.Doctors (
    doctor_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    department_id INT,
    CONSTRAINT fk_department
        FOREIGN KEY (department_id)
        REFERENCES hospital.Departments(department_id)
        ON DELETE SET NULL
);

CREATE TABLE hospital.MedicalRecords (
    record_id SERIAL PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    department_id INT,
    diagnosis TEXT,
    visit_date DATE NOT NULL,
    treatment TEXT,
    CONSTRAINT fk_patient
        FOREIGN KEY (patient_id)
        REFERENCES hospital.Patients(patient_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES hospital.Doctors(doctor_id)
        ON DELETE SET NULL,
    CONSTRAINT fk_department_record
        FOREIGN KEY (department_id)
        REFERENCES hospital.Departments(department_id)
        ON DELETE SET NULL
);

DROP TABLE hospital.MedicalRecords;
DROP TABLE hospital.Doctors;
DROP TABLE hospital.Departments;
DROP TABLE hospital.Patients;