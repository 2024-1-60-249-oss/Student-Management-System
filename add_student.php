<?php
session_start();
include('db.php');

if (!isset($_SESSION['role']) || $_SESSION['role'] != 'Admin') {
    header("Location: index.php");
    exit();
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $student_id = $_POST['student_id'];
    $name       = $_POST['full_name'];
    $dob        = $_POST['dob'];
    $gender     = $_POST['gender'];
    $blood      = $_POST['blood_group'];
    $phone      = $_POST['phone'];
    $email      = $_POST['email'];
    $address    = $_POST['address'];
    $dept_id    = $_POST['dept_id'];

    // 1. Insert into STUDENTS table
    $sql1 = "INSERT INTO STUDENTS (Student_ID, Full_Name, Date_of_Birth, Gender, Blood_Group, Phone, Email, Address, Department_ID) 
             VALUES ('$student_id', '$name', '$dob', '$gender', '$blood', '$phone', '$email', '$address', '$dept_id')";

    if ($conn->query($sql1) === TRUE) {
        // 2. Create User account automatically for student (Default Password: 123)
        $username = strtolower(explode(" ", trim($name))[0]); 
        $sql2 = "INSERT INTO USERS (Username, Password, Role, Student_ID) 
                 VALUES ('$username', '123', 'Student', '$student_id')";
        $conn->query($sql2);

        header("Location: admin_dashboard.php");
        exit();
    } else {
        echo "Error: " . $conn->error;
    }
}

$departments = $conn->query("SELECT * FROM DEPARTMENTS");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Add Student</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        form { width: 300px; }
        input, select, textarea { width: 100%; margin-bottom: 10px; padding: 8px; box-sizing: border-box; }
    </style>
</head>
<body>
    <h2>Add New Student</h2>
    <form method="POST">
        <input type="number" name="student_id" placeholder="Student ID (e.g. 2024160029)" required>
        <input type="text" name="full_name" placeholder="Full Name" required>
        <input type="date" name="dob" required>
        <select name="gender">
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>
        <input type="text" name="blood_group" placeholder="Blood Group (e.g. A+)">
        <input type="text" name="phone" placeholder="Phone Number">
        <input type="email" name="email" placeholder="Email">
        <textarea name="address" placeholder="Address"></textarea>
        <select name="dept_id">
            <?php while ($d = $departments->fetch_assoc()): ?>
                <option value="<?php echo $d['Department_ID']; ?>"><?php echo $d['Department_Name']; ?></option>
            <?php endwhile; ?>
        </select>
        <input type="submit" value="Save Student">
    </form>
</body>
</html>