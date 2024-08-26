package com.pcs.employee.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import com.pcs.db.Dbconnect;
import com.pcs.employee.dao.impl.LeaveDaoImpl;
import com.pcs.employee.vo.Leave;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

@WebServlet("/updateLeave")
public class UpdateLeaveServlet extends HttpServlet {

    private static final String SENDER_EMAIL = "tripathysuvendu6@gmail.com";
    private static final String SENDER_PASSWORD = "dvvp hyls wgoo ltvz";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve parameters from the request
        int id = Integer.parseInt(request.getParameter("id"));
        String leaveType = request.getParameter("leaveType");
        String leaveSubject = request.getParameter("leaveSubject");
        String description = request.getParameter("description");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String applyDate = request.getParameter("applyDate");
        String status = request.getParameter("status");
        String recipientEmail = request.getParameter("email"); 

        Leave leave = new Leave();
        leave.setLeave_report_id(String.valueOf(id));
        leave.setLeaveType(leaveType);
        leave.setLeaveSubject(leaveSubject);
        leave.setDescription(description);
        leave.setStartDate(startDate);
        leave.setEndDate(endDate);
        leave.setApplyDate(applyDate);
        leave.setStatus(status);

        Connection conn = Dbconnect.getConn();
        LeaveDaoImpl leaveDao = new LeaveDaoImpl(conn);
        boolean success = leaveDao.updateLeave(leave);

        if (success) {
            if (!status.equalsIgnoreCase("Pending")) {
                sendEmail(recipientEmail, status, leave);
            }
            response.sendRedirect("AppliedLeave.jsp");
        } else {
            response.sendRedirect("AppliedLeave.jsp");
        }
    }

    private void sendEmail(String recipientEmail, String status, Leave leave) {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getInstance(properties, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Leave Status Update");
            message.setText("Dear Employee,\n\nYour leave request with the following details has been " + status + ":\n" +
                    "Leave Type: " + leave.getLeaveType() + "\n" +
                    "Leave Subject: " + leave.getLeaveSubject() + "\n" +
                    "Description: " + leave.getDescription() + "\n" +
                    "Start Date: " + leave.getStartDate() + "\n" +
                    "End Date: " + leave.getEndDate() + "\n" +
                    "Apply Date: " + leave.getApplyDate() + "\n\n" +
                    "Best regards,\nEmployee Management System");

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}
