<%@page import="com.pcs.employee.vo.Attendance_vo"%>
<%@page import="java.util.List"%>
<%@page import="com.pcs.db.Dbconnect"%>
<%@page import="com.pcs.employee.dao.impl.AttendanceDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="h-full">
<head>
    <meta charset="UTF-8">
    <title>Attendance Records</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 h-full">
    <div class="flex h-full">
        <!-- Sidebar -->
        <div class="w-64 bg-blue-500 text-white p-6">
            <h2 class="text-2xl font-bold mb-6">PCS Global PVT LTD</h2>
            <nav>
                <ul>
                    <li class="mb-4"><a href="admin.jsp" class="block py-2 px-4">Dashboard</a></li>
                    <li class="mb-4"><a href="#" class="block py-2 px-4">Department</a></li>
                    <li class="mb-4"><a href="EmployeeAttendanceList.jsp" class="block py-2 px-4 bg-blue-600 rounded">Shift</a></li>
                    <li class="mb-4"><a href="EmployeeList.jsp" class="block py-2 px-4">Employee</a></li>
                    <li class="mb-4"><a href="EmployeeWorkLocation.jsp" class="block py-2 px-4">Location</a></li>
                    <li class="mb-4"><a href="LogoutServlet" class="block py-2 px-4">Logout</a></li>
                </ul>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="flex-1 p-10">
            <h1 class="text-3xl font-bold mb-6">Attendance Records</h1>

            <div class="bg-white shadow-md rounded-lg overflow-hidden">
                <table class="min-w-full">
                    <thead>
                        <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                            <th class="py-3 px-6 text-left">Employee ID</th>
                            <th class="py-3 px-6 text-left">Latitude</th>
                            <th class="py-3 px-6 text-left">Longitude</th>
                            <th class="py-3 px-6 text-left">Address</th>
                        </tr>
                    </thead>
                    <tbody class="text-gray-600 text-sm font-light">
                        <%
                        AttendanceDaoImpl dao = new AttendanceDaoImpl(Dbconnect.getConn());
                        List<Attendance_vo> list = dao.getAllAttendance();
                        for (Attendance_vo a : list) {
                        %>
                        <tr class="">
                            <td class="py-3 px-6 text-left"><%=a.getEmp_id()%></td>
                            <td class="py-3 px-6 text-left"><%=a.getLatitude() %></td>
                            <td class="py-3 px-6 text-left"><%=a.getLongitude() %></td>
                            <td class="py-3 px-6 text-left"><%=a.getAddress() %></td>
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
