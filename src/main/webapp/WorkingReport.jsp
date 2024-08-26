<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Management System</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">

<script type="text/javascript">

function confirmLogout(event) {
	if (!confirm("Are you sure you want to logout?")) {
		event.preventDefault(); // Prevent default action if cancel is chosen
	} else {
		window.location.href = "LogoutServlet"; // Redirect to logout servlet if confirmed
	}
}

</script>
</head>
<body>
<div class="navbar bg-blue-500 text-white p-3 flex justify-between items-center">
		<div class="navbar-logo flex items-center">
			<img src="Images/logo.jpg" alt="logo" class="h-10"> 
			<span class="ml-3 font-bold text-xl">Employee Management System</span>
		</div>
		<ul class="flex gap-5">
			<li>
				<a href="Home.jsp" class="text-white no-underline text-lg px-4 py-2 rounded hover:bg-blue-600"><i class="fa-solid fa-house"></i>Home</a>
			</li>
			<li>
				<a href="#" class="text-white no-underline text-lg px-4 py-2 rounded hover:bg-blue-600" onclick="confirmLogout(event)">Logout</a>
			</li>
		</ul>
	</div>
	<div class="flex-1 flex flex-col items-center">
		<div class="header-content text-center w-full px-5">
			<h1 class="mt-5" style="font-size:25px;font-weight:bold">Daily Working Report</h1>
			<div class="title col-md-12 mt-2">
				<c:if test="${not empty Success}">
					<h3 class="text-green-500" style="font-size:15px;font-weight:bold">${Success}</h3>
					<c:remove var="Success" scope="session" />
				</c:if>
				<c:if test="${not empty Failed}">
					<h3 class="text-red-500" style="font-size:15px;font-weight:bold">${Failed}</h3>
					<c:remove var="Failed" scope="session" />
				</c:if>
			</div>
		</div>
		<div class="header-content text-left w-full px-5">
			<h2 class="ml-5" style="font-size:25px;font-weight:bold">Welcome ${userobj.name}</h2>
			<h3 class="ml-5 mt-3 text-gray-500" style="font-size:20px;font-weight:bold">Employee Code: ${userobj.emp_id}</h3>
<!-- 			<h3 class="ml-5 mt-3 text-gray-500" style="font-size:20px;font-weight:bold">Shift Time: 9.30 AM</h3>
 -->		</div>
<!-- Work Report Section -->
    <div id="workReportSection" class="flex-1 flex flex-col items-center w-full max-w-4xl border border-gray-300 p-5 mt-5">
        <!--  <div class="header-content text-center w-full px-5">
            <h2 class="mt-5" style="font-size: 25px; font-weight: bold">Add Your Work Report</h2>
        </div> -->
        <div class="w-full px-5 pb-10">
            <form action="WorkReportServlet" method="post" class="w-full max-w-lg mx-auto">
                <input type="hidden" name="emp_id" value="${userobj.emp_id}">
                <div class="mb-4">
                    <label for="reportDate" class="block text-gray-700 font-bold mb-2">Date:</label>
                    <input type="text" id="reportDate" name="reportDate" required class="w-full p-2 border rounded" readonly>
                </div>
                 <script>
                    // Get today's date in YYYY-MM-DD format
                    const today = new Date().toISOString().split('T')[0];
                    document.getElementById('reportDate').value = today;
                </script> 
                <div class="mb-4">
                    <label for="timeSlot" class="block text-gray-700 font-bold mb-2">Time Slot:</label>
                    <select id="timeSlot" name="timeSlot" required class="w-full p-2 border rounded">
                        <option value="9.30AM-5.30PM">9.30AM-5.30PM</option>
						<option value="5.30PM-1.30AM">5.30PM-1.30AM</option>
						<option value="1.30AM-9.30AM">1.30AM-9.30AM</option>
                    </select>
                </div>
                 
                <div class="mb-4">
                    <label for="taskCategory" class="block text-gray-700 font-bold mb-2">Task Category:</label>
                    <input type="text" id="taskCategory" name="taskCategory" required class="w-full p-2 border rounded">
                </div>
                <div class="mb-4">
                    <label for="taskDetails" class="block text-gray-700 font-bold mb-2">Task Details:</label>
                    <textarea id="taskDetails" name="taskDetails" rows="4" required class="w-full p-2 border rounded"></textarea>
                </div>
                <button type="submit" class="bg-green-500 text-white rounded-full px-4 py-2">Submit Report</button>
            </form>
        </div>
    </div>
    <!-- Footer -->
	<div class="footer bg-blue-500 text-white text-center p-3 mt-10 w-full">
		<p>&copy; 2024 Employee Management System. All rights reserved.</p>
	</div>
</body>
</html>
