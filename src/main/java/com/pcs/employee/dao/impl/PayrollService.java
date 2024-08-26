package com.pcs.employee.dao.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.TextStyle;
import java.util.Locale;
import com.pcs.db.Dbconnect;
import com.pcs.employee.vo.PayRoll;

public class PayrollService { private PayrollDaoImpl payrollDao = new PayrollDaoImpl(Dbconnect.getConn());

public List<PayRoll> getAllPayrolls() {
    // Assuming getAllPayrolls() method is implemented in PayrollDaoImpl
    return payrollDao.getAllPayrolls();
}
public List<PayRoll> getPayrollsByMonthAndYear(String month, String year) {
	
	return payrollDao.getPayrollsByMonthAndYear(month, year);
    // Implement the logic to query the database for payrolls with the given month and year
    // This will likely involve constructing a SQL query with a WHERE clause for month and year
}
public void generatePayslips() {
    List<PayRoll> payrolls = getAllPayrolls();

    for (PayRoll payroll : payrolls) {
        String payslip = createPayslip(payroll);
        // You can save this payslip to the database or a file, or prepare it for display in JSP
        System.out.println(payslip);
    }
}

private String createPayslip(PayRoll payroll) {
    StringBuilder sb = new StringBuilder();
    sb.append("Payslip for: ").append(payroll.getName()).append("\n");
    sb.append("Employee ID: ").append(payroll.getEmployeeId()).append("\n");
    sb.append("Department: ").append(payroll.getDepartment()).append("\n");
    sb.append("Basic Salary: ").append(payroll.getBasicSalary()).append("\n");
    sb.append("HRA: ").append(payroll.getHra()).append("\n");
    sb.append("Allowances: ").append(payroll.getAllowances()).append("\n");
    sb.append("Deductions: ").append(payroll.getDeductions()).append("\n");
    sb.append("Net Salary: ").append(calculateNetSalary(payroll)).append("\n");
    sb.append("Payment Date: ").append(payroll.getPaymentDate()).append("\n");
    return sb.toString();
}

private double calculateNetSalary(PayRoll payroll) {
    return payroll.getBasicSalary() + payroll.getHra() + payroll.getAllowances() - payroll.getDeductions();
}




    // Assuming paymentDate is stored as a String in the format "dd-MM-yyyy"
    private String paymentDate;

    public String getMonth() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        LocalDate date = LocalDate.parse(paymentDate, formatter);
        // Extract month name
        return date.getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH);
    }

    public String getYear() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        LocalDate date = LocalDate.parse(paymentDate, formatter);
        // Extract year
        return String.valueOf(date.getYear());
    }
    
    // Other fields and methods...



}
