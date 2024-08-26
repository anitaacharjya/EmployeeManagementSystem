<%@page import="java.sql.Connection"%>
<%@page import="com.pcs.employee.vo.User"%>
<%@page import="com.pcs.employee.dao.impl.UserDaoImpl"%>
<%@page import="com.pcs.employee.vo.Attendance_vo"%>
<%@page import="java.util.List"%>
<%@page import="com.pcs.db.Dbconnect"%>
<%@page import="com.pcs.employee.dao.impl.*"%>
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
<title>Work Report</title>
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
	rel="stylesheet">
<style>
.popup {
	display: none;
	position: absolute;
	background-color: rgba(0, 0, 0, 0.75);
	color: #fff;
	border: 1px solid #ccc;
	padding: 8px;
	border-radius: 8px;
	box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.25);
	z-index: 1000;
	white-space: nowrap;
	font-size: 14px;
	animation: fadeIn 0.3s ease-in-out;
}

.popup::after {
	content: '';
	position: absolute;
	top: 100%;
	left: 50%;
	margin-left: -8px;
	border-width: 8px;
	border-style: solid;
	border-color: rgba(0, 0, 0, 0.75) transparent transparent transparent;
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
.table-container {
	max-height: 500px;
	overflow-y: auto;
}

.table-header {
	background-color: #2563eb;
	color: #fff;
}

.table-row:hover {
	background-color: #e0f2fe;
}

.table-cell {
	padding: 12px 15px;
	text-align: left;
}

.table-cell a {
	color: #2563eb;
	text-decoration: none;
	font-weight: bold;
}

.table-cell a:hover {
	text-decoration: underline;
}
</style>
</head>
<body class="bg-gray-100 h-full">
	<div class="flex h-full">
		<!-- Sidebar -->
		<%@include file="Components/Navbar.jsp"%>

		<!-- Main Content -->
		<div class="flex-1 p-10">
			<h1 class="text-3xl font-bold mb-6">Work Report</h1>

			<div class="bg-white shadow-md rounded-lg overflow-hidden">
				<div class="table-container">
					<table class="min-w-full">
						<thead>
							<tr
								class="table-header text-gray-200 uppercase text-sm leading-normal">
								<th class="table-cell">Employee ID</th>
								<th class="table-cell">Name</th>
								<th class="table-cell">Email</th>
								<th class="table-cell">Phone Number</th>
							</tr>
						</thead>
						<tbody class="text-gray-700 text-sm font-light">
							<%
							List<User> users = (List<User>) request.getAttribute("userList");
							if (users != null) {
								// Sort users based on join date (doj) in descending order
								users.sort((u1, u2) -> u2.getDoj().compareTo(u1.getDoj()));

								for (int i = 0; i < users.size(); i++) {
									User user = users.get(i);
							%>
							<tr class="table-row border-b border-gray-200 hover:bg-blue-100">
								<td class="table-cell"><a
									href="EmployeeIdwiseWorkReport.jsp?emp_id=<%=user.getEmp_id()%>"
									class="relative emp-link" data-emp-id="<%=user.getEmp_id()%>">
										#<%=user.getEmp_id()%> <%
 if (i == 0) {
 %> <span class="popup">Tap here to see the Work Report</span> <%
 }
 %>
								</a></td>
								<td class="table-cell"><%=user.getName()%></td>
								<td class="table-cell"><%=user.getEmail()%></td>
								<td class="table-cell"><%=user.getMobileno()%></td>
							</tr>
							<%
							}
							}
							%>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<script>
		document.addEventListener('DOMContentLoaded', function () {
			const popupDuration = 3000; // 3 seconds
			const hideDelay = 5000; // 5 seconds

			const firstPopup = document.querySelector('.popup');
			if (firstPopup) {
				setTimeout(() => {
					firstPopup.style.display = 'block';
					setTimeout(() => {
						firstPopup.style.display = 'none';
					}, hideDelay);
				}, popupDuration);
			}
		});
	</script>
</body>
</html>
