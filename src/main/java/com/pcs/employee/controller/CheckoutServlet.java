package com.pcs.employee.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.pcs.db.Dbconnect;
import com.pcs.employee.dao.impl.AttendanceDaoImpl;
import com.pcs.employee.vo.CheckOut_vo;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CheckoutServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get parameters from form data
            String checkoutTimeStr = request.getParameter("dateTime");
            String employeeId = request.getParameter("emp_id");
            String action = request.getParameter("action");

            // Fetch session attribute indicating check-in status
            HttpSession session = request.getSession();
            
            
            // Update checkout time in database
            AttendanceDaoImpl dao = new AttendanceDaoImpl(Dbconnect.getConn());
          boolean f =  dao.updateCheckoutTime(employeeId, checkoutTimeStr);
            
          if (f == true) {
          	
        	  session.setAttribute("Success", "Checkedout successfully.");
              session.setAttribute("checkedOutToday", true);
              
          } 
          else if(f == false){
          	 session.setAttribute("Failed", "Already checkedout today.");
          	
          }
          else {
              session.setAttribute("Failed", "Failed to checkout.");
          }


            // Set success message in session
           
            
            
            // Handle logout action
            if ("logout".equals(action)) {
                session.invalidate(); // Invalidate session
                response.sendRedirect("Index.jsp"); // Redirect to login page or home page
            } else {
                response.sendRedirect("Attendance.jsp"); // Redirect to attendance page or another appropriate page
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Attendance.jsp"); // Redirect to attendance page on error
        }
    }

}
