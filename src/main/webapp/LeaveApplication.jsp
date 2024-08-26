<%@page import="com.pcs.employee.dao.impl.LeaveDaoImpl"%>
<%@page import="com.pcs.db.Dbconnect"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.pcs.employee.vo.*"%>
<%@page import="java.util.Random"%>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html class="h-full">
<head>
<meta charset="UTF-8">
<title>LeaveApplication</title>
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
	rel="stylesheet">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: Arial, sans-serif;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	margin: 0;
}

.sidebar {
	background-color: #007bff;
	color: white;
	width: 250px;
	position: fixed;
	left: 0;
	top: 0;
	bottom: 0;
	overflow-y: auto;
	z-index: 1000;
}

.sidebar-header {
	font-size: 1.5em;
	font-weight: bold;
	margin: 20px 0 10px 20px;
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
	text-transform: uppercase;
}

.sidebar-menu a:hover {
	background-color: rgba(255, 255, 255, 0.2);
}

.main-content {
	flex: 1;
	padding: 20px;
	background-color: #f0f0f0;
	color: gray;
	margin-left: 250px;
}

.leaves-container {
	white-space: nowrap;
	text-align: center;
	display: flex;
	justify-content: center; /* Center horizontally */
	align-items: center; /* Center vertically */
	height: 100vh; /* Full viewport height */
}

.leaves {
	width: 100%;
	max-width: 1200px;
	background-color: white;
	color: #333;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	vertical-align: top;
	margin-right: 20px;
	margin-bottom: 20px;
}

.calendar table {
	border-collapse: collapse;
	width: 100%;
}

.calendar th, .calendar td {
	padding: 10px;
	text-align: center;
	border: 1px solid #ccc;
	height: 80px;
	vertical-align: top;
}

.calendar th {
	background-color: #007bff;
	color: white;
}

.calendar .today {
	background-color: #007bff;
	color: white;
	font-weight: bold;
}

.calendar-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px;
}

.calendar-header .icon {
	cursor: pointer;
	color: #007bff;
}

.dot {
	height: 10px;
	width: 10px;
	border-radius: 50%;
	display: inline-block;
	margin-top: 5px;
}

.dot.green {
	background-color: green;
}

.dot.red {
	background-color: red;
}

.dot.blue {
	background-color: blue;
}

.time {
	font-size: 0.8em;
	margin-top: 5px;
}

.legend {
	display: flex;
	justify-content: space-around;
	margin: 10px 0;
}

.legend div {
	display: flex;
	align-items: center;
}

.legend .dot {
	margin-right: 5px;
}

.form-container {
	max-width: 500px;
	margin: 0 auto;
}

.leave-report-container {
	width: 100%; /* Set the width as per your requirement */
}

.status-pending {
	color: white;
	background-color: red;
	padding: 2px 6px;
	border-radius: 4px;
	font-weight: bold;
}
</style>
</head>

<%
    User u = (User) session.getAttribute("userobj");
    String empid = u.getEmp_id();
    LeaveDaoImpl leavereport = new LeaveDaoImpl(Dbconnect.getConn());
    List<Leave> show_data = leavereport.getLeavesByUserId(empid);

    long millis = System.currentTimeMillis();
    java.sql.Date date = new java.sql.Date(millis);
    String todaydate = String.valueOf(date);

    // Generate a 6-digit random number
    Random random = new Random();
    int randomNumber = 100000 + random.nextInt(900000);
%>


<body class="bg-gray-100 h-full">
	<div class="sidebar">
		<div class="sidebar-header">
			<i class='bx bxs-user'><i class='bx bx-check'></i></i>PCS
		</div>
		<ul class="sidebar-menu" style="margin-top: 40px;">
			<li style="font-weight: bold; margin-left: 20px;">ATTENDANCE</li>
			<li><a href="Attendance.jsp"><i class='bx bx-detail'></i>Attendance
					Form</a></li>
			<li><a href="WorkingReport.jsp"><i class='bx bx-detail'></i>Working
					Report</a></li>
			<li style="font-weight: bold; margin-left: 20px;">LEAVE</li>
			<li><a href="LeaveApplication.jsp"><i class='bx bx-calendar'></i>Leave
					Application</a></li>
			<li><a href="LeaveReport.jsp"><i class='bx bx-calendar'></i>Leave
					Reports</a></li>
			<li style="font-weight: bold; margin-left: 20px;">PROFILE</li>
			<li><a href="myprofile.jsp"><i class='bx bx-id-card'></i>My
					Profile</a></li>
		</ul>
	</div>

	<div class="main-content">
		<ul>
			<img src="Images/logo.jpg" alt="logo" style="height: 40px" />
		</ul>

		<div id="leaves" class="leaves-container">
			<div class="p-4 bg-white rounded shadow-lg form-container">
				<div class="text-center mb-8">
					<h2 class="text-2xl font-bold text-gray-800">Leave Application</h2>
				</div>
				<div class="title col-md-12 mt-2">
					<c:if test="${not empty Success}">
						<h3 class="text-green-500"
							style="font-size: 15px; font-weight: bold">${Success}</h3>
						<c:remove var="Success" scope="session" ></c:remove>
					</c:if>
					<c:if test="${not empty Failed}">
						<h3 class="text-red-500"
							style="font-size: 15px; font-weight: bold">${Failed}</h3>
						<c:remove var="Failed" scope="session" />
					</c:if>
				</div>

				<div class="header-content text-center w-full px-5"></div>

				<form action="leave" method="post">
					<div class="grid grid-cols-1 gap-4">
						<div class="form-group mb-3">
							<input type="hidden" id="emp_id" name="emp_id" value="${userobj.emp_id}" readonly class="w-full p-2 border rounded">
							<input type="hidden" id="emp_id" name="email" value="${userobj.email}" readonly class="w-full p-2 border rounded">
				</div>
				
                            <div>
                               <!--  <label for="leaveSubject" class="block text-sm font-medium text-gray-700">Leave Subject</label> -->
                                <input type="text" id="leaveSubject" name="leaveSubject" placeholder="Leave Subject" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                            </div>
                            <div>
                               <!--  <label for="leaveDate" class="block text-sm font-medium text-gray-700">Leave Start Date</label> -->
                                <input type="date" id="startDate" name="startDate" placeholder="Leave Start Date" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                            </div>
                             <div>
                               <!--  <label for="leaveDate" class="block text-sm font-medium text-gray-700">Leave End Date</label> -->
                                <input type="date" id="endDate" name="endDate" placeholder="Leave End Date" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                            </div>
                             <div>
                               
                                <input type="hidden" id="applydate" name="applydate" value="<%=todaydate %>" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                            </div>
                            <div>
                               <!--  <label for="leaveMessage" class="block text-sm font-medium text-gray-700">Leave Description</label> -->
                                <textarea id="leaveMessage" name="leaveMessage" placeholder="Leave Description" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"></textarea>
                            </div>
                            <div>
                               <!--  <label for="leaveType" class="block text-sm font-medium text-gray-700">Leave Type</label> -->
                                <select id="leaveType" name="leaveType" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                                    <option value="" disabled selected>Please select leave type..</option>
                                    <option value="Earned">Earned (10 Earned Leaves Per Quarter : 3.33)</option>
                                    <option value="Sick/Medical">Sick/Medical Leave (10 Sick Leave, Per Quarter : 3.33)</option>
                                    <option value="Casual">Casual Leave (10 casual Leave, Per Quarter : 3.33)</option>
                                    <option value="LWP">Leave Without Pay (LWP)</option>
                                    <option value="Sabbatical">Sabbatical (Long Duration Leave)</option>
                                </select>
                            </div>
                             <input type="hidden" id="status" name="status" value="pending" required class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                             <input type="hidden" name="randomNumber"
							value="<%=randomNumber%>" readonly>
                        </div>
                        <div class="mt-4">
                            <input type="submit" value="Submit" class="bg-green-500 hover:bg-yellow-600 text-white font-bold py-2 px-4 rounded">
                            </div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
