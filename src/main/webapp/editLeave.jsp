<%@page import="com.pcs.employee.vo.Leave"%>
<%@page import="com.pcs.employee.dao.impl.LeaveDaoImpl"%>
<%@page import="com.pcs.db.Dbconnect"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit Leave</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">
</head>
<body class="bg-gray-100">
	<div class="flex">
		<%@include file="Components/Navbar.jsp"%>
		<div class="flex-1 p-6">
			<div class="container mx-auto mt-10">
				<h1 class="text-2xl font-bold mb-4">Edit Leave</h1>

				<%
				Connection conn = Dbconnect.getConn();
				LeaveDaoImpl leaveDao = new LeaveDaoImpl(conn);
				int leaveId = Integer.parseInt(request.getParameter("id"));
				Leave leave = leaveDao.getLeaveById(leaveId);
				%>

				<form action="updateLeave" method="post">
					<input type="hidden" name="id" value="<%=leave.getLeave_report_id()%>">
					<div class="mb-4">
						<label for="leaveType" class="block text-gray-700">Leave Type</label>
						<input type="text" id="leaveType" name="leaveType" value="<%=leave.getLeaveType()%>" class="form-input mt-1 block w-full">
					</div>
					<div class="mb-4">
						<label for="leaveSubject" class="block text-gray-700">Leave Subtype</label>
						<input type="text" id="leaveSubject" name="leaveSubject" value="<%=leave.getLeaveSubject()%>" class="form-input mt-1 block w-full">
					</div>
					<div class="mb-4">
						<label for="description" class="block text-gray-700">Description</label>
						<textarea id="description" name="description" class="form-textarea mt-1 block w-full"><%=leave.getDescription()%></textarea>
					</div>
					<div class="mb-4">
						<label for="startDate" class="block text-gray-700">Start Date</label>
						<input type="date" id="startDate" name="startDate" value="<%=leave.getStartDate()%>" class="form-input mt-1 block w-full">
					</div>
					<div class="mb-4">
						<label for="endDate" class="block text-gray-700">End Date</label>
						<input type="date" id="endDate" name="endDate" value="<%=leave.getEndDate()%>" class="form-input mt-1 block w-full">
					</div>
											<input type="hidden" id="endDate" name="email" value="<%=leave.getEmail()%>" class="form-input mt-1 block w-full">
					
					<div class="mb-4">
						<label for="applyDate" class="block text-gray-700">Apply Date</label>
						<input type="date" id="applyDate" name="applyDate" value="<%=leave.getApplyDate()%>" class="form-input mt-1 block w-full">
					</div>
					<div class="mb-4">
						<label for="status" class="block text-gray-700">Status</label>
						<select id="status" name="status" class="form-select mt-1 block w-full">
							<option value="Pending" <%= leave.getStatus().equals("Pending") ? "selected" : "" %>>Pending</option>
							<option value="Approved" <%= leave.getStatus().equals("Approved") ? "selected" : "" %>>Approved</option>
							<option value="Rejected" <%= leave.getStatus().equals("Rejected") ? "selected" : "" %>>Rejected</option>
						</select>
					</div>
					<button type="submit" class="bg-blue-500 text-white py-2 px-4 rounded">Update Leave</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
