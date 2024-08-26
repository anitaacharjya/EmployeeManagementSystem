<%@page import="com.pcs.employee.vo.WorkReportVo"%>
<%@page import="com.pcs.employee.dao.impl.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="com.pcs.db.Dbconnect"%>
<%
String empId = request.getParameter("emp_id");
List<WorkReportVo> workReports = null;

Connection conn = null;
try {
	conn = Dbconnect.getConn();
	WorkReportDaoImpl workReportDao = new WorkReportDaoImpl(conn);
	workReports = workReportDao.getWorkReportsByEmpId(empId);
	request.setAttribute("workReports", workReports);
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
<html>
<head>
<meta charset="UTF-8">
<title>Employee Work Report</title>
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
	rel="stylesheet">
<style>
.sidebar {
	width: 250px; /* Adjust width as needed */
}

.main-content {
	flex: 1; /* Take up remaining space */
}

.divider {
	border-top: 2px solid #e5e7eb; /* Light gray border */
	margin: 1rem 0;
}

.spacing {
	height: 1rem; /* Adjust the height for space between dates */
}

.date-border {
	border: 2px solid #e5e7eb; /* Light gray border */
	padding: 0.5rem; /* Add padding for better visual appearance */
	margin-bottom: 1rem; /* Add some space below each date section */
}
</style>
</head>
<body class="bg-gray-200">
	<div class="flex h-screen">
		<!-- Sidebar (Navbar) -->
		<%@include file="Components/Navbar.jsp"%>

		<!-- Main Content Area -->
		<div class="main-content p-6">
			<div class="bg-white shadow-lg rounded-lg overflow-hidden">
				<div
					class="header-container p-6 border-b border-gray-300 bg-gray-50">
					<h1 class="text-3xl font-bold text-gray-800">
						Work Report for Employee ID: <span class="text-blue-500"><%=empId%></span>
					</h1>
					<a href="UserWorkreport.jsp"
						class="inline-block mb-4 py-2.5 px-6 bg-blue-500 text-white hover:bg-blue-600 rounded transition duration-200">Go
						Back</a>

				</div>
				<form action="DownloadWorkReportCSV" method="get" class="mb-4">
					<input type="hidden" name="emp_id" value="<%=empId%>"> <label
						for="month" class="mr-2">Month:</label> <input type="text"
						id="month" name="month" placeholder="MM"
						class="px-2 py-1 border border-gray-300 rounded"> <label
						for="year" class="mr-2 ml-4">Year:</label> <input type="text"
						id="year" name="year" placeholder="YYYY"
						class="px-2 py-1 border border-gray-300 rounded">
					<button type="submit"
						class="py-2.5 px-6 bg-green-500 text-white hover:bg-green-600 rounded transition duration-200">Download
						CSV</button>
				</form>

				<div class="p-6">
					<%
					String previousDate = null;
					boolean isFirstRow = true;
					%>
					<div class="date-border">
						<table class="min-w-full bg-white shadow-md rounded-lg">
							<thead>
								<tr class="bg-blue-500 text-white text-left uppercase text-sm">
									<th class="py-3 px-4">Employee Id</th>
									<th class="py-3 px-4">Report Date</th>
									<th class="py-3 px-4">Time Slot</th>
									<th class="py-3 px-4">Task Category</th>
									<th class="py-3 px-4">Task Details</th>
								</tr>
							</thead>
							<tbody class="text-gray-700 text-sm">
								<%
								if (workReports != null) {
									for (WorkReportVo report : workReports) {
										String reportDate = report.getReport_date();
										// Check if the date has changed
										if (!reportDate.equals(previousDate)) {
									// Close the previous table if not the first row
									if (!isFirstRow) {
										out.println("</tbody></table></div>");
									}
									// Start a new table section for the new date
									out.println("<div class='date-border'><h2 class='text-xl font-bold text-gray-800 mb-3'>" + reportDate
											+ "</h2>");
									out.println("<table class='min-w-full bg-white shadow-md rounded-lg'>");
									out.println("<tbody class='text-gray-700 text-sm'>");
									isFirstRow = false;
										}
										previousDate = reportDate;
								%>
								<tr
									class="border-b border-gray-200 hover:bg-gray-100 transition duration-300 ease-in-out">
									<td class="py-3 px-4"><%=report.getEmp_id()%></td>
									<td class="py-3 px-4"><%=report.getReport_date()%></td>
									<td class="py-3 px-4"><%=report.getTime_slot()%></td>
									<td class="py-3 px-4"><%=report.getTask_catagory()%></td>
									<td class="py-3 px-4"><%=report.getTask_details()%></td>
								</tr>
								<%
								}
								// Close the last table section
								if (!isFirstRow) {
								out.println("</tbody></table></div>");
								}
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
