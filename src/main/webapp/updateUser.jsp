<%@page import="com.pcs.db.Dbconnect"%>
<%@ page import="com.pcs.employee.vo.User" %>
<%@ page import="com.pcs.employee.dao.impl.UserDaoImpl" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>

<%
    String username = request.getParameter("username");
    User user = null;
    Connection conn = null;
    try {
        conn = Dbconnect.getConn();

        UserDaoImpl userDao = new UserDaoImpl(conn);
        user = userDao.getUserByUsername(username);
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
    <title>Update User</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 flex items-center justify-center h-full" style="margin-top: 200px;">
    <div class="w-full max-w-2xl bg-white p-8 rounded shadow-lg">
        <div class="text-center mb-8">
            <img src="Images/logo.jpg" alt="logo" class="h-16 lg:h-20 mx-auto mb-4">
            <h1 class="text-3xl font-bold text-blue-600">Update User</h1>
        </div>
        <form action="updateUserAction.jsp" method="post" class="space-y-6">
            <input type="hidden" name="username" value="<%= user.getUsername() %>">
            
            <div class="mb-4">
                <label class="block text-gray-700 font-medium">Name</label>
                <input type="text" name="name" value="<%= user.getName() %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
            </div>
            
            <div class="mb-4">
                <label class="block text-gray-700 font-medium">Gender</label>
                <input type="text" name="gender" value="<%= user.getGender() %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
            </div>
            
            <div class="mb-4">
                <label class="block text-gray-700 font-medium">DOB</label>
                <input type="date" name="dob" value="<%= user.getDob() %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
            </div>
            
            <div class="mb-4">
                <label class="block text-gray-700 font-medium">Employee ID</label>
                <input type="text" name="emp_id" value="<%= user.getEmp_id() %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
            </div>
            
            <div class="mb-4">
                <label class="block text-gray-700 font-medium">DOJ</label>
                <input type="date" name="doj" value="<%= user.getDoj() %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
            </div>
            
            <div class="mb-4">
                <label class="block text-gray-700 font-medium">Email</label>
                <input type="email" name="email" value="<%= user.getEmail() %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
            </div>
            
            <div class="mb-4">
                <label class="block text-gray-700 font-medium">Mobile No</label>
                <input type="tel" name="mobileno" value="<%= user.getMobileno() %>" pattern="[0-9]{10}" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
            </div>
            
            <div class="mb-4">
                <label class="block text-gray-700 font-medium">Address</label>
                <input type="text" name="address" value="<%= user.getAddress() %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
            </div>
            
            <div class="mb-4">
                <label class="block text-gray-700 font-medium">Password</label>
                <input type="password" name="password" value="<%= user.getPassword() %>" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500">
            </div>
            
            <button type="submit" class="w-full bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded-md">Update</button>
        </form>
    </div>
</body>
</html>
