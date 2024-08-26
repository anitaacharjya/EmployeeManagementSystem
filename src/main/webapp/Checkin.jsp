<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Management System</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<style type="text/css">
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Body styles */
body {
    font-family: Arial, sans-serif;
    display: flex;
    margin: 0; /* Remove default margin */
}

/* Sidebar styles */
.sidebar {
    background-color: #007bff; /* Blue color */
    color: white;
    width: 250px;
    position: fixed;
    left: 0;
    top: 0;
    bottom: 0; /* Extend sidebar to bottom */
    overflow-y: auto; /* Allow scrolling if content exceeds height */
}

.sidebar-header {
    font-size: 1.5em;
    font-weight: bold;
    margin: 20px 0 10px 20px; /* Adjust margins */
}

.sidebar-menu {
    list-style-type: none;
    padding: 0;
}

.sidebar-menu li {
    margin-bottom: 10px;
}

.sidebar-menu a {
    color: white;
    text-decoration: none;
    display: block;
    padding: 8px 16px;
    border-radius: 4px;
    text-transform: uppercase; /* Convert text to uppercase */
}

.sidebar-menu a:hover {
    background-color: rgba(255, 255, 255, 0.2); /* Lighten on hover */
}

/* Content styles */
.main-content {
    flex: 1; /* Take remaining horizontal space */
    padding: 20px;
    background-color: #f0f0f0; /* Light gray background */
    color: gray; /* Dark gray text */
    margin-left: 250px; /* Adjust for sidebar width */
    height: 100vh; /* Full height */
    overflow-y: auto; /* Allow scrolling if content exceeds height */
}

.container {
    padding: 20px;
    background-color: #fff; /* White background for container */
    color: #333; /* Dark text color */
    margin-top: 20px; /* Add some spacing between main content and container */
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1); /* Light shadow */
    min-height: 60vh; /* Set minimum height for the container */
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center; /* Center-align text */
}

.container h3, .container h5 {
    margin-bottom: 20px;
}

.container h5 {
    color: #007bff; /* Blue text color */
    align-self: flex-start; /* Move to the left */
    margin-top: 0; /* Remove top margin */
}

.container p {
    margin-bottom: 20px;
}

.container button {
    background-color: #ff5722; /* Orange button */
    color: white;
    border: none;
    padding: 15px 30px;
    font-size: 1.2em;
    border-radius: 50%;
    cursor: pointer;
    margin-top: 20px;
}

.container button:hover {
    background-color: #e64a19; /* Darken on hover */
}

.container button i {
    font-size: 4.5em;
    color: white; /* Set icon color to white */
}

.logout-button {
    background-color: #ff5722; /* Orange button */
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 1em;
    border-radius: 50%;
    cursor: pointer;
    margin-top: 20px;
}

.logout-button:hover {
    background-color: #e64a19; /* Darken on hover */
}

.logout-button i {
    font-size: 2em; /* Increase icon size */
    color: white; /* Set icon color to white */
}

/* Adjustments for responsiveness */
@media (max-width: 768px) {
    body {
        flex-direction: column;
    }
    .main-content {
        margin-left: 0;
    }
    .sidebar {
        width: 100%;
        height: auto;
        position: relative;
    }
    .container {
        margin-top: 0;
    }
}
</style>
<script>
document.addEventListener("DOMContentLoaded", function() {
    // Set system date and time
    var now = new Date();
    var day = String(now.getDate()).padStart(2, '0');
    var month = String(now.getMonth() + 1).padStart(2, '0'); // Months are zero-indexed
    var year = now.getFullYear();
    var hours = String(now.getHours()).padStart(2, '0');
    var minutes = String(now.getMinutes()).padStart(2, '0');
    var seconds = String(now.getSeconds()).padStart(2, '0');
    var formattedDateTime = day + '-' + month + '-' + year + ' ' + hours + ':' + minutes + ':' + seconds;
    document.getElementById("dateTime").value = formattedDateTime;

});
</script>
</head>
<body>
<div class="sidebar">
    <div class="sidebar-header">
        <i class='bx bxs-user'></i>PCS
    </div>
    <ul class="sidebar-menu" style="margin-top: 40px;">
        <li style="font-weight: bold; margin-left: 20px;">ATTENDANCE</li>
        <li><a href="Attendance.jsp"><i class='bx bx-detail'></i>ATTENDANCE FORM</a></li>
        <li style="font-weight: bold; margin-left: 20px;">PROFILE</li>
        <li><a href="#"><i class='bx bx-id-card'></i>MY PROFILE</a></li>
    </ul>
</div>
<div class="main-content">
    <ul>
        <img src="Images/logo.jpg" alt="logo" style="height:40px"/>
    </ul>
    <div class="container">
        <h5>Stamp your Attendance!</h5>
        <h3>THANK YOU FOR TODAY</h3>
        <p>The world of business survives less on leadership skills and more on the commitment and dedication of passionate employees like you.</p>
        <p>Thank you for your hard work.</p>
        <form action="CheckoutServlet" method="post">
           <input type="hidden" id="emp_id" name="emp_id" value="${userobj.emp_id}">
           <input type="hidden" id="dateTime" name="dateTime" readonly>
            <button type="submit">
                <i class='bx bx-log-out'></i>
            </button>
        </form>
        
    </div>
</div>

<script>
    
</script>
</body>
</html>
