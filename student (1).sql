-- ======================================
-- 1. Drop Old Tables (Correct Order)
-- ======================================
-- ======================================
-- 2. Create Tables
-- ======================================

-- Learners Table (Students की जगह)
CREATE TABLE Learners (
    learner_id INT PRIMARY KEY AUTO_INCREMENT,  -- MySQL
    -- PostgreSQL: learner_id SERIAL PRIMARY KEY
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    age INT,
    program VARCHAR(50)
);

-- Subjects Table (Courses की जगह)
CREATE TABLE Subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,  -- MySQL
    -- PostgreSQL: subject_id SERIAL PRIMARY KEY
    subject_name VARCHAR(100) NOT NULL,
    credit_hours INT
);

-- Registrations Table (Enrollments की जगह)
CREATE TABLE Registrations (
    reg_id INT PRIMARY KEY AUTO_INCREMENT,  -- MySQL
    -- PostgreSQL: reg_id SERIAL PRIMARY KEY
    learner_id INT,
    subject_id INT,
    marks DECIMAL(5,2),
    FOREIGN KEY (learner_id) REFERENCES Learners(learner_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- ======================================
-- 3. Insert Sample Data
-- ======================================

-- Learners
INSERT INTO Learners (first_name, last_name, age, program) VALUES
('Amit', 'Sharma', 20, 'B.Tech CS'),
('Neha', 'Verma', 21, 'B.Sc Maths'),
('Ravi', 'Kumar', 22, 'B.Sc Physics'),
('Pooja', 'Singh', 23, 'B.Tech CS');

-- Subjects
INSERT INTO Subjects (subject_name, credit_hours) VALUES
('Databases', 3),
('Algebra', 4),
('Mechanics', 3);

-- Registrations
INSERT INTO Registrations (learner_id, subject_id, marks) VALUES
(1, 1, 85.50),  -- Amit -> Databases
(1, 2, 90.00),  -- Amit -> Algebra
(2, 2, 70.00),  -- Neha -> Algebra
(3, 3, 88.00),  -- Ravi -> Mechanics
(4, 1, 76.00);  -- Pooja -> Databases

-- ======================================
-- 4. Example Queries
-- ======================================

-- Q1. All learners in "Databases"
SELECT l.first_name, l.last_name
FROM Learners l
JOIN Registrations r ON l.learner_id = r.learner_id
JOIN Subjects s ON r.subject_id = s.subject_id
WHERE s.subject_name = 'Databases';

-- Q2. Average marks per subject
SELECT s.subject_name, ROUND(AVG(r.marks),2) AS avg_marks
FROM Subjects s
JOIN Registrations r ON s.subject_id = r.subject_id
GROUP BY s.subject_name;

-- Q3. Subjects taken by Amit
SELECT s.subject_name, r.marks
FROM Learners l
JOIN Registrations r ON l.learner_id = r.learner_id
JOIN Subjects s ON r.subject_id = s.subject_id
WHERE l.first_name = 'Amit';

-- Q4. Number of learners in each subject
SELECT s.subject_name, COUNT(r.learner_id) AS num_learners
FROM Subjects s
LEFT JOIN Registrations r ON s.subject_id = r.subject_id
GROUP BY s.subject_name;