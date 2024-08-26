package com.pcs.employee.controller;

import java.io.IOException;

import com.pcs.db.Dbconnect;
import com.pcs.employee.dao.impl.PayrollDaoImpl;
import com.pcs.employee.dao.impl.PayrollService;
import com.pcs.employee.vo.PayRoll;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/processPayroll")
public class PayrollServlet extends HttpServlet {

    private PayrollService payrollService = new PayrollService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        PayrollDaoImpl payrollDao = new PayrollDaoImpl(Dbconnect.getConn());

        String employeeId = request.getParameter("employeeId");
        String name = request.getParameter("name");
        String department = request.getParameter("department");
        double basicSalary = Double.parseDouble(request.getParameter("basicSalary"));
        double govtStipend = Double.parseDouble(request.getParameter("govtstipend"));
        double hra = Double.parseDouble(request.getParameter("hra"));
        double allowances = Double.parseDouble(request.getParameter("allowances"));
        double deductions = Double.parseDouble(request.getParameter("deductions"));

        PayRoll employee = new PayRoll();
        employee.setEmployeeId(employeeId);
        employee.setName(name);
        employee.setDepartment(department);
        employee.setBasicSalary(basicSalary);
        employee.setGovtStipend(govtStipend);
        employee.setHra(hra);
        employee.setAllowances(allowances);
        employee.setDeductions(deductions);

        //payrollService.processPayroll(employee);
        boolean isSuccess = payrollDao.savePayroll(employee);

        if (isSuccess) {
            session.setAttribute("Success", "Payroll processed successfully.");
            response.sendRedirect("payrollForm.jsp");
        } else {
            session.setAttribute("Failed", "Something went wrong.");
            response.sendRedirect("payrollForm.jsp");
        }
    }
}
