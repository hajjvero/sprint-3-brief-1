USE hospitaliere;

-- 1
INSERT INTO patients (first_name, last_name, gender, date_of_birth, phone_number)
VALUES ('Alex', 'Johnson', 'Male', '1990-07-15', '1234567890');

-- 2
SELECT department_name, location
FROM departments;

-- 3
SELECT *
FROM patients
ORDER BY date_of_birth ASC;

-- 4
SELECT DISTINCT gender
FROM patients;

-- 5
SELECT *
FROM doctors
LIMIT 3;

-- 6
SELECT *
FROM patients
WHERE YEAR(date_of_birth) > 2000;

-- 7
SELECT d.*
FROM doctors d
         JOIN departments dep ON d.department_id = dep.department_id
WHERE dep.department_name IN ('Cardiology', 'Neurology');

-- 8
SELECT *
FROM admissions
WHERE admission_date BETWEEN '2024-12-01' AND '2024-12-07';

-- 9
SELECT first_name,
       last_name,
       TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age,
       CASE
           WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) < 18 THEN 'Enfant'
           WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 18 AND 64 THEN 'Adulte'
           ELSE 'Senior'
           END                                       AS categorie_age
FROM patients;

-- 10
SELECT COUNT(*) AS total_rendez_vous
FROM appointments;

-- 11
SELECT dep.department_name,
       COUNT(d.doctor_id) AS nombre_medecins
FROM departments dep
         LEFT JOIN doctors d ON dep.department_id = d.department_id
GROUP BY dep.department_id;

-- 12
SELECT AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())) AS age_moyen
FROM patients;

-- 13
SELECT appointment_date,
       appointment_time
FROM appointments
ORDER BY appointment_date DESC, appointment_time DESC
LIMIT 1;

-- 14
SELECT r.room_number, r.room_type, COUNT(a.admission_id) AS total_admissions
FROM rooms r
         LEFT JOIN admissions a On r.room_id = a.room_id
GROUP BY r.room_id;

-- 15
SELECT *
FROM patients
WHERE email IS NULL
   OR email = '';

-- 16
SELECT a.appointment_date,
       CONCAT(d.first_name, d.last_name) AS doctir,
       CONCAT(p.first_name, p.last_name) as patient
FROM appointments a
         RIGHT JOIN doctors d ON d.doctor_id = a.doctor_id
         RIGHT JOIN patients p ON p.patient_id = a.patient_id;

-- 17
DELETE
FROM appointments
WHERE YEAR(appointment_date) < 2024;

-- 18
UPDATE departments
SET department_name = 'Cancer Treatment'
WHERE department_name = 'Oncology';

-- 19
SELECT gender,
       COUNT(*) AS nombre_patients
FROM patients
GROUP BY gender
HAVING nombre_patients >= 2;

# ALTER TABLE patients MODIFY COLUMN gender ENUM('Female', 'Male', 'Chalh');

-- 20
CREATE VIEW admissions_actives AS
SELECT a.admission_id,
       CONCAT(p.first_name, ' ', p.last_name) AS nom_patient,
       r.room_number,
       r.room_type,
       a.admission_date
FROM admissions a
         RIGHT JOIN patients p ON a.patient_id = p.patient_id
         RIGHT JOIN rooms r ON a.room_id = r.room_id
     WHERE discharge_date IS NULL;

SELECT * FROM admissions_actives;


# Les bonus pour les jointures:
