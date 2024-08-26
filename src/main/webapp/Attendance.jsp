<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Management System</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
	/* Custom styles for disabled button */
	button:disabled {
		background-color: #d3d3d3; /* Light gray background */
		color: #808080; /* Gray text color */
		cursor: not-allowed; /* Change cursor to not-allowed */
	}
</style>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		// Set system date and time
		var now = new Date();
		var hours = String(now.getHours()).padStart(2, '0');
		var minutes = String(now.getMinutes()).padStart(2, '0');
		var seconds = String(now.getSeconds()).padStart(2, '0');
		var formattedDateTime = hours + ':' + minutes + ':' + seconds;
		document.getElementById("dateTime").value = formattedDateTime;
		document.getElementById("cdateTime").value = formattedDateTime;

		// Get location
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(position) {
				document.getElementById("latitude").value = position.coords.latitude;
				document.getElementById("longitude").value = position.coords.longitude;

				// Perform reverse geolocation lookup
				$.ajax({
					url: 'AttendanceServlet',
					type: 'GET',
					data: {
						lat: position.coords.latitude,
						lon: position.coords.longitude
					},
					success: function(data) {
						$('#address').text(data.display_name);
						document.getElementById("address").value = data.display_name;
						console.log('Address:', data.display_name);
					},
					error: function() {
						alert('Failed to retrieve address.');
					}
				});
			});
		} else {
			alert("Geolocation is not supported by this browser.");
		}

		// Check check-in status
		var checkedInToday = "${checkedInToday}";
		if (checkedInToday === "true") {
			document.getElementById("checkOutButton").disabled = false;
			document.getElementById("workReportSection").style.display = "block";
		} else {
			document.getElementById("checkOutButton").disabled = true;
		}
	});

	function openPopup(popupId) {
		document.getElementById(popupId).style.display = "flex";
	}

	function closePopup(popupId) {
		document.getElementById(popupId).style.display = "none";
	}

	function confirmLogout(event) {
		if (!confirm("Are you sure you want to logout?")) {
			event.preventDefault(); // Prevent default action if cancel is chosen
		} else {
			window.location.href = "LogoutServlet"; // Redirect to logout servlet if confirmed
		}
	}

	function showWorkReportSection() {
		document.getElementById("workReportSection").style.display = "block";
	}
</script>
</head>
<body class="font-sans bg-gray-100 min-h-screen flex flex-col">
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
			<h1 class="mt-5" style="font-size:25px;font-weight:bold">Smart Attendance System</h1>
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
			<h3 class="ml-5 mt-3 text-gray-500" style="font-size:20px;font-weight:bold">Shift Time: 9.30 AM</h3>
		</div>
		<div class="flex justify-center items-center" style="margin-top:200px">
			<button id="checkInButton" class="bg-green-500 text-white rounded-full px-5 py-2 mr-5" onclick="openPopup('checkInPopup')">Check In</button>
			<button id="checkOutButton" class="bg-blue-500 text-white rounded-full px-5 py-2" onclick="openPopup('checkOutPopup')" disabled>Check Out</button>
		</div>
	</div>

	<!-- Check In Popup -->
	<div id="checkInPopup" class="popup fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center hidden">
		<div class="popup-content bg-white p-4 rounded w-11/12 max-w-xs">
			<h2 class="text-lg mb-3">Check In</h2>
			<form action="AttendanceServlet" method="post" onsubmit="showWorkReportSection()">
				<div class="form-group mb-3">
					<input type="text" id="emp_id" name="emp_id" value="${userobj.emp_id}" readonly class="w-full p-2 border rounded">
				</div>
				<div class="form-group mb-3">
					<input type="text" id="dateTime" name="dateTime" readonly class="w-full p-2 border rounded">
				</div>
				<div class="form-group mb-3">
					<select name="workLocation" id="workLocation" class="w-full p-2 border rounded">
						<option value="Office">Office</option>
						<option value="Home">Home</option>
					</select>
				</div>
				<div class="form-group mb-3">
					<select name="shift" id="shift" class="w-full p-2 border rounded">
						<option value="9.30AM">9.30AM</option>
						<option value="12.30PM">12.30PM</option>
						<option value="3.30PM">3.30PM</option>
					</select>
				</div>
				<div class="form-group mb-3">
					<input type="text" id="latitude" name="latitude" readonly class="w-full p-2 border rounded">
				</div>
				<div class="form-group mb-3">
					<input type="text" id="longitude" name="longitude" readonly class="w-full p-2 border rounded">
				</div>
				<div class="form-group mb-3">
					<p id="addressText" class="mb-1"></p>
					<input type="text" id="address" name="address" class="w-full p-2 border rounded">
				</div>
				<input type="hidden" name="action" value="checkin">
				<button type="submit" class="bg-green-500 text-white rounded-full px-4 py-2 mt-2">Check In</button>
				<button type="button" class="bg-red-500 text-white rounded-full px-4 py-2 mt-2" onclick="closePopup('checkInPopup')">Close</button>
			</form>
		</div>
	</div>

	<!-- Check Out Popup -->
	<div id="checkOutPopup" class="popup fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center hidden">
		<div class="popup-content bg-white p-3 rounded w-11/12 max-w-xs">
			<h2 class="text-lg mb-3">Check Out</h2>
			<form action="CheckoutServlet" method="post">
				<input type="hidden" id="emp_id" name="emp_id" value="${userobj.emp_id}">
				<div class="form-group mb-3">
					<label for="cdateTime" class="block mb-1 font-bold">Check Out Date Time:</label>
					<input type="text" id="cdateTime" name="dateTime" readonly class="w-full p-2 border rounded">
				</div>
				<input type="hidden" name="action" value="checkout">
				<button id="checkOutButtonPopup" class="bg-blue-500 text-white rounded-full px-5 py-2">Check Out</button>
				<button type="button" class="bg-red-500 text-white rounded-full px-4 py-2 mt-2" onclick="closePopup('checkOutPopup')">Close</button>
			</form>
		</div>
	</div>
	
	<!-- Work Report Section -->
    <div id="workReportSection" class="flex-1 flex flex-col items-center hidden">
        <div class="header-content text-center w-full px-5">
            <h2 class="mt-5" style="font-size: 25px; font-weight: bold">Add Your Work Report</h2>
        </div>
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
                        <option value="12:00 - 2:00">12:00 - 2:00</option>
                        <option value="2:00 - 4:00">2:00 - 4:00</option>
                        <option value="4:00 - 6:00">4:00 - 6:00</option>
                        <option value="6:00 - 8:00">6:00 - 8:00</option>
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
	<div class="footer bg-blue-500 text-white text-center p-3 fixed bottom-0 w-full">
		<p>&copy; 2024 Employee Management System. All rights reserved.</p>
	</div>
</body>
</html>
