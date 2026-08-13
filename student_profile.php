<?php
session_start();
include('db.php');

if (!isset($_SESSION['role']) || $_SESSION['role'] != 'Student') {
    header("Location: index.php");
    exit();
}

$student_id = $_SESSION['student_id'];
$sql = "SELECT s.*, d.Department_Name FROM STUDENTS s LEFT JOIN DEPARTMENTS d ON s.Department_ID = d.Department_ID WHERE s.Student_ID = $student_id";
$result = $conn->query($sql);
$data = $result->fetch_assoc();
?>

<!DOCTYPE html>
<html>
<head>
    <title>Student Profile</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        .profile-card { border: 1px solid #ccc; padding: 20px; width: 350px; border-radius: 8px; background: #fafafa; }
    </style>
</head>
<body>
    <h2>Welcome, <?php echo $data['Full_Name']; ?></h2>
    <a href="logout.php">Logout</a>

    <div class="profile-card">
        <h3>My Information</h3>
        <p><strong>Student ID:</strong> <?php echo $data['Student_ID']; ?></p>
        <p><strong>Email:</strong> <?php echo $data['Email']; ?></p>
        <p><strong>Phone:</strong> <?php echo $data['Phone']; ?></p>
        <p><strong>Gender:</strong> <?php echo $data['Gender']; ?></p>
        <p><strong>Blood Group:</strong> <?php echo $data['Blood_Group']; ?></p>
        <p><strong>Department:</strong> <?php echo $data['Department_Name']; ?></p>
    </div>
</body>
</html>