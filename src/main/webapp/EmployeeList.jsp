<%@ page import="com.pcs.db.Dbconnect"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pcs.employee.vo.User"%>
<%@ page import="com.pcs.employee.dao.impl.UserDaoImpl"%>
<%@ page import="java.sql.Connection"%>

<%
String searchQuery = request.getParameter("searchQuery");
Connection conn = null;
List<User> userList = null;
try {
    conn = Dbconnect.getConn();
    UserDaoImpl userDao = new UserDaoImpl(conn);
    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        userList = userDao.searchUsers(searchQuery);
    } else {
        userList = userDao.getAllUsers();
    }
    request.setAttribute("userList", userList);
} catch (Exception e) {
    e.printStackTrace();
} 
%>

<!DOCTYPE html>
<html class="h-full">
<head>
<meta charset="UTF-8">
<title>Employee</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
<style>
    .table-header {
        background-color: #4f46e5;
        color: #fff;
    }
    .table-row:hover {
        background-color: #e0f2fe;
    }
    .search-input {
        border-radius: 9999px;
    }
    .action-icons i {
        transition: transform 0.2s ease-in-out;
    }
    .action-icons i:hover {
        transform: scale(1.2);
    }
</style>
</head>
<body class="bg-gradient-to-r from-blue-100 to-blue-200 h-full">
    <div class="flex h-full">
        <!-- Sidebar -->
       <%@include file="Components/Navbar.jsp"%>

        <!-- Main Content -->
        <div class="flex-1 p-10 overflow-auto">
            <h1 class="text-4xl font-bold mb-8 text-blue-900">Employee</h1>

            <a href="register.jsp" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full mb-6 inline-block shadow-md">
                <i class="fas fa-plus mr-2"></i> Add New Employee
            </a>

            <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                <div class="p-4 flex justify-between items-center border-b bg-gray-100">
                    <form action="EmployeeList.jsp" method="get">
                        <label for="search" class="text-gray-700 font-semibold">Search:</label>
                        <input type="text" id="search" name="searchQuery" value="<%= searchQuery != null ? searchQuery : "" %>" class="search-input border rounded-full px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-600">
                        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full ml-2">Search</button>
                    </form>
                </div>
                <div class="overflow-x-auto">
                    <table class="min-w-full leading-normal">
                        <thead>
                            <tr class="table-header text-gray-200 uppercase text-sm leading-normal">
                                <th class="py-3 px-6 text-left">ID</th>
                                <th class="py-3 px-6 text-left">Name</th>
                                <th class="py-3 px-6 text-left">DOB</th>
                                <th class="py-3 px-6 text-left">Gender</th>
                                <th class="py-3 px-6 text-left">Address</th>
                                <th class="py-3 px-6 text-left">City</th>
                                <th class="py-3 px-6 text-left">State</th>
                                <th class="py-3 px-6 text-left">Country</th>
                                <th class="py-3 px-6 text-left">Marital Status</th>
                                <th class="py-3 px-6 text-left">Nationality</th>
                                <th class="py-3 px-6 text-left">Mobile No</th>
                                <th class="py-3 px-6 text-left">Telephone</th>
                                <th class="py-3 px-6 text-left">Identity Document</th>
                                <th class="py-3 px-6 text-left">Identity Number</th>
                                <th class="py-3 px-6 text-left">Employment Type</th>
                                <th class="py-3 px-6 text-left">Date of Joining</th>
                                <th class="py-3 px-6 text-left">Blood Group</th>
                                <th class="py-3 px-6 text-left">Designation</th>
                                <th class="py-3 px-6 text-left">Department</th>
                                <th class="py-3 px-6 text-left">PAN Number</th>
                                <th class="py-3 px-6 text-left">Bank Name</th>
                                <th class="py-3 px-6 text-left">Bank Account Number</th>
                                <th class="py-3 px-6 text-left">IFSC Code</th>
                                <th class="py-3 px-6 text-left">PF Account Number</th>
                                <th class="py-3 px-6 text-left">Username</th>
                                <th class="py-3 px-6 text-left">Password</th>
                                <th class="py-3 px-6 text-center">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="text-gray-700 text-sm font-light">
                            <%
                            List<User> users = (List<User>) request.getAttribute("userList");
                            if (users != null) {
                                for (User user : users) {
                            %>
                            <tr class="table-row border-b border-gray-200">
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getEmp_id() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getName() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getDob() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getGender() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getAddress() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getCity() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getState() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getCountry() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getMaritalStatus() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getNationality() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getMobileno() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getTelephone() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getIdentityDocument() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getIdentityNumber() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getEmploymentType() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getDoj() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getBloodGroup() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getDesignation() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getDepartment() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getPanNumber() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getBankName() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getBankAccountNumber() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getIfscCode() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getPfAccountNumber() %></td>
                                <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getUsername() %></td>
                                 <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getPassword() %></td>
                           <%--      <td class="py-3 px-6 text-left whitespace-nowrap"><%= user.getRole() %></td> --%>
                                     <td class="py-3 px-6 text-center whitespace-nowrap">
                                    <div class="flex items-center justify-center action-icons">
                                        <a href="updateUser.jsp?username=<%= user.getUsername() %>" class="w-4 mr-2 transform hover:text-blue-600">
                                            <i class="fas fa-edit"></i>
                                        </a> 
                                        <a href="deleteUser.jsp?username=<%= user.getUsername() %>" class="w-4 mr-2 transform hover:text-red-600">
                                            <i class="fas fa-trash-alt"></i>
                                        </a>
                                    </div>
                                </td>
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
    </div>
</body>
</html>