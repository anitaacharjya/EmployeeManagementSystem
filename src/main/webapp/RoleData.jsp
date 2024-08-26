<%@page import="java.sql.Connection"%>
<%@page import="com.pcs.employee.vo.User"%>
<%@page import="com.pcs.employee.dao.impl.UserDaoImpl"%>
<%@page import="java.util.List"%>
<%@page import="com.pcs.db.Dbconnect"%>
<%@page import="com.pcs.employee.dao.impl.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String role = request.getParameter("role");
Connection conn = null;
try {
    conn = Dbconnect.getConn();
    UserDaoImpl userDao = new UserDaoImpl(conn);
    List<User> userList = userDao.getUsersByRole(role); // Assuming you have a method to get users by role
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
<title>Role Specific Data</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 h-full">
    <div class="flex h-full">
        <!-- Sidebar -->
        <%@include file="Components/Navbar.jsp"%>

        <!-- Main Content -->
        <div class="flex-1 p-10">
            <div class="bg-white p-4 rounded shadow">
             <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <a href="RoleData.jsp?role=Developer" class="block p-6 bg-white rounded-lg shadow hover:bg-gray-100">
                    <h3 class="text-lg font-semibold mb-2 text-blue-600">Developer</h3>
                    <p>View all Developers</p>
                </a>
                <a href="RoleData.jsp?role=HR" class="block p-6 bg-white rounded-lg shadow hover:bg-gray-100">
                    <h3 class="text-lg font-semibold mb-2 text-green-600">HR</h3>
                    <p>View all HRs</p>
                </a>
                <a href="RoleData.jsp?role=Administrator" class="block p-6 bg-white rounded-lg shadow hover:bg-gray-100">
                    <h3 class="text-lg font-semibold mb-2 text-red-600">Administrator</h3>
                    <p>View all Administrators</p>
                </a>
                <a href="RoleData.jsp?role=BusinessDevelopment" class="block p-6 bg-white rounded-lg shadow hover:bg-gray-100">
                    <h3 class="text-lg font-semibold mb-2 text-yellow-600">Business Development</h3>
                    <p>View all Business Development</p>
                </a>
            </div>
            <a href="Department.jsp" class="block py-2.5 px-6 hover:bg-blue-600 rounded transition duration-200 text-center">Go to Department Page</a>
                <h3 class="text-lg font-semibold mb-4"><%=role%> Employees</h3>
                <table class="w-full">
                    <thead>
                        <tr class="bg-blue-500 text-white">
                            <th class="py-2 px-4 text-left">Id</th>
                            <th class="py-2 px-4 text-left">Name</th>
                            <th class="py-2 px-4 text-left">Email</th>
                            <th class="py-2 px-4 text-left">Mobile Number</th>
                            <th class="py-2 px-4 text-left">Dept Code</th>
                            <th class="py-2 px-4 text-left">Employees</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        List<User> users = (List<User>) request.getAttribute("userList");
                        if (users != null) {
                            for (User user : users) {
                        %>
                        <tr class="border-b border-gray-200 hover:bg-gray-100">
                            <td class="py-3 px-6 text-left whitespace-nowrap"><%=user.getEmp_id()%></td>
                            <td class="py-3 px-6 text-left whitespace-nowrap"><%=user.getName()%></td>
                            <td class="py-3 px-6 text-left whitespace-nowrap"><%=user.getEmail()%></td>
                            <td class="py-3 px-6 text-left whitespace-nowrap"><%=user.getMobileno()%></td>
                            <td class="py-3 px-6 text-left whitespace-nowrap"><%=user.getRole()%></td>
                            <td class="py-3 px-6 text-left whitespace-nowrap"><%=user.getUsername()%></td>
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
</body>
</html>
