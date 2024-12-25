SET NAMES 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
-- ใช้งานฐานข้อมูล
USE easyroom;

-- ตารางสำหรับเก็บข้อมูลผู้ใช้
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_number VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') DEFAULT 'user',
    full_name VARCHAR(100) NOT NULL,
    year INT DEFAULT 1,
    student_id VARCHAR(20) UNIQUE,
    major VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- เพิ่มข้อมูลผู้ใช้ใหม่
INSERT INTO users (id_number, password, role, full_name, year, student_id, major)
VALUES 
('65310000', SHA2('123', 256), 'user', 'นาย ปัญญากร ทีมจันทึก', 3, '65310000', 'วิทยาการคอมพิวเตอร์'),
('65310001', SHA2('123456', 256), 'user', 'นาย สมชาย ใจดี', 2, '65310001', 'เทคโนโลยีสารสนเทศ');



-- ตารางสำหรับเก็บห้อง
CREATE TABLE rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    room_name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL CHECK (capacity >= 0),
    description TEXT
);

-- ตัวอย่างข้อมูลห้อง
INSERT INTO rooms (room_name, capacity, description) VALUES
('SC2-211', 150, 'ห้องเรียนบรรยาย (ความจุ 150 คน)'),
('SC2-212', 192, 'ห้องเรียนบรรยาย (ความจุ 192 คน)'),
('SC2-307', 80, 'ห้องปฏิบัติการคอมพิวเตอร์ (ความจุ 80 คน)'),
('SC2-308', 60, 'ห้องปฏิบัติการคอมพิวเตอร์ (Cisco) (ความจุ 60 คน)'),
('SC2-311', 20, 'ห้องค้นคว้าป.ตรี (ความจุ 20 คน)'),
('SC2-313', 0, 'ห้องมัลติมีเดีย (ความจุ 0 คน)'),
('SC2-313-1', 10, 'ห้องเรียนบรรยาย (ความจุ 10 คน)'),
('SC2-314', 10, 'ห้องเรียนบรรยาย (ความจุ 10 คน)'),
('SC2-407', 0, 'ห้องประชุมภาควิชา'),
('SC2-411', 0, 'ห้องสตูดิโอ'),
('SC2-414', 70, 'ห้องปฏิบัติการคอมพิวเตอร์ (ความจุ 70 คน)');

-- ตารางสำหรับเก็บข้อมูลการจองห้อง
CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    room_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    purpose TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (room_id) REFERENCES rooms(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT chk_time CHECK (start_time < end_time)
);

-- ตัวอย่างข้อมูลการจอง
INSERT INTO reservations (user_id, room_id, start_time, end_time, purpose) VALUES
(1, 1, '2024-12-23 08:00:00', '2024-12-23 10:00:00', 'การเรียนการสอน'),
(2, 2, '2024-12-24 09:00:00', '2024-12-24 11:00:00', 'การประชุมทีม');

CREATE TABLE room_schedule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    `08-09` VARCHAR(255) DEFAULT NULL,
    `09-10` VARCHAR(255) DEFAULT NULL,
    `10-11` VARCHAR(255) DEFAULT NULL,
    `11-12` VARCHAR(255) DEFAULT NULL,
    `12-13` VARCHAR(255) DEFAULT NULL,
    `13-14` VARCHAR(255) DEFAULT NULL,
    `14-15` VARCHAR(255) DEFAULT NULL,
    `15-16` VARCHAR(255) DEFAULT NULL,
    `16-17` VARCHAR(255) DEFAULT NULL
);


