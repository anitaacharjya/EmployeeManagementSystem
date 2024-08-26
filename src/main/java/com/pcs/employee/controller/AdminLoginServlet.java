package com.pcs.employee.controller;

import java.io.IOException;



import com.pcs.db.Dbconnect;
import com.pcs.employee.dao.impl.AdminLoginImpl;
import com.pcs.employee.vo.AdminVo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ALoginServlet")
public class AdminLoginServlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		AdminLoginImpl dao=new AdminLoginImpl(Dbconnect.getConn());
		HttpSession session=req.getSession();
		
		
		try {
			
			String username=req.getParameter("username");
			String password=req.getParameter("password");
			
			
			AdminVo Av=dao.login(username, password);
			System.out.println("Under Adminvo");

			
			if (Av!=null) {
				session.setAttribute("adminobj", Av);
				res.sendRedirect("admin.jsp");
				System.out.println("Redirecting to admin");

			}else{
				session.setAttribute("Failed", "Email and password invaild");
				res.sendRedirect("adminlogin.jsp");
				System.out.println("Redirecting to login");

			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
}