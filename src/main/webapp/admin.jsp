<%@page import="java.util.Map"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.pcs.employee.vo.User"%>
<%@page import="com.pcs.employee.dao.impl.UserDaoImpl"%>
<%@page import="com.pcs.employee.vo.Attendance_vo"%>
<%@page import="java.util.List"%>
<%@page import="com.pcs.db.Dbconnect"%>
<%@page import="com.pcs.employee.dao.impl.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
// Database connection
Connection conn = null;
try {
	conn = Dbconnect.getConn();
	UserDaoImpl userDao = new UserDaoImpl(conn);
	List<User> userList = userDao.getAllUsers();
	request.setAttribute("userList", userList);
} catch (Exception e) {
	e.printStackTrace();
} finally {
	if (conn != null) {
		try {
	conn.close();
		} catch (Exception e) {
	e.printStackTrace();
		}
	}
}
%>
<!DOCTYPE html>
<html class="h-full">
<head>
<meta charset="UTF-8">
<title>PCS Global Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
	rel="stylesheet">
<style>
/* Custom styles */
.bg-gradient {
	background: linear-gradient(to right, #4f46e5, #89f7fe);
}

.card {
    background-color: #e3f2fd; /* Light blue background */
    border: 2px solid #90caf9; /* Blue border */
    border-radius: 0.75rem;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease-in-out;
}

.card:hover {
    transform: translateY(-5px);
}

.card h3 {
    color: #0d47a1; /* Darker blue for the heading */
}

.summary-value {
    color: #0d47a1; /* Darker blue for the summary value */
    font-size: 2.5rem;
}
.table-header {
	background-color: #4f46e5;
	color: #ffffff;
}

.table-row:hover {
	background-color: rgba(79, 70, 229, 0.1);
}
</style>
</head>
<body class="bg-gray-100 h-full">
	<div class="flex h-full">
		<!-- Sidebar -->
		<%@include file="Components/Navbar.jsp"%>

		<!-- Main Content -->
		<div class="flex-1 p-10">
			<h1 class="text-4xl font-bold mb-8 text-blue-900">Dashboard</h1>

			<!-- Summary Cards -->
			<div class="grid grid-cols-4 gap-6 mb-8">
				<div class="card p-6">
					<h3 class="text-lg font-semibold mb-2">DEPARTMENTS</h3>
					<%
					UserDaoImpl userDao = new UserDaoImpl(Dbconnect.getConn());
					int departmentCount = userDao.countUniqueRoles(); // Fetch the count of distinct departments
					%>
					<p class="summary-value"><%=departmentCount%></p>
				</div>
				<div class="card p-6">
					<h3 class="text-lg font-semibold mb-2">Time Slots</h3>
					<%
					WorkReportDaoImpl workReportDao = new WorkReportDaoImpl(Dbconnect.getConn());
					int timeSlotCount = workReportDao.countDistinctTimeSlots(); // Fetch the count of distinct time slots
					%>
					<p class="summary-value"><%=timeSlotCount%></p>
				</div>
				<div class="card p-6">
					<h3 class="text-lg font-semibold mb-2">EMPLOYEES</h3>
					<%
					UserDaoImpl dao = new UserDaoImpl(Dbconnect.getConn());
					int count = dao.countRegisteredUsers(); // Fetch the count directly
					%>
					<p class="summary-value"><%=count%></p>
				</div>
				<%
				LeaveDaoImpl leaveDao = new LeaveDaoImpl(Dbconnect.getConn());
				int leaveCount = leaveDao.countTotalLeaves();
				%>
				<div class="card p-6">
					<h3 class="text-lg font-semibold mb-2">Leaves</h3>
					<p class="summary-value"><%=leaveCount%></p>
				</div>
			</div>

			<!-- Tables -->
			<div class="grid grid-cols-2 gap-6">
				<div class="card p-6">
					<h3 class="text-lg font-semibold mb-4">Departments' Employees</h3>
					<table class="w-full">
						<thead>
							<tr class="table-header">
								<th class="py-2 px-4 text-left">ID</th>
								<th class="py-2 px-4 text-left">Dept Code</th>
								<th class="py-2 px-4 text-left">Employees</th>
							</tr>
						</thead>
						<tbody>
							<%
							List<User> users = (List<User>) request.getAttribute("userList");
							if (users != null) {
								// Sort users based on join date (doj) in descending order
								users.sort((u1, u2) -> u2.getDoj().compareTo(u1.getDoj()));

								int count2 = 0;
								for (User user : users) {
									if (count2 < 3) { // Display only the first three users
							%>
							<tr class="table-row border-b border-gray-200 hover:bg-gray-100">
								<td class="py-3 px-6 text-left whitespace-nowrap"><%=user.getEmp_id()%></td>
								<td class="py-3 px-6 text-left whitespace-nowrap"><%=user.getRole()%></td>
								<td class="py-3 px-6 text-left whitespace-nowrap"><%=user.getName()%></td>
							</tr>
							<%
							count2++;
							} else {
							break; // Exit the loop after displaying three users
							}
							}
							}
							%>

						</tbody>
					</table>
				</div>
				<div class="card p-6">
					<h3 class="text-lg font-semibold mb-4">Employees per Shift</h3>

					<%
					WorkReportDaoImpl workReportDaoImpl = new WorkReportDaoImpl(conn);
					Map<String, Integer> timeSlotUserCount = workReportDao.getUsersPerTimeSlot(); // Fetch the user count per time slot
					%>
					<table class="w-full">
						<thead>
							<tr class="table-header">
								<th class="py-2 px-4 text-left">#</th>
								<th class="py-2 px-4 text-left">Shift Code</th>
								<th class="py-2 px-4 text-left">Employees</th>
							</tr>
						</thead>
						<tbody>
							<%
							int index = 1;
							for (Map.Entry<String, Integer> entry : timeSlotUserCount.entrySet()) {
								String timeSlot = entry.getKey();
								int count3 = entry.getValue();
							%>
							<tr class="table-row border-b border-gray-200 hover:bg-gray-100">
								<td class="py-2 px-4"><%=index++%></td>
								<td class="py-2 px-4"><%=timeSlot%></td>
								<td class="py-2 px-4"><%=count3%></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>
</body>
</html>
