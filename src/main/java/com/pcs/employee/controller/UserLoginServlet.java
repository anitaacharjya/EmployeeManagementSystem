package com.pcs.employee.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.pcs.db.Dbconnect;
import com.pcs.employee.dao.impl.AttendanceDaoImpl;
import com.pcs.employee.dao.impl.UserDaoImpl;
import com.pcs.employee.vo.User;

/**
 * Servlet implementation class UserLoginServlet
 */
@WebServlet("/ULoginServlet")
public class UserLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        UserDaoImpl dao = new UserDaoImpl(Dbconnect.getConn());
        AttendanceDaoImpl attendance = new AttendanceDaoImpl(Dbconnect.getConn());
                HttpSession session = req.getSession();
        
        try {
        	String name = req.getParameter("name");
            String emp_id = req.getParameter("emp_id");
            String password = req.getParameter("password");

            // Check for hardcoded admin credentials
            if ("admin".equals(emp_id) && "admin".equals(password)) {
                User admin = new User();
                admin.setName("Admin");
                admin.setEmail("admin@gmail.com"); // Set additional attributes if necessary
                session.setAttribute("userobj", admin);
                res.sendRedirect("admin.jsp");
            } else {
                // Regular user login
            	
                User user = dao.login(emp_id, password);
                if (user != null) {
                int attendancetoday = attendance.hasCheckedInToday(emp_id);
                if(attendancetoday>0) {
                	session.setAttribute("checkedInToday", true);	
                }
                else {
                	session.setAttribute("checkedInToday", false);
                }
                
                    session.setAttribute("userobj", user);
            
                    res.sendRedirect("Home.jsp");
                } else {
                    session.setAttribute("Failed", "Username and password invalid");
                    res.sendRedirect("Index.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Optionally, add error handling logic here
        }
    }
}
