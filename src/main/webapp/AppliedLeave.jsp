<%@page import="com.pcs.employee.vo.Leave"%>
<%@page import="java.util.List"%>
<%@page import="com.pcs.employee.dao.impl.LeaveDaoImpl"%>
<%@page import="com.pcs.db.Dbconnect"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Leaves</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">
<style>
	.hidden {
		display: none;
	}
</style>
<script>
	function filterLeaves(status) {
		var allLeaves = document.querySelectorAll('.leave-row');
		allLeaves.forEach(function(leave) {
			if (status === 'All' || leave.getAttribute('data-status') === status) {
				leave.classList.remove('hidden');
			} else {
				leave.classList.add('hidden');
			}
		});
	}
</script>
</head>
<body class="bg-gray-100">
	<div class="flex">
		<%@include file="Components/Navbar.jsp"%>
		<div class="flex-1 p-6">
			<div class="container mx-auto mt-10">
				<h1 class="text-2xl font-bold mb-4">All Leaves</h1>

				<%
				Connection conn = Dbconnect.getConn();
				LeaveDaoImpl leaveDao = new LeaveDaoImpl(conn);
				List<Leave> leaveList = leaveDao.getAllLeaveReports();
				%>

				<div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
					<div class="bg-white p-4 rounded shadow cursor-pointer" onclick="filterLeaves('Pending')">
						<h2 class="text-lg font-bold text-center">Pending Leaves</h2>
					</div>
					<div class="bg-white p-4 rounded shadow cursor-pointer" onclick="filterLeaves('Approved')">
						<h2 class="text-lg font-bold text-center">Approved Leaves</h2>
					</div>
					<div class="bg-white p-4 rounded shadow cursor-pointer" onclick="filterLeaves('Rejected')">
						<h2 class="text-lg font-bold text-center">Rejected Leaves</h2>
					</div>
				</div>

				<table class="min-w-full bg-white border border-gray-200">
					<thead>
						<tr>
							<th class="py-2 px-4 border-b">ID</th>
							<th class="py-2 px-4 border-b">Employee ID</th>
							<th class="py-2 px-4 border-b">Leave Type</th>
							<th class="py-2 px-4 border-b">Leave Subtype</th>
							<th class="py-2 px-4 border-b">Description</th>
							<th class="py-2 px-4 border-b">Start Date</th>
							<th class="py-2 px-4 border-b">End Date</th>
							<th class="py-2 px-4 border-b">Apply Date</th>
							<th class="py-2 px-4 border-b">Email</th>
							<th class="py-2 px-4 border-b">Status</th>
							<th class="py-2 px-4 border-b">Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						for (Leave leave : leaveList) {
						%>
						<tr class="leave-row" data-status="<%=leave.getStatus()%>">
							<td class="py-2 px-4 border-b"><%=leave.getLeave_report_id()%></td>
							<td class="py-2 px-4 border-b"><%=leave.getId()%></td>
							<td class="py-2 px-4 border-b"><%=leave.getLeaveType()%></td>
							<td class="py-2 px-4 border-b"><%=leave.getLeaveSubject()%></td>
							<td class="py-2 px-4 border-b"><%=leave.getDescription()%></td>
							<td class="py-2 px-4 border-b"><%=leave.getStartDate()%></td>
							<td class="py-2 px-4 border-b"><%=leave.getEndDate()%></td>
							<td class="py-2 px-4 border-b"><%=leave.getApplyDate()%></td>
							<td class="py-2 px-4 border-b"><%=leave.getEmail()%></td>
							<td class="py-2 px-4 border-b"><%=leave.getStatus()%></td>
							<td class="py-2 px-4 border-b">
								<a href="editLeave.jsp?id=<%=leave.getLeave_report_id()%>" class="text-blue-500 hover:underline">Edit</a> |
								<a href="deleteLeave?id=<%=leave.getLeave_report_id()%>" class="text-red-500 hover:underline">Delete</a>
							</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
