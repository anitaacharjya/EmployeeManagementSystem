package com.pcs.employee.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.pcs.db.Dbconnect;
import com.pcs.employee.dao.impl.WorkReportDaoImpl;
import com.pcs.employee.vo.WorkReportVo;

@WebServlet("/DownloadWorkReportCSV")
public class DownloadWorkReportCSV extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empId = request.getParameter("emp_id");
        String month = request.getParameter("month");
        String year = request.getParameter("year");

        if (empId != null && !empId.isEmpty() && month != null && !month.isEmpty() && year != null && !year.isEmpty()) {
            WorkReportDaoImpl dao = new WorkReportDaoImpl(Dbconnect.getConn());
            List<WorkReportVo> workReports = dao.getWorkReportsByEmpIdAndDate(empId, month, year);

            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"work_report_" + empId + "_" + month + "_" + year + ".csv\"");

            try (PrintWriter writer = response.getWriter()) {
                writer.println("Employee ID,Report Date,Time Slot,Task Category,Task Details");

                for (WorkReportVo report : workReports) {
                    writer.println(report.getEmp_id() + "," + report.getReport_date() + "," + report.getTime_slot() + "," + report.getTask_catagory() + "," + report.getTask_details());
                }
            }
        } else {
            response.setContentType("text/html");
            response.getWriter().println("Invalid parameters provided.");
        }
    }
}
