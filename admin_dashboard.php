<?php
session_start();
include('db.php');

// Admin Check
if (!isset($_SESSION['role']) || $_SESSION['role'] != 'Admin') {
    header("Location: index.php");
    exit();
}

// Handle Delete Request safely
if (isset($_GET['delete_id'])) {
    $delete_id = intval($_GET['delete_id']); 
    $conn->query("DELETE FROM STUDENTS WHERE Student_ID = $delete_id");
    header("Location: admin_dashboard.php");
    exit();
}

$result = $conn->query("SELECT s.*, d.Department_Name FROM STUDENTS s LEFT JOIN DEPARTMENTS d ON s.Department_ID = d.Department_ID");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #007bff; color: white; }
        .btn { padding: 6px 12px; background: #28a745; color: white; text-decoration: none; border-radius: 4px; }
        .btn-danger { background: #dc3545; }
        .btn-warning { background: #ffc107; color: black; }
    </style>
</head>
<body>
    <h2>Admin Dashboard - Student Records</h2>
    <a href="add_student.php" class="btn">Add New Student</a>
    <a href="logout.php" style="float: right;">Logout</a>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Blood Group</th>
            <th>Department</th>
            <th>Actions</th>
        </tr>
        <?php while ($row = $result->fetch_assoc()): ?>
        <tr>
            <td><?php echo $row['Student_ID']; ?></td>
            <td><?php echo $row['Full_Name']; ?></td>
            <td><?php echo $row['Email']; ?></td>
            <td><?php echo $row['Phone']; ?></td>
            <td><?php echo $row['Blood_Group']; ?></td>
            <td><?php echo $row['Department_Name']; ?></td>
            <td>
                <a href="edit_student.php?id=<?php echo $row['Student_ID']; ?>" class="btn btn-warning">Edit</a>
                <a href="admin_dashboard.php?delete_id=<?php echo $row['Student_ID']; ?>" class="btn btn-danger" onclick="return confirm('Delete this record?')">Delete</a>
            </td>
        </tr>
        <?php endwhile; ?>
    </table>
</body>
</html>