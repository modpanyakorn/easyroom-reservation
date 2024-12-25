<?php
// ตั้งค่าการเชื่อมต่อฐานข้อมูล
include('db_connect.php');
// คำนวณวันที่เริ่มต้นและวันที่สิ้นสุดของสัปดาห์จากวันที่ที่เลือก
$selected_date = $_GET['search_date'] ?? date('Y-m-d'); // หากไม่มีการเลือกวันที่ ก็ใช้วันที่ปัจจุบัน
$start_of_week = date('Y-m-d', strtotime('last Sunday', strtotime($selected_date))); // วันที่เริ่มต้นของสัปดาห์
$end_of_week = date('Y-m-d', strtotime('next Saturday', strtotime($selected_date))); // วันที่สิ้นสุดของสัปดาห์

// สร้างตารางวันที่ในสัปดาห์นั้น
$dates_in_week = [];
for ($i = 0; $i < 7; $i++) {
    $dates_in_week[] = date('Y-m-d', strtotime("+$i days", strtotime($start_of_week)));
}

// ดึงข้อมูลจากฐานข้อมูลตามวันที่ในสัปดาห์
$mysqli = new mysqli("localhost", "root", "", "easyroom");

if ($mysqli->connect_error) {
    die("Connection failed: " . $mysqli->connect_error);
}

$query = "SELECT * FROM room_schedule WHERE date BETWEEN '$start_of_week' AND '$end_of_week' ORDER BY date";
$result = $mysqli->query($query);

$schedules = [];
while ($row = $result->fetch_assoc()) {
    $schedules[] = $row;
}

$mysqli->close();
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ตารางการใช้ห้อง</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        .header {
            background-color: #ff5722;
            color: white;
            padding: 10px 20px;
            display: flex;
            justify-content: flex-start;
            /* ทำให้เนื้อหาชิดซ้าย */
            align-items: center;
        }


        .header h1 {
            font-size: 1.5em;
            margin: 0;
            text-align: left;
            /* เพิ่มการจัดตำแหน่งให้ชิดซ้าย */
        }

        .container {
            padding: 20px;
        }

        .filters {
            margin-bottom: 20px;
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .filters input,
        .filters button {
            padding: 5px;
            font-size: 1em;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table th,
        table td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 10px;
        }

        table th {
            background-color: #673ab7;
            color: white;
        }

        table tr.highlight {
            background-color: #ffeb3b;
        }

        .btn-confirm {
            display: block;
            margin: 20px auto;
            background-color: #ff5722;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 1em;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn-confirm:hover {
            background-color: #e64a19;
        }
    </style>
</head>

<body>
    <div class="header">
        <a href="#">&#8592;</a>
        <h1>ตารางการใช้ห้อง</h1>
    </div>

    <div class="container">
        <form method="GET" action="">
            <div class="filters">
                <label for="room">ห้อง:</label>
                <div class="room-option">
                    SC2-308 - ห้องปฏิบัติการคอมพิวเตอร์ (ความจุ 80 คน)
                </div>

                <label for="date-range">ระหว่างวันที่-วันที่:</label>
                <input type="date" name="start_date" value="<?= $_GET['start_date'] ?? '2024-12-22' ?>">
                <input type="date" name="end_date" value="<?= $_GET['end_date'] ?? '2024-12-28' ?>">

                <label for="search-date">เลือกวันที่:</label>
                <input type="date" name="search_date" value="<?= $_GET['search_date'] ?? '' ?>">
                <button type="submit">ค้นหา</button>
            </div>
        </form>

        <table id="calendar-table">
            <thead>
                <tr>
                    <th>วัน</th>
                    <th>08.00-09.00</th>
                    <th>09.00-10.00</th>
                    <th>10.00-11.00</th>
                    <th>11.00-12.00</th>
                    <th>12.00-13.00</th>
                    <th>13.00-14.00</th>
                    <th>14.00-15.00</th>
                    <th>15.00-16.00</th>
                    <th>16.00-17.00</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($schedules)): ?>
                    <?php foreach ($schedules as $schedule): ?>
                        <tr>
                            <td><?= date("d/m/Y", strtotime($schedule['date'])) ?></td>
                            <td><?= $schedule['08-09'] ?? '' ?></td>
                            <td><?= $schedule['09-10'] ?? '' ?></td>
                            <td><?= $schedule['10-11'] ?? '' ?></td>
                            <td><?= $schedule['11-12'] ?? '' ?></td>
                            <td><?= $schedule['12-13'] ?? '' ?></td>
                            <td><?= $schedule['13-14'] ?? '' ?></td>
                            <td><?= $schedule['14-15'] ?? '' ?></td>
                            <td><?= $schedule['15-16'] ?? '' ?></td>
                            <td><?= $schedule['16-17'] ?? '' ?></td>
                        </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="10">ไม่มีข้อมูลการใช้งาน</td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>

        <button type="submit" name="confirm_booking" class="btn-confirm">ยืนยัน</button>

    </div>
</body>

</html>