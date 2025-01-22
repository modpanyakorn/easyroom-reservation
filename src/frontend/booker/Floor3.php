<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Floor Layout</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            height: 100vh;
            background-color: #d9c1ab;
        }

        header {
            background-color: #d9c1ab;
            padding: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-bottom: 2px solid #000;
        }

        .floor-buttons {
            display: flex;
            gap: 15px;
        }

        .floor-buttons button {
            background-color: #6c34a3;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            cursor: pointer;
            font-size: 16px;
        }

        .floor-buttons button:hover {
            background-color: #563080;
        }

        main {
            display: flex;
            flex: 1;
        }

        .layout {
            flex: 3;
            background-color: white;
            display: grid;
            grid-template-columns: repeat(12, 1fr);
            grid-template-rows: repeat(7, 1fr);
            grid-gap: 5px;
            padding: 20px;
            position: relative;
            border: 2px solid #000;
        }

        .room {
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 14px;
            text-align: center;
            border: 2px solid #000;
            border-radius: 10px;
            background-color: #ff0000;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
        }

        .room.red {
            pointer-events: none;
        }

        .room:hover {
            background-color: #f0ad4e;
            transform: scale(1.1);
        }

        .room.large {
            position: relative;
            grid-column: 5 / span 2;
            grid-row: 1 / span 2;
            background-color: #8e8e8e;
        }

        .room.large::after {
            content: 'ไม่ว่าง';
            /* Default content is "Not Available" */
            position: absolute;
            top: 10px;
            right: 10px;
            width: 30px;
            height: 30px;
            background-color: red;
            border: 2px solid white;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 10px;
            color: white;
        }

        .room.large.available::after {
            content: 'ว่าง';
            /* Content changes to "Available" */
            background-color: green;
            /* Change color to green for available rooms */
        }

        .room.small {
            position: relative;
            grid-column: 5 / span 2;
            grid-row: 1 / span 2;
            background-color: #8e8e8e;
        }

        .room.small::after {
            content: 'ไม่ว่าง';
            /* Default content is "Not Available" */
            position: absolute;
            top: 10px;
            right: 7px;
            width: 30px;
            height: 30px;
            background-color: red;
            border: 2px solid white;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 10px;
            color: white;
        }

        .room.small.available::after {
            content: 'ว่าง';
            /* Content changes to "Available" */
            background-color: green;
            /* Change color to green for available rooms */
        }


        .room.large.sc2-308 {
            grid-column: 7 / span 2;
            grid-row: 1 / span 2;
            background-color: #8e8e8e;
        }

        .room.vertical_1 {
            grid-row: span 2;
        }

        .room.vertical_2 {
            grid-row: span 2;
            grid-column: 10;
        }

        .room.vertical_3 {
            grid-row: span 2;
            grid-column: 11;
        }

        .room.vertical_4 {
            grid-row: span 2;
            grid-column: 12;
        }

        .room.vertical_5 {
            grid-row: 6 / span 2;
            grid-column: 1 / span 1;
        }

        .room.vertical_6 {
            grid-row: 6 / span 2;
            grid-column: 2 / span 1;
        }

        .room.vertical_7 {
            grid-row: 6 / span 2;
            grid-column: 3 / span 1;
        }

        .room.vertical_8 {
            grid-row: 6 / span 2;
            grid-column: 5 / span 1;
            background-color: gray;
        }

        .room.vertical_9 {
            grid-row: 6 / span 2;
            grid-column: 6 / span 1;
            background-color: gray;
        }

        .room.vertical_10.room.large.sc2-313 {
            grid-column: 7 / span 2;
            grid-row: 6 / span 2;
            background-color: gray;
        }

        .room.vertical_11.room.large.sc2-311 {
            grid-column: 11 / span 2;
            grid-row: 6 / span 2;
            background-color: gray;
        }

        .sidebar {
            flex: 1;
            background-color: #f8f9fa;
            padding: 20px;
            display: flex;
            flex-direction: column;
            border-left: 2px solid #000;
            border: 2px solid #000;
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .categories {
            list-style: none;
            padding: 0;
            margin-bottom: 20px;
        }

        .categories li {
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            border: 1px solid #000000;
            border-radius: 51px;
            background-color: #fff;
        }

        .categories li span {
            background-color: #eb0f0f;
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
        }

        .reports {
            flex: 1;
            overflow-y: auto;
            margin-bottom: 20px;
            text-align: left;
            /* จัดข้อความชิดซ้าย */
        }

        .report-item {
            display: flex;
            align-items: center;
            gap: 10px;
            /* เพิ่มช่องว่างระหว่างไอคอนกับข้อความ */
            margin-bottom: 10px;
            padding: 10px;
            border-radius: 20px;
            background-color: #fff;
            text-align: left;
            /* จัดข้อความชิดซ้าย */
        }

        .report {
            background-color: #fff3cd;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ffeeba;
            border-radius: 5px;
            border: 1px solid #000000;
        }

        button {
            padding: 10px 20px;
            background-color: #6c34a3;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #563080;
        }
    </style>
</head>

<body>
    <main>
        <div class="layout">
            <div class="room red vertical_1">SC2-304</div>
            <div class="room red vertical_1">SC2-305</div>
            <div class="room red vertical_1">SC2-306</div>

            <div onclick="window.location.href='Schedule.php'" style="cursor: pointer; text-decoration: none; color: inherit;" class="room large" id="SC2-307">SC2-307</div>
            <div onclick="window.location.href='Schedule.php'" style="cursor: pointer; text-decoration: none; color: inherit;" class="room large sc2-308" id="SC2-308">SC2-308</div>

            <div class="room red vertical_2">ห้องน้ำ</div>
            <div class="room red vertical_3">ห้องน้ำ</div>
            <div class="room red vertical_4">SC2-310</div>
            <div class="room red vertical_5">SC2-301</div>
            <div class="room red vertical_6">SC2-302</div>
            <div class="room red vertical_7">SC2-303</div>
            <div class="room vertical_8 small" id="SC2-314" onclick="manageRoom('SC2-314')">SC2-314</div>
            <div class="room vertical_9 small" id="SC2-313-1" onclick="manageRoom('SC2-313-1')">SC2-313-1</div>
            <div class="room vertical_10 room large sc2-313" id="SC2-313" onclick="manageRoom('SC2-313')">SC2-313</div>
            <div class="room vertical_11 room large sc2-311" id="SC2-311" onclick="manageRoom('SC2-311')">SC2-311</div>
        </div>

        <div class="sidebar">
            <div class="reports">
                <div class="report-item">
                    <span class="icon icon-red"></i></span> <!-- ไอคอนจองไม่ได้ -->
                    <span>จองไม่ได้</span>
                </div>
                <div class="report-item">
                    <span class="icon icon-green"></i></span> <!-- ไอคอนจองได้ -->
                    <span>จองได้</span>
                </div>
                <div class="report-item">
                    <span class="icon"><i class="fas fa-chalkboard-teacher"></i></span> <!-- ไอคอนห้องเล็กเชอร์ -->
                    <span>ห้องเล็กเชอร์</span>
                </div>
                <div class="report-item">
                    <span class="icon"><i class="fas fa-laptop-code"></i></span> <!-- ไอคอนห้องปฏิบัติการ -->
                    <span>ห้องปฏิบัติการ</span>
                </div>
                <div class="report-item">
                    <span class="icon"><i class="fas fa-users"></i></span> <!-- ไอคอนห้องประชุม -->
                    <span>ห้องประชุม</span>
                </div>
            </div>

        </div>
    </main>


    <script>
        // Modal references
        const modal = document.getElementById("roomModal");
        const closeModal = document.querySelector(".close");
        const saveStatusButton = document.getElementById("saveStatus");
        const statusSelect = document.getElementById("status");
        const roomDetailTitle = document.getElementById("roomDetailTitle");
        // Global variable to store the current room element being edited
        let currentRoomElement = null;

        // Open the modal and display the room details
        function manageRoom(roomId) {
            if (roomId === "SC2-307" || roomId === "SC2-308") {
                window.location.href = "D:\ip\Schedule.html"; // เปลี่ยนเส้นทางไปยังหน้า schedule.html
                return; // หยุดการทำงานต่อ
            }

            currentRoomElement = document.getElementById(roomId);
            const roomName = currentRoomElement.innerText;

            // Set the title to show room details
            roomDetailTitle.innerText = `รายละเอียดห้อง : ${roomName}`;

            // Determine current status (Available/Not Available)
            const currentStatus = currentRoomElement.classList.contains('available') ? 'available' : 'not-available';
            statusSelect.value = currentStatus === 'available' ? 'available' : 'not-available';

            // Load equipment list from localStorage
            loadEquipmentList(roomId);

            // Show the modal
            modal.style.display = "block";
        }

        // Save the room status and update the room element
        saveStatusButton.onclick = function() {
            const selectedStatus = statusSelect.value;

            if (selectedStatus === "available") {
                currentRoomElement.classList.add('available');
                currentRoomElement.classList.remove('not-available');
            } else {
                currentRoomElement.classList.add('not-available');
                currentRoomElement.classList.remove('available');
            }

            // Save the room status in localStorage
            localStorage.setItem(currentRoomElement.id, selectedStatus);

            // Close the modal after saving
            modal.style.display = "none";
        }

        // Close the modal
        closeModal.onclick = function() {
            modal.style.display = "none";
        }

        // Close the modal if clicked outside of it
        window.onclick = function(event) {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        }

        // Load room status from localStorage when the page reloads
        window.onload = function() {
            const rooms = document.querySelectorAll('.room');

            rooms.forEach(room => {
                const savedStatus = localStorage.getItem(room.id);

                if (savedStatus) {
                    if (savedStatus === "available") {
                        room.classList.add('available');
                        room.classList.remove('not-available');
                    } else {
                        room.classList.add('not-available');
                        room.classList.remove('available');
                    }
                }
            });
        }
    </script>

</body>

</html>