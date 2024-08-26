<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page
	import="java.time.LocalDate,java.time.LocalTime,java.time.Duration, java.time.YearMonth, java.util.Calendar, java.util.Map, java.util.HashMap"%>
<%@ page
	import="java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.Connection, java.sql.SQLException"%>
<%@ page import="com.pcs.db.Dbconnect"%>
<%@ page import="com.pcs.employee.dao.impl.AttendanceDaoImpl"%>
<%@ page import="com.pcs.employee.vo.Attendance_vo"%>
<%@ page import="com.pcs.employee.vo.User"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Employee Management System</title>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
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
<body>
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
	<div class="main-content">
		<ul>
			<img src="Images/logo.jpg" alt="logo" style="height: 40px" />
		</ul>
		<h2>Attendance Calendar</h2>

		<div class="legend">
			<div>
				<span class="dot green"></span>Present
			</div>
			<div>
				<span class="dot red"></span>Absent
			</div>
			<div>
				<span class="dot blue"></span>Weekly Off
			</div>
		</div>

		<div id="calendars" class="calendar-container">
			<%
			// Ensure default values if parameters are missing or invalid
			String yearParam = request.getParameter("year");
			String monthParam = request.getParameter("month");

			int year;
			int month;

			try {
				year = Integer.parseInt(yearParam);
			} catch (Exception e) {
				year = LocalDate.now().getYear();
			}

			try {
				month = Integer.parseInt(monthParam);
			} catch (Exception e) {
				month = LocalDate.now().getMonthValue();
			}

			if (month < 1) {
				month = 12;
				year--;
			} else if (month > 12) {
				month = 1;
				year++;
			}

			YearMonth yearMonth = YearMonth.of(year, month);
			int daysInMonth = yearMonth.lengthOfMonth();
			LocalDate today = LocalDate.now();
			Calendar calendar = Calendar.getInstance();
			calendar.set(year, month - 1, 1);

			String[] months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October",
					"November", "December" };

			// Database connection and data retrieval

			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			Map<String, String[]> attendanceMap = new HashMap<>();

			// Retrieve logged-in user's ID from session
			//String emp_id = (String) session.getAttribute("emp_id");
			HttpSession session2 = request.getSession();
			User user = (User) session2.getAttribute("userobj");
			String emp_id = user.getEmp_id();
			System.out.println("emp_id : " + emp_id);

			try {
				conn = Dbconnect.getConn();

				// Modify query to include user ID
				String query = "SELECT date, checkin_time, checkout_time FROM attendance WHERE emp_id = ? AND YEAR(date) = ? AND MONTH(date) = ?";

				pstmt = conn.prepareStatement(query);
				System.out.println(pstmt);
				pstmt.setString(1, emp_id);
				pstmt.setInt(2, year);
				pstmt.setInt(3, month);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					String date = rs.getString("date");
					String checkInTime = rs.getString("checkin_time");
					String checkOutTime = rs.getString("checkout_time");
					attendanceMap.put(date, new String[] { checkInTime, checkOutTime });
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (rs != null)
					try {
				rs.close();
					} catch (SQLException ignore) {
					}
				if (pstmt != null)
					try {
				pstmt.close();
					} catch (SQLException ignore) {
					}
				if (conn != null)
					try {
				conn.close();
					} catch (SQLException ignore) {
					}
			}
			%>
			<div class="calendar">
				<div class="calendar-header">
					<a href="Home.jsp?year=<%=year%>&month=<%=month - 1%>"
						class="icon"><i class="bx bx-left-arrow-alt"></i></a>
					<h3><%=months[month - 1]%>
						<%=year%></h3>
					<a href="Home.jsp?year=<%=year%>&month=<%=month + 1%>"
						class="icon"><i class="bx bx-right-arrow-alt"></i></a>
				</div>
				<table>
					<thead>
						<tr>
							<th>Sun</th>
							<th>Mon</th>
							<th>Tue</th>
							<th>Wed</th>
							<th>Thu</th>
							<th>Fri</th>
							<th>Sat</th>
						</tr>
					</thead>
					<tbody>
						<%
						int startDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - 1;
						int day = 1;

						for (int i = 0; i < 6; i++) {
							out.println("<tr>");
							for (int j = 0; j < 7; j++) {
								if ((i == 0 && j < startDayOfWeek) || day > daysInMonth) {
							out.println("<td></td>");
								} else {
							LocalDate currentDay = LocalDate.of(year, month, day);
							String dateString = currentDay.toString();
							String[] attendance = attendanceMap.getOrDefault(dateString, new String[] { "", "" });
							String checkInTime = attendance[0];
							String checkOutTime = attendance[1];
							boolean isToday = currentDay.equals(today);

							String dotColor = "";
							if (checkInTime != null && !checkInTime.isEmpty()) {
								dotColor = "green";
							} else if (currentDay.isBefore(today)
									&& !(currentDay.getDayOfWeek().getValue() == 6 || currentDay.getDayOfWeek().getValue() == 7)) {
								dotColor = "red";
							} else if (currentDay.getDayOfWeek().getValue() == 6 || currentDay.getDayOfWeek().getValue() == 7) {
								dotColor = "blue";
							} else {
								dotColor = "";
							}

							out.println("<td class='" + (isToday ? "today" : "") + "'>");
							out.println("<div>" + day + "</div>");
							if (!dotColor.isEmpty()) {
								out.println("<div class='dot " + dotColor + "'></div>");
							}
							if (checkInTime != null && !checkInTime.isEmpty()) {
								LocalTime checkIn = LocalTime.parse(checkInTime);
								LocalTime checkOut = (checkOutTime != null && !checkOutTime.isEmpty()) ? LocalTime.parse(checkOutTime)
										: null;
								String workingHours = "";
								if (checkOut != null) {
									Duration duration = Duration.between(checkIn, checkOut);
									long hours = duration.toHours();
									long minutes = duration.toMinutes() % 60;
									workingHours = String.format("%d hr %d min", hours, minutes);
								}
								out.println("<div class='time'>In: " + checkInTime + "<br>Out: "
										+ (checkOutTime == null || checkOutTime.isEmpty() ? "-" : checkOutTime) + "<br>Hours: "
										+ (workingHours.isEmpty() ? "-" : workingHours) + "</div>");
							}
							out.println("</td>");
							day++;
								}
							}
							out.println("</tr>");
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
