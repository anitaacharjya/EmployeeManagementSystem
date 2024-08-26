<%@ page import="java.time.format.DateTimeParseException"%>
<%@ page import="com.pcs.employee.vo.Attendance_vo"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pcs.db.Dbconnect"%>
<%@ page import="com.pcs.employee.dao.impl.AttendanceDaoImpl"%>
<%@ page import="java.time.LocalTime"%>
<%@ page import="java.time.Duration"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="h-full">
<head>
<meta charset="UTF-8">
<title>Attendance Records</title>
<link
    href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
    rel="stylesheet">
<style>
.bg-sidebar {
    background-color: #2563eb; /* Tailwind's blue-600 */
}

.bg-table-header {
    background-color: #4f46e5; /* Tailwind's blue-700 */
    color: #ffffff; /* White text */
}

.table-row:hover {
    background-color: #e0f2fe; /* Tailwind's blue-100 */
}

.action-icons i {
    transition: transform 0.2s ease-in-out;
}

.action-icons i:hover {
    transform: scale(1.2);
}

.table-container {
    overflow-x: auto;
    max-width: 100%;
}

.table-container table {
    min-width: 100%;
    width: max-content;
}

.table-container thead {
    position: sticky;
    top: 0;
    z-index: 1;
}
</style>
</head>
<body class="bg-gray-100 h-full">
    <div class="flex h-full">
        <!-- Sidebar -->
        <%@ include file="Components/Navbar.jsp"%>

        <!-- Main Content -->
        <div class="flex-1 p-10 overflow-auto">
            <a href="EmployeeAttendanceList.jsp"
                class="inline-block mb-4 py-2.5 px-6 bg-blue-600 text-white hover:bg-blue-700 rounded-full transition duration-200">Go
                Back</a>

            <h1 class="text-3xl font-bold mb-6 text-blue-900">Attendance
                Records</h1>
            <%
                String empId = request.getParameter("emp_id");
                if (empId != null) {
            %>
            <a href="DownloadAttendanceCsv?emp_id=<%=empId%>" 
               class="inline-block py-2.5 px-6 bg-green-600 text-white hover:bg-green-700 rounded-full transition duration-200">Download CSV</a>
            <%
                }
            %>
            <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                <div class="table-container">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-table-header text-gray-200 uppercase text-sm">
                            <tr>
                                <th class="py-3 px-6 text-left">Employee ID</th>
                                <th class="py-3 px-6 text-left">Check-in Time</th>
                                <th class="py-3 px-6 text-left">Check-out Time</th>
                                <th class="py-3 px-6 text-left">Date</th>
                                <th class="py-3 px-6 text-left">Work Mode</th>
                                <th class="py-3 px-6 text-left">Latitude</th>
                                <th class="py-3 px-6 text-left">Longitude</th>
                                <th class="py-3 px-6 text-left">Duration</th>
                                <th class="py-3 px-6 text-left">Work Status</th>
                                <th class="py-3 px-6 text-left">Address</th>
                            </tr>
                        </thead>
                        <tbody class="text-gray-700 text-sm font-light">
                            <%
                            if (empId != null) {
                                AttendanceDaoImpl dao = new AttendanceDaoImpl(Dbconnect.getConn());
                                List<Attendance_vo> list = dao.getAttendanceByEmpId(empId);
                                for (Attendance_vo a : list) {
                            %>
                            <tr class="table-row border-b border-gray-200">
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%=a.getEmp_id()%></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%=a.getCheckin()%></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%=a.getCheckout()%></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%=a.getDate()%></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%=a.getMode()%></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%=a.getLatitude()%></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%=a.getLongitude()%></td>
                                <%
                                String checkin = a.getCheckin();
                                String checkout = a.getCheckout();
                                if (checkin != null && !checkin.isEmpty() && checkout != null && !checkout.isEmpty()) {
                                    try {
                                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
                                        LocalTime checkInTime = LocalTime.parse(checkin, formatter);
                                        LocalTime checkOutTime = LocalTime.parse(checkout, formatter);
                                        Duration duration = Duration.between(checkInTime, checkOutTime);
                                        long hours = duration.toHours();
                                        long minutes = duration.toMinutesPart();
                                        boolean isNineHoursCompleted = duration.toMinutes() >= 540; // 9 hours = 540 minutes
                                %>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%=hours%>
                                    hours <%=minutes%> minutes</td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%=isNineHoursCompleted ? "Met" : "Not Met"%>
                                </td>
                                <%
                                } catch (DateTimeParseException e) {
                                // Handle parsing exception (e.g., log, display an error message)
                                out.println("<td class=\"py-3 px-6 text-left whitespace-nowrap\">Invalid time format</td>");
                                out.println("<td class=\"py-3 px-6 text-left whitespace-nowrap\">N/A</td>"); // Placeholder for work status
                                }
                                } else {
                                %>
                                <td class="py-3 px-6 text-left whitespace-nowrap">N/A</td>
                                <td class="py-3 px-6 text-left whitespace-nowrap">N/A</td>
                                <!-- Placeholder for work status -->
                                <%
                                }
                                %>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%=a.getAddress()%></td>

                            </tr>
                            <%
                            }
                            } else {
                            %>
                            <tr>
                                <td colspan="10" class="py-3 px-6 text-center">No Employee
                                    ID provided.</td>
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
