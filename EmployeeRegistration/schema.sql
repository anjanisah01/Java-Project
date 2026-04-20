-- ============================================================
--  Employee Registration App — MySQL Database Setup
--  Run this script ONCE in MySQL Workbench or MySQL CLI:
--    mysql -u root -p < schema.sql
-- ============================================================

-- 1. Create & select the database
CREATE DATABASE IF NOT EXISTS employee_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE employee_db;

-- 2. Create the employee table
CREATE TABLE IF NOT EXISTS employee (
    id          INT          NOT NULL AUTO_INCREMENT,
    name        VARCHAR(100) NOT NULL,
    email       VARCHAR(150) NOT NULL UNIQUE,
    phone       VARCHAR(15)  NOT NULL,
    department  VARCHAR(60)  NOT NULL,
    salary      DOUBLE       NOT NULL DEFAULT 0,
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    INDEX idx_email      (email),
    INDEX idx_department (department)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Optional: insert sample data for testing
INSERT INTO employee (name, email, phone, department, salary) VALUES
    ('Priya Sharma',    'priya.sharma@company.com',   '9876543210', 'Engineering',    75000),
    ('Rahul Mehta',     'rahul.mehta@company.com',    '9123456780', 'Finance',         62000),
    ('Ananya Iyer',     'ananya.iyer@company.com',    '9345678901', 'Human Resources', 55000),
    ('Karan Singh',     'karan.singh@company.com',    '9456789012', 'Marketing',       68000),
    ('Sneha Patil',     'sneha.patil@company.com',    '9567890123', 'Operations',      59000);

-- Verify
SELECT * FROM employee;
