<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate, java.time.YearMonth, java.util.Calendar" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management System</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
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
            overflow-x: auto;
            white-space: nowrap;
            text-align: center;
            display: flex;
            justify-content: flex-start;
            flex-wrap: wrap;
            margin-top: 20px;
        }
        .calendar {
            flex: 0 0 auto;
            width: 1220px;
            max-width: 3000px;
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
    </style>
</head>
<body>
    <div class="sidebar">
        <div class="sidebar-header">
            <i class='bx bxs-user'><i class='bx bx-check'></i></i>PCS
        </div>
        <ul class="sidebar-menu" style="margin-top: 40px;">
            <li style="font-weight: bold; margin-left: 20px;">ATTENDANCE</li>
            <li><a href="Attendance.jsp"><i class='bx bx-detail'></i>ATTENDANCE FORM</a></li>
            <li style="font-weight: bold; margin-left: 20px;">PROFILE</li>
            <li><a href="#"><i class='bx bx-id-card'></i>MY PROFILE</a></li>
        </ul>
    </div>
    <div class="main-content">
        <ul>
            <img src="Images/logo.jpg" alt="logo" style="height:40px"/>
        </ul>
        <h2>Attendance Calendar</h2>
        
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

                String[] months = { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" };
            %>
            <div class="calendar">
                <div class="calendar-header">
                    <a href="Calender.jsp?year=<%= year %>&month=<%= month - 1 %>" class="icon"><i class="bx bx-left-arrow-alt"></i></a>
                    <h3><%= months[month - 1] %> <%= year %></h3>
                    <a href="Calender.jsp?year=<%= year %>&month=<%= month + 1 %>" class="icon"><i class="bx bx-right-arrow-alt"></i></a>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th>Sunday</th>
                            <th>Monday</th>
                            <th>Tuesday</th>
                            <th>Wednesday</th>
                            <th>Thursday</th>
                            <th>Friday</th>
                            <th>Saturday</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int startDayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - 1; // 0 = Sunday
                            int day = 1;

                            for (int i = 0; i < 6; i++) {
                                out.println("<tr>");
                                for (int j = 0; j < 7; j++) {
                                    if (i == 0 && j < startDayOfWeek) {
                                        out.println("<td></td>");
                                    } else if (day > daysInMonth) {
                                        out.println("<td></td>");
                                    } else {
                                        boolean isToday = (year == today.getYear() && month == today.getMonthValue() && day == today.getDayOfMonth());
                                        out.println("<td class='" + (isToday ? "today" : "") + "'>" + day + "</td>");
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
