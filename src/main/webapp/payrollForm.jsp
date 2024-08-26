<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payroll Form</title>
    <link rel="stylesheet" href="css/styles.css">
    <link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
	rel="stylesheet">
    <style type="text/css">
    /* styles.css */

body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 600px;
    margin: 50px auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 5px;
}

h2 {
    text-align: center;
    /* color: #333; */
}

form {
    display: flex;
    flex-direction: column;
}

label {
    margin-bottom: 5px;
    color: #333;
    font-weight: bold;
}

input[type="text"], input[type="number"] {
    padding: 10px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 16px;
}

input[type="submit"] {
    background-color: #28a745;
    color: #fff;
    padding: 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
}

input[type="submit"]:hover {
    background-color: #218838;
}

.success-message {
    text-align: center;
    color: #28a745;
    font-size: 18px;
    margin-top: 20px;
}
    
    
    </style>
</head>
<body class="bg-gray-100 h-full">
<div class="flex h-full">
<!-- Sidebar -->
		<%@include file="Components/Navbar.jsp"%>
    <div class="container">
    <div class="title col-md-12 mt-2">
					<c:if test="${not empty Success}">
						<h3 class="text-green-500"
							style="font-size: 15px; font-weight: bold">${Success}</h3>
						<c:remove var="Success" scope="session" ></c:remove>
					</c:if>
					<c:if test="${not empty Failed}">
						<h3 class="text-red-500"
							style="font-size: 15px; font-weight: bold">${Failed}</h3>
						<c:remove var="Failed" scope="session" />
					</c:if>
				</div>
        <h2>Employee Payroll Form</h2>
        <form action="processPayroll" method="post">
            <label for="employeeId">Employee ID:</label>
            <input type="text" id="employeeId" name="employeeId" required>
            
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            
            <label for="department">Department:</label>
            <input type="text" id="department" name="department" required>
            
            <label for="basicSalary">Basic Salary:</label>
            <input type="number" id="basicSalary" name="basicSalary" step="0.01" required>
            
             <label for="govtstipend">Govt Stipend:</label>
            <input type="number" id="govtstipend" name="govtstipend" step="0.01" required>
            
            <label for="hra">HRA:</label>
            <input type="number" id="hra" name="hra" step="0.01" required>
            
            <label for="allowances">Allowances:</label>
            <input type="number" id="allowances" name="allowances" step="0.01" required>
            
            <label for="deductions">Deductions:</label>
            <input type="number" id="deductions" name="deductions" step="0.01" required>
            
            <input type="submit" value="Process Payroll">
        </form>
    </div>
    </div>
</body>
</html>
