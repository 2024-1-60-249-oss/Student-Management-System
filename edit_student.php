<?php
session_start();
include('db.php');

if (!isset($_SESSION['role']) || $_SESSION['role'] != 'Admin') {
    header("Location: index.php");
    exit();
}

$id = intval($_GET['id']);
$student = $conn->query("SELECT * FROM STUDENTS WHERE Student_ID = $id")->fetch_assoc();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name    = $_POST['full_name'];
    $phone   = $_POST['phone'];
    $email   = $_POST['email'];
    $address = $_POST['address'];

    $sql = "UPDATE STUDENTS SET Full_Name='$name', Phone='$phone', Email='$email', Address='$address' WHERE Student_ID=$id";

    if ($conn->query($sql) === TRUE) {
        header("Location: admin_dashboard.php");
        exit();
    } else {
        echo "Error: " . $conn->error;
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Student</title>
    <style>
        body { font-family: Arial; padding: 20px; }
        form { width: 300px; }
        input, textarea { width: 100%; margin-bottom: 10px; padding: 8px; box-sizing: border-box; }
    </style>
</head>
<body>
    <h2>Edit Student Information</h2>
    <form method="POST">
        <input type="text" name="full_name" value="<?php echo htmlspecialchars($student['Full_Name']); ?>" required>
        <input type="text" name="phone" value="<?php echo htmlspecialchars($student['Phone']); ?>">
        <input type="email" name="email" value="<?php echo htmlspecialchars($student['Email']); ?>">
        <textarea name="address"><?php echo htmlspecialchars($student['Address']); ?></textarea>
        <input type="submit" value="Update Record">
    </form>
</body>
</html>