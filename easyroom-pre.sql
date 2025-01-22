SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';

CREATE DATABASE easyroom_pre;
-- ใช้งานฐานข้อมูล
USE easyroom_pre;

CREATE TABLE `Student_information` (
  `Student_ID` varchar(8) PRIMARY KEY,
  `Name` varchar(100),
  `Department` varchar(100),
  `Faculty` varchar(100),
  `Academic_year` int,
  `email` varchar(100),
  `Phone_number` varchar(10),
  `Status` enum('นิสิต')
);

CREATE TABLE `Teacher_information` (
  `Teacher_ID` varchar(8) PRIMARY KEY,
  `Name` varchar(100),
  `Department` varchar(100),
  `Faculty` varchar(100),
  `email` varchar(100),
  `Phone_number` varchar(10),
  `Status` enum('อาจารย์')
);

CREATE TABLE `Rooms_list_information` (
  `Rooms_ID` varchar(6) PRIMARY KEY,
  `Rooms_name` varchar(10),
  `Floors` enum('2', '3', '4'),
  `Room_types` enum('ห้องปฎิบัติการ', 'ห้องเลคเชอร์')
);

CREATE TABLE `Equipments_list_information` (
  `Equipments_ID` int PRIMARY KEY,
  `Equipments_name` varchar(100),
  `Equipments_amount` int
);

CREATE TABLE `Rooms_list_requests` (
  `Rooms_requests_ID` int PRIMARY KEY,
  `Submitted_time` datetime,
  `Rooms_ID` varchar(6),
  `Used_date` date,
  `Identify_ID` varchar(8),
  `Start_time` time,
  `End_time` time,
  `Reason` enum('ขอใช้ห้องเพื่อติวหนังสือ','ขอใช้ห้องเพื่อประชุมงานกลุ่ม', 'ขอใช้ห้องเพื่อจัดกิจกรรมเสริมความรู้'),
  `Requests_status` enum('อนุมัติ', 'ไม่อนุมัติ'),
  `Requests_types` enum('ในเวลา', 'นอกเวลา')
);

CREATE TABLE `Name_list_requests_rooms` (
  `Rooms_requests_ID` int,
  `Identify_ID` varchar(8),
  PRIMARY KEY (`Rooms_requests_ID`, `Identify_ID`)
);

CREATE TABLE `Equipments_list_requests` (
  `Rooms_requests_ID` int,
  `Equipments_ID` int,
  `Equipments_amount` int,
  PRIMARY KEY (`Rooms_requests_ID`, `Equipments_ID`)
);

CREATE TABLE `Equipments_list_brokened` (
  `Repair_numbers` varchar(12) PRIMARY KEY,
  `Repair_date` datetime,
  `Identify_ID` varchar(8),
  `Rooms_ID` varchar(6),
  `Equipments_ID` int,
  `Repair_person_name` varchar(100),
  `Repair_status` enum('รอซ่อม', 'รับเรื่องแล้ว', 'กำลังจัดซื้อ', 'กำลังซ่อม', 'ซ่อมสำเร็จ'),
  `Damaged_details` enum('สายไฟชำรุด', 'ขาเก้าอี้หัก', 'หน้าจอไม่ติด')
);

CREATE TABLE `Schedule_time` (
  `Schedule_ID` int PRIMARY KEY,
  `Rooms_ID` varchar(6),
  `Week_days` enum('จันทร์', 'อังคาร', 'พุธ', 'พฤหัสบดี', 'ศุกร์', 'เสาร์', 'อาทิตย์'),
  `Start_time` time,
  `End_time` time,
  `Rooms_status` enum('ว่าง', 'ไม่ว่าง', 'มีเรียน', 'กำลังปรับปรุง')
);

CREATE TABLE `Manage_computers` (
  `Computer_ID` int,
  `Rooms_ID` varchar(6),
  `Computer_status` enum('ใช้งานได้', 'ใช้งานไม่ได้'),
  PRIMARY KEY (`Computer_ID`, `Rooms_ID`)
);

CREATE TABLE `Manage_equipments` (
  `Equipments_ID` int,
  `Rooms_ID` varchar(6),
  `Equipments_amount` int,
  PRIMARY KEY (`Equipments_ID`, `Rooms_ID`)
);

ALTER TABLE `Rooms_list_requests` ADD FOREIGN KEY (`Rooms_ID`) REFERENCES `Rooms_list_information` (`Rooms_ID`);

ALTER TABLE `Rooms_list_requests` ADD FOREIGN KEY (`Identify_ID`) REFERENCES `Student_information` (`Student_ID`);

ALTER TABLE `Rooms_list_requests` ADD FOREIGN KEY (`Identify_ID`) REFERENCES `Teacher_information` (`Teacher_ID`);

ALTER TABLE `Name_list_requests_rooms` ADD FOREIGN KEY (`Rooms_requests_ID`) REFERENCES `Rooms_list_requests` (`Rooms_requests_ID`);

ALTER TABLE `Name_list_requests_rooms` ADD FOREIGN KEY (`Identify_ID`) REFERENCES `Student_information` (`Student_ID`);

ALTER TABLE `Name_list_requests_rooms` ADD FOREIGN KEY (`Identify_ID`) REFERENCES `Teacher_information` (`Teacher_ID`);

ALTER TABLE `Equipments_list_requests` ADD FOREIGN KEY (`Rooms_requests_ID`) REFERENCES `Rooms_list_requests` (`Rooms_requests_ID`);

ALTER TABLE `Equipments_list_requests` ADD FOREIGN KEY (`Equipments_ID`) REFERENCES `Equipments_list_information` (`Equipments_ID`);

ALTER TABLE `Schedule_time` ADD FOREIGN KEY (`Rooms_ID`) REFERENCES `Rooms_list_information` (`Rooms_ID`);

-- ALTER TABLE `Schedule_time` ADD FOREIGN KEY (`Start_time`) REFERENCES `Rooms_list_requests` (`Start_time`);

-- ALTER TABLE `Schedule_time` ADD FOREIGN KEY (`End_time`) REFERENCES `Rooms_list_requests` (`End_time`);

ALTER TABLE `Equipments_list_brokened` ADD FOREIGN KEY (`Rooms_ID`) REFERENCES `Rooms_list_information` (`Rooms_ID`);

ALTER TABLE `Equipments_list_brokened` ADD FOREIGN KEY (`Equipments_ID`) REFERENCES `Equipments_list_information` (`Equipments_ID`);

ALTER TABLE `Equipments_list_brokened` ADD FOREIGN KEY (`Identify_ID`) REFERENCES `Student_information` (`Student_ID`);

ALTER TABLE `Equipments_list_brokened` ADD FOREIGN KEY (`Identify_ID`) REFERENCES `Teacher_information` (`Teacher_ID`);

ALTER TABLE `Manage_computers` ADD FOREIGN KEY (`Rooms_ID`) REFERENCES `Rooms_list_information` (`Rooms_ID`);

ALTER TABLE `Manage_equipments` ADD FOREIGN KEY (`Equipments_ID`) REFERENCES `Equipments_list_information` (`Equipments_ID`);

ALTER TABLE `Manage_equipments` ADD FOREIGN KEY (`Rooms_ID`) REFERENCES `Rooms_list_information` (`Rooms_ID`);