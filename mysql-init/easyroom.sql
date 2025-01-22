-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: easyroomhost
-- Generation Time: Jan 21, 2025 at 05:54 PM
-- Server version: 9.1.0
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `easyroom`
--

-- --------------------------------------------------------

--
-- Table structure for table `borrow_items`
--

CREATE TABLE `borrow_items` (
  `id` int NOT NULL,
  `console` int DEFAULT NULL,
  `cat5` int DEFAULT NULL,
  `crossover` int DEFAULT NULL,
  `hub` int DEFAULT NULL,
  `router` int DEFAULT NULL,
  `switch` int DEFAULT NULL,
  `pointer` int DEFAULT NULL,
  `microphone` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `desk_status`
--

CREATE TABLE `desk_status` (
  `desk_id` int NOT NULL,
  `status` enum('ว่าง','ไม่ว่าง') DEFAULT 'ว่าง'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `issue_reports`
--

CREATE TABLE `issue_reports` (
  `id` int NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `reciver` varchar(255) DEFAULT NULL,
  `timereport` datetime DEFAULT NULL,
  `user_id` int NOT NULL,
  `equipment` varchar(255) NOT NULL,
  `room` varchar(255) NOT NULL,
  `details` text,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `issue_reports`
--

INSERT INTO `issue_reports` (`id`, `status`, `reciver`, `timereport`, `user_id`, `equipment`, `room`, `details`, `image_path`, `created_at`) VALUES
(10, 'รอดำเนินการ', 'นายยุทธพงษ์', '2025-01-20 10:30:00', 1, 'โปรเจคเตอร์', 'SC2-414', 'ภาพไม่ชัดเบลอ', NULL, '2025-01-21 14:16:45'),
(11, 'กำลังดำเนินการ', 'นายยุทธพงษ์', '2025-01-20 11:15:00', 1, 'เครื่องปรับอากาศ', 'SC2-414', 'ไม่มีความเย็น', NULL, '2025-01-21 14:16:45'),
(12, 'ซ่อมเสร็จแล้ว', 'นายธราศักดิ์', '2025-01-19 15:40:00', 2, 'จอคอมพิวเตอร์', 'SC2-408', 'หน้าจอไม่ติด', NULL, '2025-01-21 14:16:45');

-- --------------------------------------------------------

--
-- Table structure for table `lectures`
--

CREATE TABLE `lectures` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `room_id` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `subject` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `lectures`
--

INSERT INTO `lectures` (`id`, `user_id`, `room_id`, `start_time`, `end_time`, `subject`, `created_at`) VALUES
(1, 3, 4, '2024-12-22 08:00:00', '2024-12-22 10:00:00', 'วิชาเทคโนโลยีคอมพิวเตอร์', '2025-01-21 11:29:59'),
(2, 3, 4, '2024-12-22 10:00:00', '2024-12-22 12:00:00', 'วิชาการออกแบบซอฟต์แวร์', '2025-01-21 11:29:59'),
(3, 3, 4, '2024-12-23 08:00:00', '2024-12-23 10:00:00', 'วิชาคณิตศาสตร์เบื้องต้น', '2025-01-21 11:29:59'),
(4, 3, 4, '2024-12-23 10:00:00', '2024-12-23 12:00:00', 'วิชาภาษาอังกฤษธุรกิจ', '2025-01-21 11:29:59'),
(5, 3, 4, '2024-12-23 13:00:00', '2024-12-23 15:00:00', 'วิชาการออกแบบฐานข้อมูล', '2025-01-21 11:29:59'),
(6, 3, 4, '2024-12-24 08:00:00', '2024-12-24 10:00:00', 'วิชาเทคโนโลยีคอมพิวเตอร์', '2025-01-21 11:29:59'),
(7, 3, 4, '2024-12-24 10:00:00', '2024-12-24 12:00:00', 'วิชาการออกแบบซอฟต์แวร์', '2025-01-21 11:29:59'),
(8, 3, 4, '2024-12-24 13:00:00', '2024-12-24 15:00:00', 'วิชาภาษาอังกฤษธุรกิจ', '2025-01-21 11:29:59'),
(9, 3, 4, '2024-12-25 08:00:00', '2024-12-25 10:00:00', 'วิชาคณิตศาสตร์เบื้องต้น', '2025-01-21 11:29:59'),
(10, 3, 4, '2024-12-25 10:00:00', '2024-12-25 12:00:00', 'วิชาการออกแบบฐานข้อมูล', '2025-01-21 11:29:59'),
(11, 3, 4, '2024-12-25 13:00:00', '2024-12-25 15:00:00', 'วิชาภาษาไทย', '2025-01-21 11:29:59'),
(12, 3, 4, '2024-12-26 08:00:00', '2024-12-26 10:00:00', 'วิชาเทคโนโลยีคอมพิวเตอร์', '2025-01-21 11:29:59'),
(13, 3, 4, '2024-12-26 10:00:00', '2024-12-26 12:00:00', 'วิชาการออกแบบซอฟต์แวร์', '2025-01-21 11:29:59'),
(14, 3, 4, '2024-12-26 13:00:00', '2024-12-26 15:00:00', 'วิชาการออกแบบฐานข้อมูล', '2025-01-21 11:29:59'),
(15, 3, 4, '2024-12-27 08:00:00', '2024-12-27 10:00:00', 'วิชาคณิตศาสตร์เบื้องต้น', '2025-01-21 11:29:59'),
(16, 3, 4, '2024-12-27 10:00:00', '2024-12-27 12:00:00', 'วิชาภาษาอังกฤษธุรกิจ', '2025-01-21 11:29:59'),
(17, 3, 4, '2024-12-27 13:00:00', '2024-12-27 15:00:00', 'วิชาภาษาไทย', '2025-01-21 11:29:59'),
(18, 3, 4, '2024-12-28 08:00:00', '2024-12-28 10:00:00', 'วิชาการออกแบบซอฟต์แวร์', '2025-01-21 11:29:59'),
(19, 3, 4, '2024-12-28 10:00:00', '2024-12-28 12:00:00', 'วิชาคณิตศาสตร์เบื้องต้น', '2025-01-21 11:29:59'),
(20, 3, 4, '2024-12-28 13:00:00', '2024-12-28 15:00:00', 'วิชาภาษาอังกฤษธุรกิจ', '2025-01-21 11:29:59');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

CREATE TABLE `reservations` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `room_id` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `purpose` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`id`, `user_id`, `room_id`, `start_time`, `end_time`, `purpose`, `created_at`) VALUES
(1, 1, 3, '2024-12-26 14:00:11', '2024-12-26 17:00:00', 'ขอใช้ห้อง', '2024-12-26 02:30:37'),
(65310001, 1, 4, '2024-12-25 19:30:36', '2024-12-25 20:30:36', 'ประชุมทีม', '2024-12-26 02:30:37');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int NOT NULL,
  `room_name` varchar(50) NOT NULL,
  `capacity` int NOT NULL,
  `description` text
) ;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_name`, `capacity`, `description`) VALUES
(1, 'SC2-211', 150, 'ห้องเรียนบรรยาย (ความจุ 150 คน)'),
(2, 'SC2-212', 192, 'ห้องเรียนบรรยาย (ความจุ 192 คน)'),
(3, 'SC2-307', 80, 'ห้องปฏิบัติการคอมพิวเตอร์ (ความจุ 80 คน)'),
(4, 'SC2-308', 60, 'ห้องปฏิบัติการคอมพิวเตอร์ (Cisco) (ความจุ 60 คน)'),
(5, 'SC2-311', 20, 'ห้องค้นคว้าป.ตรี (ความจุ 20 คน)'),
(6, 'SC2-313', 0, 'ห้องมัลติมีเดีย (ความจุ 0 คน)'),
(7, 'SC2-313-1', 10, 'ห้องเรียนบรรยาย (ความจุ 10 คน)'),
(8, 'SC2-314', 10, 'ห้องเรียนบรรยาย (ความจุ 10 คน)'),
(9, 'SC2-407', 0, 'ห้องประชุมภาควิชา'),
(10, 'SC2-411', 0, 'ห้องสตูดิโอ'),
(11, 'SC2-414', 70, 'ห้องปฏิบัติการคอมพิวเตอร์ (ความจุ 70 คน)');

-- --------------------------------------------------------

--
-- Table structure for table `room_schedule`
--

CREATE TABLE `room_schedule` (
  `id` int NOT NULL,
  `date` date NOT NULL,
  `08-09` varchar(255) DEFAULT NULL,
  `09-10` varchar(255) DEFAULT NULL,
  `10-11` varchar(255) DEFAULT NULL,
  `11-12` varchar(255) DEFAULT NULL,
  `12-13` varchar(255) DEFAULT NULL,
  `13-14` varchar(255) DEFAULT NULL,
  `14-15` varchar(255) DEFAULT NULL,
  `15-16` varchar(255) DEFAULT NULL,
  `16-17` varchar(255) DEFAULT NULL,
  `17-18` varchar(255) DEFAULT NULL,
  `18-19` varchar(255) DEFAULT NULL,
  `19-20` varchar(255) DEFAULT NULL,
  `20-21` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `id_number` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','user','teacher') DEFAULT 'user',
  `full_name` varchar(100) NOT NULL,
  `year` int DEFAULT '1',
  `student_id` varchar(20) DEFAULT NULL,
  `major` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `id_number`, `password`, `role`, `full_name`, `year`, `student_id`, `major`, `created_at`) VALUES
(1, '65310000', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'user', 'นาย ปัญญากร ทีมจันทึก', 3, '65310000', 'วิทยาการคอมพิวเตอร์', '2025-01-21 11:29:59'),
(2, '123456', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'admin', 'นาย สมชาย ใจดี', 2, '123456', 'เจ้าหน้าที่ดูแล', '2025-01-21 11:29:59'),
(3, '12345', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', 'teacher', 'นางสาว นันธกร บุญมี', 2, '012345', 'อาจารย์สาขาวิทยาการคอมพิวเตอร์', '2025-01-21 11:29:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `borrow_items`
--
ALTER TABLE `borrow_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `desk_status`
--
ALTER TABLE `desk_status`
  ADD PRIMARY KEY (`desk_id`);

--
-- Indexes for table `issue_reports`
--
ALTER TABLE `issue_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `lectures`
--
ALTER TABLE `lectures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `room_schedule`
--
ALTER TABLE `room_schedule`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_number` (`id_number`),
  ADD UNIQUE KEY `student_id` (`student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `borrow_items`
--
ALTER TABLE `borrow_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `issue_reports`
--
ALTER TABLE `issue_reports`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `lectures`
--
ALTER TABLE `lectures`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `room_schedule`
--
ALTER TABLE `room_schedule`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `issue_reports`
--
ALTER TABLE `issue_reports`
  ADD CONSTRAINT `issue_reports_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `lectures`
--
ALTER TABLE `lectures`
  ADD CONSTRAINT `lectures_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lectures_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `reservations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reservations_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
