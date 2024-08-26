package com.pcs.employee.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.pcs.db.Dbconnect;
import com.pcs.employee.dao.impl.*;
import com.pcs.employee.vo.WorkReportVo;

@WebServlet("/WorkReportServlet")
public class WorkReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empId = request.getParameter("emp_id");
        String reportDate = request.getParameter("reportDate");
        String timeSlot = request.getParameter("timeSlot");
        String taskCategory = request.getParameter("taskCategory");
        String taskDetails = request.getParameter("taskDetails");
        
        WorkReportVo workreportvo = new WorkReportVo();
        
        workreportvo.setEmp_id(empId);
        workreportvo.setReport_date(reportDate);
        workreportvo.setTime_slot(timeSlot);
        workreportvo.setTask_catagory(taskCategory);
        workreportvo.setTask_details(taskDetails);
        
        WorkReportDaoImpl dao = new WorkReportDaoImpl(Dbconnect.getConn()); 
        String isSaved = dao.saveWorkReport(workreportvo);

        if (isSaved =="new") {
            request.getSession().setAttribute("Success", "Work report submitted successfully.");
        } 
        else if (isSaved =="old") {
        	request.getSession().setAttribute("Failed", "You already submitted Work report for today.");
        	
        }
        else {
            request.getSession().setAttribute("Failed", "Failed to submit work report.");
        }

        response.sendRedirect("WorkingReport.jsp");
    }
}
