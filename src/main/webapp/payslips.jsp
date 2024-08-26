<%@ page import="java.util.List" %>
<%@ page import="com.pcs.employee.vo.PayRoll" %>
<%@ page import="com.pcs.employee.dao.impl.PayrollService" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payslips</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .payslip-container {
            width: 700px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #000;
            border-radius: 10px;
            background-color: #fff;
            font-family: Arial, sans-serif;
            color: #333;
        }
        .header, .footer {
            text-align: center;
            margin-bottom: 20px;
        }
        .header h1 {
            font-size: 20px;
            font-weight: bold;
            margin: 0;
        }
        .header p {
            margin: 5px 0;
        }
        .employee-details, .salary-details {
            width: 100%;
            margin-bottom: 20px;
        }
        .employee-details td, .salary-details td {
            padding: 5px;
        }
        .salary-details th {
            text-align: left;
            padding: 10px 5px;
            border-bottom: 1px solid #000;
        }
        .salary-details td {
            padding: 10px 5px;
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
                    <h3 class="text-green-500" style="font-size: 15px; font-weight: bold">${Success}</h3>
                    <c:remove var="Success" scope="session"></c:remove>
                </c:if>
                <c:if test="${not empty Failed}">
                    <h3 class="text-red-500" style="font-size: 15px; font-weight: bold">${Failed}</h3>
                    <c:remove var="Failed" scope="session"></c:remove>
                </c:if>
            </div>
            <h2 style="margin-left:50px;margin-top:50px;font-weight:bold;font-size:25px;color:blue">Employee's Payslips</h2>
            
            <!-- Filter Form -->
            <form method="GET" action="payslips.jsp">
                <label for="month" style="margin-left:50px;margin-top:50px;font-weight:bold;font-size:15px;color:blue">Month:</label>
                <select name="month" id="month">
                    <option value="01">January</option>
                    <option value="02">February</option>
                    <option value="03">March</option>
                    <option value="04">April</option>
                    <option value="05">May</option>
                    <option value="06">June</option>
                    <option value="07">July</option>
                    <option value="08">August</option>
                    <option value="09">September</option>
                    <option value="10">October</option>
                    <option value="11">November</option>
                    <option value="12">December</option>
                </select>

                <label for="year"style="margin-top:50px;font-weight:bold;font-size:15px;color:blue">Year:</label>
                <select name="year" id="year">
                    <option value="2024">2024</option>
                    <option value="2023">2023</option>
                    <!-- Add more years as needed -->
                </select>

                <button type="button" class="bg-red-500 text-white rounded-full px-4 py-2 mt-2">Filter</button>
            </form>

            <%
                // Retrieve the selected month and year from the request
                String month = request.getParameter("month");
                String year = request.getParameter("year");

                PayrollService payrollService = new PayrollService();
                List<PayRoll> payrolls;

                // If month and year are provided, filter the payslips
                if (month != null && year != null) {
                    payrolls = payrollService.getPayrollsByMonthAndYear(month, year);
                } else {
                    // If no filter is applied, show all payslips
                    payrolls = payrollService.getAllPayrolls();
                }
                
                

                // Display the filtered payslips
                for (PayRoll payroll : payrolls) {
            %>
                <div class="payslip-container">
        <div class="header">
            <h1><img src="Images/logo.jpg" alt="Girl in a jacket" width="150" height="250">Perennation Computer Solutions Global Private Limited</h1>
            <p>Kolkata: ZIOKS, 11th, Godrej Genesis Building, EP Block, Sector V, Bidhannagar, Kolkata, West Bengal 700091</p>
            <p>Bengaluru: 57/65, Chikkalakshmaiah Layout, Hosur main road, Bengaluru, Karnataka 560029</p>
            <p>Website: www.pcsglobal.in</p>
        </div>

<%--          <h2 class="text-center text-xl font-bold">Pay Slip for the Month of <%= payroll.getMonth() %>, <%= payroll.getYear() %></h2> 
 --%>
        <table class="employee-details">
            <tr>
                <td><strong>Employee Name:</strong> <%= payroll.getName() %></td>
                <td><strong>Employee No:</strong> <%= payroll.getEmployeeId() %></td>
            </tr>
            <tr>
                 <td><strong>Designation:</strong> <%= payroll.getDesignation() %></td> 
                <td><strong>Payment Date:</strong> <%= payroll.getPaymentDate() %></td>
            </tr>
            <tr>
                <%-- <td><strong>Pay Period:</strong> <%= payroll.getPayPeriodStart() %> to <%= payroll.getPayPeriodEnd() %></td>--%>
                <td><strong>Bank Name:</strong> <%= payroll.getBankName() %></td> 
            </tr>
            <tr>
                <td><strong>Account Number:</strong> <%= payroll.getBankAccountNumber() %></td> 
                 <td><strong>PF Number:</strong> <%= payroll.getPfAccountNumber() %></td> 
            </tr>
        </table>

        <table class="salary-details" border="1" cellspacing="0" cellpadding="0">
            <tr>
                <th>Earnings</th>
                <th>Amount (INR)</th>
            </tr>
            <tr>
                <td>Basic Salary</td>
                <td><%= payroll.getBasicSalary() %></td>
            </tr>
            <tr>
                <td>Goverment Stipend</td>
                <td><%= payroll.getGovtStipend() %></td>
            </tr>
            <tr>
                <td>HRA</td>
                <td><%= payroll.getHra() %></td>
            </tr>
            <tr>
                <td>Allowances</td>
                <td><%= payroll.getAllowances() %></td>
            </tr>
            <tr>
                <td>Deductions</td>
                <td><%= payroll.getDeductions() %></td>
            </tr>
            
            
            <tr>
                <td>P.Tax</td>
                <td>NA</td>
            </tr>
            <tr>
                <td>PF</td>
                <td>NA</td>
            </tr>
            <tr>
                <th></th>
                <th></th>
            </tr>
            <tr>
                <td>Net Salary</td>
                <td><%= payroll.getBasicSalary() + payroll.getGovtStipend()+payroll.getHra() + payroll.getAllowances() - payroll.getDeductions() %></td>
            </tr>
        </table>

        <div class="footer">
            <p>Computer-generated salary slip does not require a signature</p>
            <p>http://www.pcsglobal.in/</p>
        </div>
<a href="downloadPayslip?name=<%= payroll.getName() %>&employeeId=<%= payroll.getEmployeeId() %>&paymentDate=<%= payroll.getPaymentDate() %>&basicSalary=<%= payroll.getBasicSalary() %>&hra=<%= payroll.getHra() %>&allowances=<%= payroll.getAllowances() %>&deductions=<%= payroll.getDeductions() %>"><i class="fa-solid fa-download"></i> Download Payslip as PDF</a>
        
    </div>
            <%
                }
            %>
        </div>  
    </div>  
</body>
</html>
