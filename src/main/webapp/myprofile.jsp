<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="com.pcs.db.Dbconnect" %>
<%@ page import="com.pcs.employee.vo.User" %>
<%@ page import="com.pcs.employee.dao.impl.UserDaoImpl" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Management System</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
<!-- Tailwind CSS -->
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: Arial, sans-serif;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	margin: 0;
}

.sidebar {
	background-color: #007bff;
	color: white;
	width: 250px;
	position: fixed;
	left: 0;
	top: 0;
	bottom: 0;
	overflow-y: auto;
	z-index: 1000;
}

.sidebar-header {
	font-size: 1.5em;
	font-weight: bold;
	margin: 20px 0 10px 20px;
}

.sidebar-menu {
	list-style-type: none;
	padding: 0;
}

.sidebar-menu li {
	margin-bottom: 10px;
}

.sidebar-menu a {
	color: white;
	text-decoration: none;
	display: block;
	padding: 8px 16px;
	border-radius: 4px;
	text-transform: uppercase;
}

.sidebar-menu a:hover {
	background-color: rgba(255, 255, 255, 0.2);
}

.main-content {
	flex: 1;
	padding: 20px;
	background-color: #f0f0f0;
	color: gray;
	margin-left: 250px;
}

.calendar-container {
	white-space: nowrap;
	text-align: center;
	display: flex;
	justify-content: flex-start;
	flex-wrap: wrap;
	margin-top: 20px;
	overflow: hidden;
}

.calendar {
	width: 100%;
	max-width: 1200px;
	background-color: white;
	color: #333;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	vertical-align: top;
	margin-right: 20px;
	margin-bottom: 20px;
}

.calendar table {
	border-collapse: collapse;
	width: 100%;
}

.calendar th, .calendar td {
	padding: 10px;
	text-align: center;
	border: 1px solid #ccc;
	height: 80px;
	vertical-align: top;
}

.calendar th {
	background-color: #007bff;
	color: white;
}

.calendar .today {
	background-color: #007bff;
	color: white;
	font-weight: bold;
}

.calendar-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px;
}

.calendar-header .icon {
	cursor: pointer;
	color: #007bff;
}

.dot {
	height: 10px;
	width: 10px;
	border-radius: 50%;
	display: inline-block;
	margin-top: 5px;
}

.dot.green {
	background-color: green;
}

.dot.red {
	background-color: red;
}

.dot.blue {
	background-color: blue;
}

.time {
	font-size: 0.8em;
	margin-top: 5px;
}

.legend {
	display: flex;
	justify-content: space-around;
	margin: 10px 0;
}

.legend div {
	display: flex;
	align-items: center;
}

.legend .dot {
	margin-right: 5px;
}
</style>
</head>
<body class="bg-gray-100">
 <%
    User u = (User) session.getAttribute("userobj");
    String empid = u.getEmp_id();
    System.out.println("empid : "+empid);
    List<User> userlist = null;
    if (empid != null) {
        Connection conn = new Dbconnect().getConn();
        UserDaoImpl leaveDao = new UserDaoImpl(conn);
        userlist = leaveDao.getAllUsersByEmp_Id(empid);
    }
    %>
    <div class="flex">
       <div class="sidebar">
		<div class="sidebar-header">
			<i class='bx bxs-user'><i class='bx bx-check'></i></i>PCS
		</div>
		<ul class="sidebar-menu" style="margin-top: 40px;">
			<li style="font-weight: bold; margin-left: 20px;">ATTENDANCE</li>
			<li><a href="Attendance.jsp"><i class='bx bx-detail'></i>Attendance
					Form</a></li>
			<li><a href="WorkingReport.jsp"><i class='bx bx-detail'></i>Working
					Report</a></li>
			<li style="font-weight: bold; margin-left: 20px;">LEAVE</li>
			<li><a href="LeaveApplication.jsp"><i class='bx bx-calendar'></i>Leave
					Application</a></li>
			<li><a href="LeaveApplication.jsp"><i class='bx bx-calendar'></i>Leave
					Reports</a></li>
			<li style="font-weight: bold; margin-left: 20px;">PROFILE</li>
			<li><a href="myprofile.jsp"><i class='bx bx-id-card'></i>My
					Profile</a></li>
		</ul>
	</div>
        <div class="flex-1 ml-64 p-6">
            <div class="container mx-auto">
                <div class="header flex justify-between items-center mb-6">
                    <div class="logo flex items-center">
                        <img src="Images/logo.jpg" alt="logo" class="h-10"/>
                    </div>
                    <div class="user-info flex items-center">
                        <span class="initials text-xl font-bold text-blue-500 ml-3" id="userName">${userobj.name}</span>
                        <div class="relative ml-5">
                            <button class="dropdown-button px-4 py-2 bg-white text-blue-500 rounded-md shadow focus:outline-none" id="dropdownMenuButton">
                                <i class='bx bx-chevron-down'></i>
                            </button>
                            <div class="dropdown-menu absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg z-50 hidden" aria-labelledby="dropdownMenuButton">
                                <a class="block px-4 py-2 text-gray-800 hover:bg-gray-200" href="#" data-toggle="modal" data-target="#logoutModal">Logout</a>
                            </div>
                        </div>
                    </div>
                </div>
               
                <!-- Main Content -->
    <div class="flex-1 p-10 flex justify-center items-center">
        <div class="container mx-auto bg-white p-8 rounded shadow-lg w-full max-w-6xl">
             <div class="text-center mb-8">
                <h2 class="text-2xl font-bold text-gray-800">Employee Details</h2>
            </div> 
            <form >
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                <%
                            if (userlist != null) {
                                for (User user : userlist) {
                            %>
                    <div>
                        <label for="name" class="block text-sm font-medium text-gray-700">Name:</label>
                        <input type="text" id="name" name="name" value="<%=user.getName()%>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="dob" class="block text-sm font-medium text-gray-700">Date of Birth:</label>
                        <input type="date" id="dob" name="dob"  value="<%= user.getDob() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="gender" class="block text-sm font-medium text-gray-700">Gender:</label>
                        <input id="gender" name="gender" value="<%= user.getGender() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                            
                        </input>
                    </div>

                    <div>
                        <label for="address" class="block text-sm font-medium text-gray-700">Address:</label>
                        <input id="address" name="address" value="<%= user.getAddress() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm"></textarea>
                    </div>

                    <div>
                        <label for="city" class="block text-sm font-medium text-gray-700">City:</label>
                        <input type="text" id="city" name="city" value="<%= user.getCity() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="state" class="block text-sm font-medium text-gray-700">State:</label>
                        <input type="text" id="state" name="state" value="<%= user.getState() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="country" class="block text-sm font-medium text-gray-700">Country:</label>
                        <input type="text" id="country" name="country" value="<%= user.getCountry() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="marital_status" class="block text-sm font-medium text-gray-700">Marital Status:</label>
                        <input id="marital_status" name="marital_status" value="<%= user.getMaritalStatus() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                            
                        </input>
                    </div>

                    <div>
                        <label for="nationality" class="block text-sm font-medium text-gray-700">Nationality:</label>
                        <input type="text" id="nationality" name="nationality" value="<%= user.getNationality() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="email" class="block text-sm font-medium text-gray-700">Email:</label>
                        <input type="email" id="email" name="email" value="<%= user.getEmail() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="mobile" class="block text-sm font-medium text-gray-700">Mobile No:</label>
                        <input type="tel" id="mobile" name="mobile" pattern="[0-9]{10}" value="<%= user.getMobileno() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="telephone" class="block text-sm font-medium text-gray-700">Telephone:</label>
                        <input type="tel" id="telephone" name="telephone" value="<%= user.getTelephone() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="identity_document" class="block text-sm font-medium text-gray-700">Identity Document:</label>
                        <input id="identity_document" name="identity_document" value="<%= user.getIdentityDocument() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                            
                        </input>
                    </div>

                    <div>
                        <label for="identity_number" class="block text-sm font-medium text-gray-700">Identity Number:</label>
                        <input type="text" id="identity_number" name="identity_number" value="<%= user.getIdentityNumber() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="employment_type" class="block text-sm font-medium text-gray-700">Employment Type:</label>
                        <input id="employment_type" name="employment_type" value="<%= user.getEmploymentType() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                                                    </input>
                    </div>

                    <div>
                        <label for="joining_date" class="block text-sm font-medium text-gray-700">Joining Date:</label>
                        <input type="date" id="joining_date" name="joining_date" value="<%= user.getDoj() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="blood_group" class="block text-sm font-medium text-gray-700">Blood Group:</label>
                        <input type="text" id="blood_group" name="blood_group" value="<%= user.getBloodGroup() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="designation" class="block text-sm font-medium text-gray-700">Designation:</label>
                        <input type="text" id="designation" name="designation" value="<%= user.getDesignation() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="department" class="block text-sm font-medium text-gray-700">Department:</label>
                        <input type="text" id="department" name="department" value="<%= user.getDepartment() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>
                    <div>
                        <label for="department" class="block text-sm font-medium text-gray-700">Emplyee ID:</label>
                        <input type="text" id="emp_id" name="emp_id" value="<%= user.getEmp_id() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>
                    <div>
                        <label for="department" class="block text-sm font-medium text-gray-700">Role:</label>
                        <input type="text" id="role" name="role" value="<%= user.getRole() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="pan_number" class="block text-sm font-medium text-gray-700">PAN Number:</label>
                        <input type="text" id="pan_number" name="pan_number" value="<%= user.getPanNumber() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="bank_name" class="block text-sm font-medium text-gray-700">Bank Name:</label>
                        <input type="text" id="bank_name" name="bank_name" value="<%= user.getBankName() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="bank_account_number" class="block text-sm font-medium text-gray-700">Bank Account Number:</label>
                        <input type="text" id="bank_account_number" name="bank_account_number" value="<%= user.getBankAccountNumber() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="ifsc_code" class="block text-sm font-medium text-gray-700">IFSC Code:</label>
                        <input type="text" id="ifsc_code" name="ifsc_code" value="<%= user.getIfscCode() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="pf_account_number" class="block text-sm font-medium text-gray-700">PF Account Number:</label>
                        <input type="text" id="pf_account_number" name="pf_account_number" value="<%= user.getPfAccountNumber() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>
                     <div>
                        <label for="username" class="block text-sm font-medium text-gray-700">Username:</label>
                        <input type="text" id="username" name="username" value="<%= user.getUsername() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>

                    <div>
                        <label for="password" class="block text-sm font-medium text-gray-700">Password:</label>
                        <input type="text" id="password" name="password" value="<%= user.getPassword() %>" readonly
                            class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 sm:text-sm">
                    </div>
                </div>
                <%
                                }
                            }
                            %>

                 <div class="mt-4">
                    <input type="submit" value="Update"
                        class="bg-green-500 hover:bg-yellow-600 text-white font-bold py-2 px-4 rounded">
                    
                </div> 
            </form>
        </div>
    </div>
    
                
                
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var userName = '${userobj.name}';
           

            document.getElementById('userName').innerText = initials;
        });
        
        document.getElementById('dropdownMenuButton').addEventListener('click', function() {
            var dropdown = this.nextElementSibling;
            dropdown.classList.toggle('hidden');
        });
    </script>
</body>
</html>
