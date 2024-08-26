<%@page import="com.pcs.employee.dao.impl.LeaveDaoImpl"%>
<%@page import="com.pcs.db.Dbconnect"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.pcs.employee.vo.Leave"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Leave</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css">
</head>
<body class="bg-gray-100">
	<div class="flex">
		<%@include file="Components/Navbar.jsp"%>
		<div class="flex-1 p-6">
			<div class="container mx-auto mt-10">
				<%
				Connection conn = Dbconnect.getConn();
				LeaveDaoImpl leaveDao = new LeaveDaoImpl(conn);

				int id = Integer.parseInt(request.getParameter("id"));
				String leaveType = request.getParameter("leaveType");
				String leaveSubject = request.getParameter("leaveSubject");
				String description = request.getParameter("description");
				String startDate = request.getParameter("startDate");
				String endDate = request.getParameter("endDate");
				String applyDate = request.getParameter("applyDate");
				String status = request.getParameter("status");
				String leave_report_id=request.getParameter("leave_report_id");

				Leave leave = new Leave();
				leave.setLeaveType(leaveType);
				leave.setLeaveSubject(leaveSubject);
				leave.setDescription(description);
				leave.setStartDate(startDate);
				leave.setEndDate(endDate);
				leave.setApplyDate(applyDate);
				leave.setStatus(status);
				leave.setLeave_report_id(leave_report_id);



				response.sendRedirect("AppliedLeave.jsp");
				%>
			</div>
		</div>
	</div>
</body>
</html>
