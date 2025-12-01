# creation de base de donner
create database hospitaliere;

# select base de donner
USE hospitaliere;

# Table: departments
CREATE TABLE departments
(
    department_id   INT(11) PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL,
    location        VARCHAR(100)
);

# Table: rooms
CREATE TABLE rooms
(
    room_id      INT(11) PRIMARY KEY AUTO_INCREMENT,
    room_number  VARCHAR(10)                        NOT NULL UNIQUE,
    room_type    ENUM ('General', 'Private', 'ICU') NOT NULL,
    availability BOOLEAN DEFAULT true
);

# Table: patients
CREATE TABLE patients
(
    patient_id    INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name    VARCHAR(50)             NOT NULL,
    last_name     VARCHAR(50)             NOT NULL,
    gender        ENUM ('Male', 'Female') NOT NULL,
    date_of_birth DATE                    NOT NULL,
    phone_number  VARCHAR(15),
    email         VARCHAR(100),
    address       VARCHAR(255)
);

# Table: doctors
CREATE TABLE doctors
(
    doctor_id      INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name     VARCHAR(50) NOT NULL,
    last_name      VARCHAR(50) NOT NULL,
    specialization VARCHAR(50),
    phone_number   VARCHAR(15),
    email          VARCHAR(100),
    department_id  INT(11),

    FOREIGN KEY (department_id) REFERENCES departments (department_id)
);

# Table: staff
CREATE TABLE staff
(
    staff_id      INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    job_title     VARCHAR(50) NOT NULL,
    phone_number  VARCHAR(15),
    email         VARCHAR(100) UNIQUE,
    department_id INT(11),

    FOREIGN KEY (department_id) REFERENCES departments (department_id)
);

# Table: medications
CREATE TABLE medications
(
    medication_id   INT(11) PRIMARY KEY AUTO_INCREMENT,
    medication_name VARCHAR(100) NOT NULL,
    dosage          VARCHAR(50)
);

# Table: admissions
CREATE TABLE admissions
(
    admission_id   INT(11) PRIMARY KEY AUTO_INCREMENT,
    patient_id     INT(11) NOT NULL,
    room_id        INT(11),
    admission_date DATE    NOT NULL,
    discharge_date DATE,

    FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
    FOREIGN KEY (room_id) REFERENCES rooms (room_id)
);

# Table: appointments
CREATE TABLE appointments
(
    appointment_id   INT(11) PRIMARY KEY AUTO_INCREMENT,
    appointment_date DATE    NOT NULL,
    appointment_time TIME    NOT NULL,
    doctor_id        INT(11) NOT NULL,
    patient_id       INT(11) NOT NULL,
    reason           VARCHAR(255),

    FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patients (patient_id)
);

# Table: prescriptions
CREATE TABLE prescriptions
(
    prescription_id     INT(11) PRIMARY KEY AUTO_INCREMENT,
    patient_id          INT(11) NOT NULL,
    doctor_id           INT(11) NOT NULL,
    medication_id       INT(11) NOT NULL,
    prescription_date   DATE    NOT NULL,
    dosage_instructions VARCHAR(255),

    FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id),
    FOREIGN KEY (medication_id) REFERENCES medications (medication_id)
);