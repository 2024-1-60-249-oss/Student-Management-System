<?php
session_start();
include('db.php');

$error = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = trim($_POST['username']);
    $password = trim($_POST['password']);

    // Prepared Statement to prevent SQL Injection
    $stmt = $conn->prepare("SELECT * FROM USERS WHERE Username = ? AND Password = ?");
    $stmt->bind_param("ss", $username, $password);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows == 1) {
        $row = $result->fetch_assoc();
        $_SESSION['user_id']    = $row['User_ID'];
        $_SESSION['role']       = $row['Role'];
        $_SESSION['student_id'] = $row['Student_ID'];

        // Redirect based on user role with proper exit()
        if ($row['Role'] == 'Admin') {
            header("Location: admin_dashboard.php");
            exit();
        } else {
            header("Location: student_profile.php");
            exit();
        }
    } else {
        $error = "Invalid Username or Password!";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login - Student Management System</title>
    <style>
        body { font-family: Arial; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); width: 300px; }
        input[type="text"], input[type="password"] { width: 100%; padding: 10px; margin: 8px 0; box-sizing: border-box; }
        input[type="submit"] { width: 100%; background: #007bff; color: white; padding: 10px; border: none; cursor: pointer; border-radius: 4px; }
        .error { color: red; text-align: center; margin-bottom: 15px; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>System Login</h2>
        <?php if (!empty($error)): ?>
            <p class='error'><?php echo htmlspecialchars($error); ?></p>
        <?php endif; ?>
        
        <form method="POST" action="">
            <label>Username:</label>
            <input type="text" name="username" required>
            
            <label>Password:</label>
            <input type="password" name="password" required>
            
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>