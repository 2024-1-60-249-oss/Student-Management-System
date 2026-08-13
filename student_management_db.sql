-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 13, 2026 at 07:03 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `student_management_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `Course_ID` int(11) NOT NULL,
  `Course_Code` varchar(20) NOT NULL,
  `Course_Name` varchar(100) NOT NULL,
  `Credit` int(11) NOT NULL,
  `Department_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `Department_ID` int(11) NOT NULL,
  `Department_Name` varchar(100) NOT NULL,
  `Department_Code` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`Department_ID`, `Department_Name`, `Department_Code`) VALUES
(1, 'Computer Science & Engineering', 'CSE'),
(2, 'Electrical & Electronic Engineering', 'EEE');

-- --------------------------------------------------------

--
-- Table structure for table `enrollments`
--

CREATE TABLE `enrollments` (
  `Enrollment_ID` int(11) NOT NULL,
  `Student_ID` int(11) DEFAULT NULL,
  `Course_ID` int(11) DEFAULT NULL,
  `Semester` varchar(20) DEFAULT NULL,
  `Section` varchar(10) DEFAULT NULL,
  `Faculty_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faculties`
--

CREATE TABLE `faculties` (
  `Faculty_ID` int(11) NOT NULL,
  `Full_Name` varchar(100) NOT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Designation` varchar(50) DEFAULT NULL,
  `Department_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `results`
--

CREATE TABLE `results` (
  `Result_ID` int(11) NOT NULL,
  `Enrollment_ID` int(11) DEFAULT NULL,
  `Grade` varchar(5) DEFAULT NULL,
  `GPA` decimal(3,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `Student_ID` int(11) NOT NULL,
  `Full_Name` varchar(100) NOT NULL,
  `Date_of_Birth` date DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `Blood_Group` varchar(10) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Address` text DEFAULT NULL,
  `Department_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `students`
--

INSERT INTO `students` (`Student_ID`, `Full_Name`, `Date_of_Birth`, `Gender`, `Blood_Group`, `Phone`, `Email`, `Address`, `Department_ID`) VALUES
(2023160123, 'Shohag Al Mamun Rabbi', '2003-08-14', 'Male', 'A+', '01333543021', '2023-1-60-123@std.ewubd.edu', 'Dhaka,Bangladesh', 1),
(2024160029, 'Somiya Akter munni', '2001-05-15', 'Female', 'B+', '01711111111', '2024-1-60-029@std.ewubd.edu', 'Dhaka, Bangladesh', 1),
(2024160148, 'Marjuka Noyan', '2005-07-12', 'Female', 'AB+', '01953425022', '2024-1-60-148@std.ewubd.edu', 'Dhaka,Bangladesh', 1),
(2024160249, 'Afra Aanan', '2005-05-04', 'Female', 'O+', '01715954222', '2024-1-60-249@std.ewubd.edu', 'Dhaka,Bangladesh', 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `User_ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Role` enum('Admin','Student') NOT NULL,
  `Student_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`User_ID`, `Username`, `Password`, `Role`, `Student_ID`) VALUES
(1, 'admin', 'admin123', 'Admin', NULL),
(6, 'somiya', '123', 'Student', 2024160029),
(7, 'afra', '123', 'Student', 2024160249),
(8, 'rabbi', '123', 'Student', 2023160123),
(9, 'marjuka', '123', 'Student', 2024160148);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`Course_ID`),
  ADD KEY `Department_ID` (`Department_ID`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`Department_ID`);

--
-- Indexes for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD PRIMARY KEY (`Enrollment_ID`),
  ADD KEY `Student_ID` (`Student_ID`),
  ADD KEY `Course_ID` (`Course_ID`),
  ADD KEY `Faculty_ID` (`Faculty_ID`);

--
-- Indexes for table `faculties`
--
ALTER TABLE `faculties`
  ADD PRIMARY KEY (`Faculty_ID`),
  ADD KEY `Department_ID` (`Department_ID`);

--
-- Indexes for table `results`
--
ALTER TABLE `results`
  ADD PRIMARY KEY (`Result_ID`),
  ADD UNIQUE KEY `Enrollment_ID` (`Enrollment_ID`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`Student_ID`),
  ADD KEY `Department_ID` (`Department_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`User_ID`),
  ADD UNIQUE KEY `Username` (`Username`),
  ADD KEY `Student_ID` (`Student_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `Course_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `Department_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `enrollments`
--
ALTER TABLE `enrollments`
  MODIFY `Enrollment_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faculties`
--
ALTER TABLE `faculties`
  MODIFY `Faculty_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `results`
--
ALTER TABLE `results`
  MODIFY `Result_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `Student_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2024160251;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `User_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `courses_ibfk_1` FOREIGN KEY (`Department_ID`) REFERENCES `departments` (`Department_ID`) ON DELETE SET NULL;

--
-- Constraints for table `enrollments`
--
ALTER TABLE `enrollments`
  ADD CONSTRAINT `enrollments_ibfk_1` FOREIGN KEY (`Student_ID`) REFERENCES `students` (`Student_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_2` FOREIGN KEY (`Course_ID`) REFERENCES `courses` (`Course_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `enrollments_ibfk_3` FOREIGN KEY (`Faculty_ID`) REFERENCES `faculties` (`Faculty_ID`) ON DELETE SET NULL;

--
-- Constraints for table `faculties`
--
ALTER TABLE `faculties`
  ADD CONSTRAINT `faculties_ibfk_1` FOREIGN KEY (`Department_ID`) REFERENCES `departments` (`Department_ID`) ON DELETE SET NULL;

--
-- Constraints for table `results`
--
ALTER TABLE `results`
  ADD CONSTRAINT `results_ibfk_1` FOREIGN KEY (`Enrollment_ID`) REFERENCES `enrollments` (`Enrollment_ID`) ON DELETE CASCADE;

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `students_ibfk_1` FOREIGN KEY (`Department_ID`) REFERENCES `departments` (`Department_ID`) ON DELETE SET NULL;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`Student_ID`) REFERENCES `students` (`Student_ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
