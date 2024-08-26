package com.pcs.employee.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.pcs.db.Dbconnect;
import com.pcs.employee.dao.impl.LeaveDaoImpl;
import com.pcs.employee.vo.Leave;

@WebServlet("/leave")
public class LeaveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            LeaveDaoImpl daoimpl = new LeaveDaoImpl(Dbconnect.getConn());
            String empId = request.getParameter("emp_id");

            if (empId != null && !empId.isEmpty()) {
                List<Leave> leaveList = daoimpl.getLeavesByUserId(empId);
                session.setAttribute("LeaveTableList", leaveList);
            }

            // Print statement to check if the method is called app pass = dvvp hyls wgoo ltvz
            System.out.println("Inside doGet");

            request.getRequestDispatcher("LeaveApplication.jsp").forward(request, response);
        } catch (IOException | ServletException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to retrieve leave data.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            LeaveDaoImpl daoimpl = new LeaveDaoImpl(Dbconnect.getConn());

            String empId = request.getParameter("emp_id");
            String subject = request.getParameter("leaveSubject");
            String startDate = request.getParameter("startDate");
            String endDate = request.getParameter("endDate");
            String applaydate = request.getParameter("applydate");
            String descriptionType = request.getParameter("leaveMessage");
            String leaveType = request.getParameter("leaveType");
            String leave_Random=request.getParameter("randomNumber");
            String status = "Pending"; // Default status for a new leave application
            String email=request.getParameter("email");

            // Check if any required field is missing or empty
            if (empId == null || empId.isEmpty() ||
                subject == null || subject.isEmpty() ||
                startDate == null || startDate.isEmpty() ||
                endDate == null || endDate.isEmpty() ||
                applaydate == null || applaydate.isEmpty() ||
                descriptionType == null || descriptionType.isEmpty() ||
                leaveType == null || leaveType.isEmpty()) {
                
                session.setAttribute("Failed", "All fields are required.");
                response.sendRedirect("LeaveApplication.jsp");
                return; // Exit the method to prevent further processing
            }

            
            Leave lv = new Leave();
            lv.setId(empId);
            lv.setLeaveType(leaveType);
            lv.setLeaveSubject(subject);
            lv.setDescription(descriptionType);
            lv.setStartDate(startDate);
            lv.setEndDate(endDate);
            lv.setApplyDate(applaydate);
            lv.setStatus(status);
            lv.setLeave_report_id(leave_Random);
            lv.setEmail(email);

            session.setAttribute("leave", lv);

            boolean isSuccess = daoimpl.applyLeave(lv);
            if (isSuccess) {
                session.setAttribute("Success", "Leave application sent for approval.");
                response.sendRedirect("LeaveApplication.jsp");
            } else {
                session.setAttribute("Failed", "Something went wrong.");
                response.sendRedirect("LeaveApplication.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("Failed", "An error occurred while processing your request.");
            response.sendRedirect("LeaveApplication.jsp");
        }
    }
}
