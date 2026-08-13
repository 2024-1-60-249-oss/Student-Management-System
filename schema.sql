CREATE DATABASE IF NOT EXISTS student_management_db;
USE student_management_db;

CREATE TABLE DEPARTMENTS (
    Department_ID INT AUTO_INCREMENT PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL,
    Department_Code VARCHAR(20) NOT NULL
);

CREATE TABLE STUDENTS (
    Student_ID INT AUTO_INCREMENT PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    Date_of_Birth DATE,
    Gender VARCHAR(10),
    Blood_Group VARCHAR(10),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address TEXT,
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENTS(Department_ID) ON DELETE SET NULL
);

CREATE TABLE FACULTIES (
    Faculty_ID INT AUTO_INCREMENT PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Designation VARCHAR(50),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENTS(Department_ID) ON DELETE SET NULL
);

CREATE TABLE COURSES (
    Course_ID INT AUTO_INCREMENT PRIMARY KEY,
    Course_Code VARCHAR(20) NOT NULL,
    Course_Name VARCHAR(100) NOT NULL,
    Credit INT NOT NULL,
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES DEPARTMENTS(Department_ID) ON DELETE SET NULL
);

CREATE TABLE ENROLLMENTS (
    Enrollment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Student_ID INT,
    Course_ID INT,
    Semester VARCHAR(20),
    Section VARCHAR(10),
    Faculty_ID INT,
    FOREIGN KEY (Student_ID) REFERENCES STUDENTS(Student_ID) ON DELETE CASCADE,
    FOREIGN KEY (Course_ID) REFERENCES COURSES(Course_ID) ON DELETE CASCADE,
    FOREIGN KEY (Faculty_ID) REFERENCES FACULTIES(Faculty_ID) ON DELETE SET NULL
);

CREATE TABLE RESULTS (
    Result_ID INT AUTO_INCREMENT PRIMARY KEY,
    Enrollment_ID INT UNIQUE,
    Grade VARCHAR(5),
    GPA DECIMAL(3,2),
    FOREIGN KEY (Enrollment_ID) REFERENCES ENROLLMENTS(Enrollment_ID) ON DELETE CASCADE
);

CREATE TABLE USERS (
    User_ID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Role ENUM('Admin', 'Student') NOT NULL,
    Student_ID INT NULL,
    FOREIGN KEY (Student_ID) REFERENCES STUDENTS(Student_ID) ON DELETE CASCADE
);

INSERT INTO DEPARTMENTS (Department_Name, Department_Code) VALUES 
('Computer Science & Engineering', 'CSE'),
('Electrical & Electronic Engineering', 'EEE');

INSERT INTO STUDENTS (Student_ID,Full_Name, Date_of_Birth, Gender, Blood_Group, Phone, Email, Address, Department_ID) VALUES 
(2024160029,'Somiya Akter MUNNI', '2005-12-17', 'Female', 'B+', '01711111111', '2024-160-029@std.ewubd.edu', 'Dhaka, Bangladesh', 1);

INSERT INTO USERS (Username, Password, Role, Student_ID) VALUES 
('admin', 'admin123', 'Admin', NULL),
('somiya', '123', 'Student',2024160029);