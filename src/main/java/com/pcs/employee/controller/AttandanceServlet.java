package com.pcs.employee.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.pcs.db.Dbconnect;
import com.pcs.employee.dao.impl.AttendanceDaoImpl;
import com.pcs.employee.vo.Attendance_vo;

@WebServlet("/AttendanceServlet")
public class AttandanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AttandanceServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String lat = request.getParameter("lat");
        String lon = request.getParameter("lon");
        String urlString = "https://nominatim.openstreetmap.org/reverse?lat=" + lat + "&lon=" + lon + "&format=json";

        try {
            URL url = new URL(urlString);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();
            con.disconnect();

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(content.toString());
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("Error fetching geolocation data: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("emp_id");
            String checkin = request.getParameter("dateTime");
            String mode = request.getParameter("workLocation");
            String latitude = request.getParameter("latitude");
            String longitude = request.getParameter("longitude");
            String address=request.getParameter("address");
            String shift=request.getParameter("shift");
            

            System.out.println("id: " + id);
            System.out.println("checkin: " + checkin);
            System.out.println("mode: " + mode);
            System.out.println("latitude: " + latitude);
            System.out.println("longitude: " + longitude);
            System.out.println("Address: "+address);
            System.out.println("shift: "+shift);

            Attendance_vo attendance = new Attendance_vo();
            attendance.setEmp_id(id);
            attendance.setCheckin(checkin);
            attendance.setMode(mode);
            attendance.setLatitude(latitude);
            attendance.setLongitude(longitude);
            attendance.setAddress(address);
            attendance.setShift(shift);
            HttpSession session = request.getSession();

            // Check if already checked in today
            if (session.getAttribute("checkedIn") != null && (boolean) session.getAttribute("checkedin")) {
                session.setAttribute("Failed", "Already checked in today.");
                response.sendRedirect("Attendance.jsp"); // Redirect or handle accordingly
                
            } else {
                AttendanceDaoImpl dao = new AttendanceDaoImpl(Dbconnect.getConn());
                String  f = dao.emp_attendance(attendance);

                if (f=="new") {
                	session.setAttribute("checkedInToday", true);
                    session.setAttribute("Success", "Your attendance marked successfully for the day.");
                   // session.setAttribute("checkedin", true); // Mark as checked in for today
                } 
                else if(f=="old"){
                	 session.setAttribute("Failed", "Already checked in today.");
                	
                }
                else {
                    session.setAttribute("Failed", "Failed to mark attendance.");
                }

                // Fetch all attendance records
                List<Attendance_vo> attendanceList = dao.getAllAttendance();
                request.setAttribute("attendanceList", attendanceList);


                // Forward to Attendance.jsp
                request.getRequestDispatcher("Attendance.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("Failed", "Exception occurred: " + e.getMessage());
            response.sendRedirect("Attendance.jsp");
        }
    }
}
