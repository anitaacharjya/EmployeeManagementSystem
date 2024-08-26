<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #72edf2 10%, #5151e5 100%);
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center">
    <div class="w-full max-w-md mx-auto mt-10 bg-white rounded-lg shadow-lg overflow-hidden">
        <div class="px-6 py-8">
            <h2 class="text-3xl font-bold text-center text-gray-800 mb-6">Employee Attendance System</h2>
            <form action="ULoginServlet" method="post">
                <div class="mb-4">
                    <c:if test="${not empty Success}">
                        <p class="text-center text-green-600 font-semibold">${Success}</p>
                        <c:remove var="Success" scope="session" />
                    </c:if>
                    <c:if test="${not empty Failed}">
                        <p class="text-center text-red-600 font-semibold">${Failed}</p>
                        <c:remove var="Failed" scope="session" />
                    </c:if>
                </div>
                <div class="mb-4">
                    <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
                    <input type="text" name="emp_id" id="emp_id" required
                           class="block w-full px-3 py-2 mt-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                           placeholder="Employee ID">
                </div>
                <div class="mb-4">
                    <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                    <input type="password" name="password" id="password" required
                           class="block w-full px-3 py-2 mt-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"
                           placeholder="Password">
                </div>
                <div>
                    <button type="submit"
                            class="w-full px-4 py-2 font-bold text-white bg-gradient-to-r from-blue-500 to-blue-600 rounded-md hover:from-blue-600 hover:to-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50">
                        Log in
                    </button>
                </div>
            </form>
        </div>
        <div class="px-6 py-4 bg-gray-100 border-t">
            <p class="text-center text-sm text-gray-600">
                &copy; 2024 Employee Management System. All rights reserved.
            </p>
        </div>
    </div>
</body>
</html>
