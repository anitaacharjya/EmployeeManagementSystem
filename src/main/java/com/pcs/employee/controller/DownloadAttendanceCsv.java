package com.pcs.employee.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.pcs.db.Dbconnect;
import com.pcs.employee.dao.impl.AttendanceDaoImpl;
import com.pcs.employee.vo.Attendance_vo;

@WebServlet("/DownloadAttendanceCsv")
public class DownloadAttendanceCsv extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empId = request.getParameter("emp_id");
        if (empId != null) {
            AttendanceDaoImpl dao = new AttendanceDaoImpl(Dbconnect.getConn());
            List<Attendance_vo> list = dao.getAttendanceByEmpId(empId);

            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"attendance_records.csv\"");

            try (PrintWriter writer = response.getWriter()) {
                writer.println("Employee ID,Check-in Time,Check-out Time,Date,Work Mode,Latitude,Longitude,Duration,Work Status,Address");

                for (Attendance_vo a : list) {
                    String checkin = a.getCheckin();
                    String checkout = a.getCheckout();
                    String durationStr = "N/A";
                    String workStatus = "N/A";

                    if (checkin != null && !checkin.isEmpty() && checkout != null && !checkout.isEmpty()) {
                        try {
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
                            LocalTime checkInTime = LocalTime.parse(checkin, formatter);
                            LocalTime checkOutTime = LocalTime.parse(checkout, formatter);
                            Duration duration = Duration.between(checkInTime, checkOutTime);
                            long hours = duration.toHours();
                            long minutes = duration.toMinutesPart();
                            boolean isNineHoursCompleted = duration.toMinutes() >= 540; // 9 hours = 540 minutes
                            durationStr = hours + " hours " + minutes + " minutes";
                            workStatus = isNineHoursCompleted ? "Met" : "Not Met";
                        } catch (DateTimeParseException e) {
                            durationStr = "Invalid time format";
                            workStatus = "N/A";
                        }
                    }

                    writer.println(a.getEmp_id() + "," + checkin + "," + checkout + "," + a.getDate() + "," + a.getMode() + "," + a.getLatitude() + "," + a.getLongitude() + "," + durationStr + "," + workStatus + "," + a.getAddress());
                }
            }
        } else {
            response.setContentType("text/html");
            response.getWriter().println("No Employee ID provided.");
        }
    }
}
