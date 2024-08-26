<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pcs.employee.vo.Leave" %>
<%@ page import="com.pcs.employee.dao.impl.LeaveDaoImpl" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.pcs.db.Dbconnect" %>
<%@ page import="com.pcs.employee.vo.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Leave Report</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
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
	justify-content: center;
	align-items: center;
	height: 100vh;
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
	width: 100%;
}

.status-pending {
	color: white;
	background-color: red;
	padding: 2px 6px;
	border-radius: 4px;
	font-weight: bold;
}
</style>
<body class="bg-gray-100">
<div class="container mx-auto p-4">

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

    <%
    User u = (User) session.getAttribute("userobj");
    String empid = u.getEmp_id();
    List<Leave> leaveList = null;
    if (empid != null) {
        Connection conn = new Dbconnect().getConn();
        LeaveDaoImpl leaveDao = new LeaveDaoImpl(conn);
        leaveList = leaveDao.getLeavesByUserId(empid);
    }
    %>
    <div class="main-content">
        <h1 class="text-2xl font-bold mb-4">Leave Report for Employee ID: <%= u.getEmp_id() %></h1>
        <table class="min-w-full bg-white">
            <thead class="bg-gray-800 text-white">
                <tr>
                    <th class="py-2 px-4">Leave ID</th>
                    <th class="py-2 px-4">Description</th>
                    <th class="py-2 px-4">Leave Type</th>
                    <th class="py-2 px-4">Leave Subject</th>
                    <th class="py-2 px-4">Start Date</th>
                    <th class="py-2 px-4">End Date</th>
                    <th class="py-2 px-4">Apply Date</th>
                    <th class="py-2 px-4">Status</th>
                    <th class="py-2 px-4">Email</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (leaveList != null) {
                        for (Leave leave : leaveList) {
                %>
                <tr class="border-b">
                    <td class="py-2 px-4"><%= leave.getId() %></td>
                    <td class="py-2 px-4"><%= leave.getDescription() %></td>
                    <td class="py-2 px-4"><%= leave.getLeaveType() %></td>
                    <td class="py-2 px-4"><%= leave.getLeaveSubject() %></td>
                    <td class="py-2 px-4"><%= leave.getStartDate() %></td>
                    <td class="py-2 px-4"><%= leave.getEndDate() %></td>
                    <td class="py-2 px-4"><%= leave.getApplyDate() %></td>
                    <td class="py-2 px-4"><%= leave.getStatus() %></td>
                    <td class="py-2 px-4"><%= leave.getEmail() %></td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
