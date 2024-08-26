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

/**
 * Servlet implementation class DeleteServlet
 */
@WebServlet("/deleteLeave")
public class DeleteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the leave report ID from the request parameter
        int id = Integer.parseInt(request.getParameter("id"));
        
        // Get a database connection
        Connection conn = Dbconnect.getConn();
        
        // Create an instance of LeaveDaoImpl
        LeaveDaoImpl leaveDao = new LeaveDaoImpl(conn);
        
        // Delete the leave record with the specified ID
        boolean success = leaveDao.deleteLeave(id);
        
        // Close the database connection

        // Redirect to the list of leave records
        if (success) {
            response.sendRedirect("AppliedLeave.jsp");
        } else {
            // Optionally handle failure (e.g., show an error message)
            response.sendRedirect("AppliedLeave.jsp");
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Delegate POST requests to the doGet method
        doGet(request, response);
    }
}
