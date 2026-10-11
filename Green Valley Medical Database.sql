DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Treatments;
DROP TABLE IF EXISTS Appointments;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patients;

CREATE TABLE Patients (
    patient_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10) NOT NULL
);

CREATE TABLE Doctors (
    doctor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Appointments (
    appointment_id SERIAL PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

CREATE TABLE Treatments (
    treatment_id SERIAL PRIMARY KEY,
    appointment_id INT NOT NULL,
    treatment_name VARCHAR(100) NOT NULL,
    description TEXT,
    cost DECIMAL(10, 2) NOT NULL CHECK (cost >= 0),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

CREATE TABLE Payments (
    payment_id SERIAL PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL CHECK (amount_paid >= 0),
    payment_date TIMESTAMP NOT NULL,
    payment_method VARCHAR(30) NOT NULL, -- e.g., Cash, M-Pesa, Insurance
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

INSERT INTO Patients (first_name, last_name, phone_number, date_of_birth, gender) VALUES
('Alice', 'Moraa', '0711122233', '1995-04-12', 'Female'),
('Brian', 'Kiprono', '0722334455', '1988-09-23', 'Male'),
('Cynthia', 'Achieng', '0733445566', '2001-01-15', 'Female'),
('Daniel', 'Mutua', '0744556677', '1979-11-04', 'Male'),
('Eunice', 'Wanjiru', '0755667788', '1992-06-30', 'Female'),
('Felix', 'Ouma', '0766778899', '1985-12-19', 'Male'),
('Grace', 'Nduta', '0777889900', '1998-03-25', 'Female'),
('Hassan', 'Juma', '0788990011', '1990-07-08', 'Male'),
('Irene', 'Cheptoo', '0799001122', '1994-10-11', 'Female'),
('James', 'Mwangi', '0700112233', '1982-05-20', 'Male');

INSERT INTO Doctors (first_name, last_name, specialization, phone_number, email) VALUES
('Dr. Samuel', 'Otieno', 'General Practitioner', '0712345678', 'samuel.otieno@greenvalley.co.ke'),
('Dr. Amina', 'Mohamed', 'Pediatrician', '0723456789', 'amina.mohamed@greenvalley.co.ke'),
('Dr. David', 'Karanja', 'Cardiologist', '0734567890', 'david.karanja@greenvalley.co.ke'),
('Dr. Fatuma', 'Ali', 'Dermatologist', '0745678901', 'fatuma.ali@greenvalley.co.ke'),
('Dr. John', 'Kamau', 'Orthopedic Surgeon', '0756789012', 'john.kamau@greenvalley.co.ke');

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2026-10-11 09:00:00', 'Completed'),
(2, 2, '2026-10-11 10:00:00', 'Completed'),
(3, 3, '2026-10-12 11:30:00', 'Completed'),
(4, 4, '2026-10-12 14:00:00', 'Completed'),
(5, 5, '2026-10-13 09:15:00', 'Completed'),
(6, 1, '2026-10-13 11:00:00', 'Completed'),
(7, 2, '2026-10-14 08:30:00', 'Completed'),
(8, 3, '2026-10-14 15:00:00', 'Scheduled'),
(9, 4, '2026-10-15 10:00:00', 'Scheduled'),
(10, 5, '2026-10-15 13:00:00', 'Scheduled'),
(1, 2, '2026-10-16 09:30:00', 'Scheduled'),
(2, 3, '2026-10-16 11:00:00', 'Scheduled'),
(3, 4, '2026-10-17 14:30:00', 'Scheduled'),
(4, 5, '2026-10-18 10:00:00', 'Scheduled'),
(5, 1, '2026-10-19 12:00:00', 'Scheduled');

INSERT INTO Treatments (appointment_id, treatment_name, description, cost) VALUES
(1, 'General Consultation', 'Initial checkup and symptom review', 1500.00),
(2, 'Pediatric Checkup', 'Routine child health and immunization check', 2000.00),
(3, 'ECG Test', 'Heart electrical activity tracking', 3500.00),
(4, 'Skin Biopsy', 'Dermatological tissue sample analysis', 4000.00),
(5, 'X-Ray Knee', 'Imaging for joint pain evaluation', 3000.00),
(6, 'Malaria Test & Prescription', 'Blood smear test and anti-malarial medication', 1200.00),
(7, 'Flu Vaccine', 'Seasonal influenza immunization', 1800.00),
(8, 'Echocardiogram', 'Ultrasound of heart muscles', 5500.00),
(9, 'Allergy Testing', 'Scratch test for common environmental allergies', 4500.00),
(10, 'Physiotherapy Consultation', 'Assessment for back posture alignment', 2500.00),
(11, 'Growth Monitoring', 'Infant nutrition and weight check', 1000.00),
(12, 'Blood Pressure Monitoring', 'Hypertension screening and review', 800.00),
(13, 'Acne Treatment Therapy', 'Topical treatment session and prescription', 2200.00),
(14, 'Joint Cast Application', 'Support cast placement for sprain', 5000.00),
(15, 'General Consultation', 'Follow-up health review', 1500.00);

INSERT INTO Payments (appointment_id, amount_paid, payment_date, payment_method) VALUES
(1, 1500.00, '2026-10-11 09:45:00', 'M-Pesa'),
(2, 2000.00, '2026-10-11 10:45:00', 'Cash'),
(3, 3500.00, '2026-10-12 12:15:00', 'Insurance'),
(4, 4000.00, '2026-10-12 14:50:00', 'M-Pesa'),
(5, 3000.00, '2026-10-13 10:00:00', 'Cash'),
(6, 1200.00, '2026-10-13 11:45:00', 'M-Pesa'),
(7, 1800.00, '2026-10-14 09:15:00', 'Insurance'),
(8, 5500.00, '2026-10-14 15:45:00', 'M-Pesa'),
(9, 4500.00, '2026-10-15 10:45:00', 'Cash'),
(10, 2500.00, '2026-10-15 13:50:00', 'M-Pesa'),
(11, 1000.00, '2026-10-16 10:15:00', 'Cash'),
(12, 800.00, '2026-10-16 11:45:00', 'M-Pesa'),
(13, 2200.00, '2026-10-17 15:15:00', 'Insurance'),
(14, 5000.00, '2026-10-18 10:45:00', 'M-Pesa'),
(15, 1500.00, '2026-10-19 12:45:00', 'Cash');

BEGIN TRANSACTION;
UPDATE Appointments SET status = 'Completed' WHERE appointment_id = 5;
INSERT INTO Payments (appointment_id, amount_paid, payment_date, payment_method) 
VALUES (5, 3000.00, CURRENT_TIMESTAMP, 'Cash');
COMMIT;

BEGIN TRANSACTION;
UPDATE Appointments SET status = 'Completed' WHERE appointment_id = 5;
ROLLBACK;