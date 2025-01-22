<?php
// เริ่มต้นเซสชั่น
session_start();
// ตั้งค่าการเชื่อมต่อฐานข้อมูล
include('db_connect.php');

// ตรวจสอบว่า session มีข้อมูลผู้ใช้หรือไม่
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php'); // ถ้ายังไม่ได้ล็อกอิน, รีไดเร็กต์ไปที่หน้า login
    exit();
}

// ดึงข้อมูลผู้ใช้งานจาก session
$user_id = $_SESSION['user_id'];
$user_query = "SELECT * FROM users WHERE id = $user_id";
$user_result = $conn->query($user_query);
$user = $user_result->fetch_assoc();

// ดึงข้อมูลการจองของผู้ใช้งาน
$reservations_query = "SELECT reservations.*, rooms.room_name FROM reservations 
                      INNER JOIN rooms ON reservations.room_id = rooms.id 
                      WHERE reservations.user_id = $user_id";
$reservations_result = $conn->query($reservations_query);

// ฟังก์ชันดึงข้อมูลของแถวจาก issue_reports
function getIssueDetails($id, $conn) {
    $id = intval($id); // ทำให้แน่ใจว่า id เป็นตัวเลข
    $query = "SELECT * FROM issue_reports WHERE id = $id";
    $result = $conn->query($query);

    if ($result && $result->num_rows > 0) {
        return $result->fetch_assoc(); // คืนค่าข้อมูลเป็น array
    } else {
        return null; // คืนค่า null ถ้าไม่มีข้อมูล
    }
}

// ตรวจสอบคำขอจาก AJAX
if (isset($_GET['get_details']) && $_GET['get_details'] === 'true' && isset($_GET['id'])) {
    $id = intval($_GET['id']);
    $details = getIssueDetails($id, $conn);

    header('Content-Type: application/json');
    if ($details) {
        echo json_encode($details);
    } else {
        echo json_encode(['error' => 'ไม่พบข้อมูล']);
    }
    exit();
}

// ดึงข้อมูลการแจ้งปัญหาทั้งหมด
$issues_query = "SELECT * FROM issue_reports WHERE user_id = $user_id ORDER BY created_at DESC";
$issues_result = $conn->query($issues_query);
$issues = [];
while ($row = $issues_result->fetch_assoc()) {
    $issues[] = $row;
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EasyRoom Reservation System - หน้าหลัก</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
        }

        .header {
            background-color: #e54715;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-title {
            font-size: 24px;
            font-weight: bold;
        }

        .nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 16px;
        }

        .nav a:hover {
            text-decoration: underline;
        }

        .nav a.active {
            font-weight: bold;
            text-decoration: underline;
        }

        .user-info {
            background-color: #ffffff;
            margin: 20px auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            max-width: 800px;
            display: flex;
            align-items: center;
        }

        .user-avatar {
            font-size: 50px;
            margin-right: 20px;
        }

        .user-details div {
            margin-bottom: 8px;
        }

        .booking-section {
            background-color: #8e44ad;
            color: white;
            margin: 20px auto;
            padding: 20px;
            border-radius: 10px;
            max-width: 800px;
        }

        .booking-section h3 {
            margin-top: 0;
            font-size: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            color: black;
            border-radius: 8px;
            overflow: hidden;
        }

        table th,
        table td {
            text-align: left;
            padding: 10px;
        }

        table th {
            background-color: #dcdde1;
            color: #2c3e50;
        }

        table tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        .status {
            color: green;
            font-weight: bold;
        }

        .cancel-btn {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        .cancel-btn:hover {
            background-color: darkred;
        }
    </style>
</head>

<body>
    <!-- Header -->
    <div class="header">
        <div class="header-title">EasyRoom Reservation System</div>
        <div class="nav">
            <a href="home.php" class="active">หน้าหลัก</a>
            <a href="booking.php">จองห้อง</a>
            <a href="repost.php">รายงาน</a>
        </div>
    </div>

    <!-- User Information Section -->
    <div class="user-info">
        <div class="user-avatar">😊</div>
        <div class="user-details">
            <div>ชื่อ นามสกุล: <?php echo $user['full_name']; ?></div>
            <div>รหัสนิสิต: <?php echo $user['id_number']; ?></div>
            <div>ชั้นปี: <?php echo $user['year']; ?></div>
            <div>สาขา: <?php echo $user['major']; ?></div>
        </div>
    </div>


    <!-- Booking Details -->
    <div class="booking-section">
        <h3>รายละเอียดการจอง</h3>
        <table>
            <thead>
                <tr>
                    <th>ประเภท</th>
                    <th>ห้องที่จอง</th>
                    <th>เวลาที่จอง</th>
                    <th>สถานะการจอง</th>
                </tr>
            </thead>
            <tbody>
                <?php while ($reservation = $reservations_result->fetch_assoc()) { ?>
                    <tr>
                        <td>ห้องปฏิบัติการ</td>
                        <td><?php echo $reservation['room_name']; ?></td>
                        <td>
                            <?php echo date('H:i', strtotime($reservation['start_time'])) . " - " . date('H:i', strtotime($reservation['end_time'])); ?>
                        </td>
                        <td>
                            <span id="status_<?php echo $reservation['id']; ?>" class="status">รอการอนุมัติ</span>
                            <button id="cancelBtn_<?php echo $reservation['id']; ?>" class="cancel-btn" onclick="cancelReservation(<?php echo $reservation['id']; ?>)">ยกเลิก</button>
                        </td>


                    </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>
<?php
$issues_query = "SELECT * FROM issue_reports WHERE user_id = $user_id ORDER BY created_at DESC";
$issues_result = $conn->query($issues_query);

if (!$issues_result) {
    // แสดงข้อผิดพลาดหาก Query ล้มเหลว
    die("เกิดข้อผิดพลาดในการดึงข้อมูล: " . $conn->error);
}

?>
    <script>
        function cancelReservation(reservationId) {
            if (confirm('คุณต้องการยกเลิกการจองนี้หรือไม่?')) {
                // เปลี่ยนสถานะเป็น "ยกเลิก"
                var statusCell = document.getElementById('status_' + reservationId);
                statusCell.innerHTML = 'ยกเลิก'; // เปลี่ยนข้อความ
                statusCell.style.color = 'red'; // เปลี่ยนสีเป็นแดง

                // ปิดการใช้งานปุ่ม "ยกเลิก"
                var cancelButton = document.getElementById('cancelBtn_' + reservationId);
                cancelButton.disabled = true; // ปิดปุ่ม
            }
        }
    </script>
    <!-- Modal Popup -->
<div id="detailsModal" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background: white; width: 50%; padding: 20px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); border-radius: 8px; z-index: 1000;">
    <h3 style="margin-top: 0;">รายละเอียดการแจ้งซ่อม</h3>
    <img id="modalImage" src="" alt="รูปภาพ" style="width: 100%; max-width: 400px; height: auto; margin-bottom: 10px; border-radius: 5px;">
    <p id="modalEquipment"></p>
    <p id="modalDetails"></p>
    <p id="modalRoom"></p>
    <p id="modalReceiver"></p>
    <p id="modalStatus"></p>
    <button onclick="closeModal()" style="padding: 10px 20px; background-color: #e54715; color: white; border: none; border-radius: 5px; cursor: pointer;">ปิด</button>
</div>
<div id="modalOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); z-index: 999;" onclick="closeModal()"></div>

<script>
    function showDetails(id) {
        // เรียก API เพื่อดึงข้อมูลของปัญหา
        fetch(`?get_details=true&id=${id}`)
            .then(response => response.json())
            .then(data => {
                if (data.error) {
                    alert(data.error); // แจ้งเตือนหากเกิดข้อผิดพลาด
                } else {
                    // ตั้งค่าข้อมูลใน Modal Popup
                    document.getElementById('modalEquipment').textContent = `ชื่ออุปกรณ์: ${data.equipment}`;
                    document.getElementById('modalDetails').textContent = `รายละเอียด: ${data.details}`;
                    document.getElementById('modalRoom').textContent = `ห้อง: ${data.room}`;
                    document.getElementById('modalReceiver').textContent = `ผู้รับแจ้งซ่อม: ${data.reciver}`;
                    document.getElementById('modalStatus').textContent = `สถานะ: ${data.status}`;
                    // ตั้งค่าแสดงรูปภาพ หากไม่มีภาพใช้ default.jpg
                    document.getElementById('modalImage').src = data.image_path ? data.image_path : 'img/blur.png';

                    // แสดง Modal
                    document.getElementById('detailsModal').style.display = 'block';
                    document.getElementById('modalOverlay').style.display = 'block';
                    
                }
            })
            .catch(error => {
                console.error('Error fetching details:', error);
                alert('เกิดข้อผิดพลาดในการดึงข้อมูล');
            });
    }

    function closeModal() {
        // ปิด Modal Popup
        document.getElementById('detailsModal').style.display = 'none';
        document.getElementById('modalOverlay').style.display = 'none';
    }
</script>
<!-- ส่วนการแสดงผล -->
<div class="booking-section">
    <h3>รายการปัญหาที่รายงาน</h3>
    <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
        <thead>
            <tr style="background-color: #f2f2f2;">
                <th style="border: 1px solid #ddd; padding: 8px;">เวลาที่แจ้งซ่อม</th>
                <th style="border: 1px solid #ddd; padding: 8px;">ชื่ออุปกรณ์</th>
                <th style="border: 1px solid #ddd; padding: 8px;">รายละเอียด</th>
                <th style="border: 1px solid #ddd; padding: 8px;">ห้อง</th>
                <th style="border: 1px solid #ddd; padding: 8px;">ผู้รับแจ้งซ่อม</th>
                <th style="border: 1px solid #ddd; padding: 8px;">สถานะ</th>
                <th style="border: 1px solid #ddd; padding: 8px;">เพิ่มเติม</th>
            </tr>
        </thead>
        <tbody>
            <?php while ($issue = $issues_result->fetch_assoc()) { ?>
                <tr>
                    <td style="border: 1px solid #ddd; padding: 8px;"><?php echo $issue['created_at']; ?></td>
                    <td style="border: 1px solid #ddd; padding: 8px;"><?php echo $issue['equipment']; ?></td>
                    <td style="border: 1px solid #ddd; padding: 8px;"><?php echo $issue['details']; ?></td>
                    <td style="border: 1px solid #ddd; padding: 8px;"><?php echo $issue['room']; ?></td>
                    <td style="border: 1px solid #ddd; padding: 8px;"><?php echo $issue['reciver']; ?></td>
                    <td style="border: 1px solid #ddd; padding: 8px;"><?php echo $issue['status']; ?></td>
                    <td style="border: 1px solid #ddd; padding: 8px;">
                    <button
                        style="padding: 5px 10px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;"
                        onclick="showDetails(<?php echo $issue['id']; ?>)">
                        ดูเพิ่มเติม
            </button>
                    </td>
                </tr>
            <?php } ?>
        </tbody>
    </table>
</div>


<!-- Modal Background Overlay -->
<div id="modalOverlay" style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 999;" onclick="closeModal()"></div>


</body>

</html>