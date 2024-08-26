package com.pcs.employee.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.pcs.db.Dbconnect;
import com.pcs.employee.vo.PayRoll;

public class PayrollDaoImpl {
	
	private Connection connection;
	
	Dbconnect dbconnect = new Dbconnect();
	
	
	public PayrollDaoImpl(Connection conn) {
		super();
		this.connection = conn;
	}

	
	
    public boolean savePayroll(PayRoll payroll) {
    	boolean f = false;
    	Connection connection = dbconnect.getConn();
        String sql = "INSERT INTO payroll (emp_id, name, department, basic_salary, hra, allowances, deductions, gross_salary, net_salary, payment_date,govt_stipend) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?,?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, payroll.getEmployeeId());
            ps.setString(2, payroll.getName());
            ps.setString(3, payroll.getDepartment());
            ps.setDouble(4, payroll.getBasicSalary());
            ps.setDouble(5, payroll.getHra());
            ps.setDouble(6, payroll.getAllowances());
            ps.setDouble(7, payroll.getDeductions());
            ps.setDouble(8, payroll.getGrossSalary());
            ps.setDouble(9, payroll.getNetSalary());
            ps.setString(10,payroll.getPaymentDate() );
            ps.setDouble(11,payroll.getGovtStipend() );
           
            
            int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
        } catch (SQLException e) {
            e.printStackTrace();
        }
		return f;
    }

    
    public List<PayRoll> getAllPayrolls() {
        List<PayRoll> employees = new ArrayList<>();
        String sql = "SELECT p.*, r.designation, r.bank_name, r.bank_account_number, r.pf_account_number " +
                     "FROM payroll p " +
                     "JOIN register r ON p.emp_id = r.emp_id";
        Connection connection = dbconnect.getConn();
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                PayRoll employee = new PayRoll();
                employee.setEmployeeId(rs.getString("emp_id"));
                employee.setName(rs.getString("name"));
                employee.setDepartment(rs.getString("department"));
                employee.setBasicSalary(rs.getDouble("basic_salary"));
                employee.setGovtStipend(rs.getDouble("govt_stipend"));
                employee.setHra(rs.getDouble("hra"));
                employee.setAllowances(rs.getDouble("allowances"));
                employee.setDeductions(rs.getDouble("deductions"));
                employee.setGrossSalary(rs.getDouble("gross_salary"));
                employee.setNetSalary(rs.getDouble("net_salary"));
                employee.setPaymentDate(rs.getString("payment_date"));
                
                // Additional fields from the register table
                employee.setDesignation(rs.getString("designation"));
                employee.setBankName(rs.getString("bank_name"));
                employee.setBankAccountNumber(rs.getString("bank_account_number"));
                employee.setPfAccountNumber(rs.getString("pf_account_number"));

                employees.add(employee);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employees;
    }

    
    public List<PayRoll> getPayrollsByMonthAndYear(String month, String year) {
        List<PayRoll> payrolls = new ArrayList<>();
        String query = "SELECT * FROM payroll WHERE MONTH(STR_TO_DATE(payment_date, '%d-%m-%Y')) = ? AND YEAR(STR_TO_DATE(payment_date, '%d-%m-%Y')) = ?";
        try (Connection connection = dbconnect.getConn();
             PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, month);
            ps.setString(2, year);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PayRoll payroll = new PayRoll();
                    payroll.setName(rs.getString("name"));
                    payroll.setEmployeeId(rs.getString("emp_id"));
                    payroll.setDepartment(rs.getString("department"));
                    payroll.setBasicSalary(rs.getDouble("basic_salary"));
                    payroll.setGovtStipend(rs.getDouble("govt_stipend"));
                    payroll.setHra(rs.getDouble("hra"));
                    payroll.setAllowances(rs.getDouble("allowances"));
                    payroll.setDeductions(rs.getDouble("deductions"));
                    payroll.setPaymentDate(rs.getString("payment_date"));
                    payrolls.add(payroll);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return payrolls;
    }

   
    public PayRoll getPayrollById(String employeeId) {
    	PayRoll employee = null;
    	Connection connection = dbconnect.getConn();
        String sql = "SELECT * FROM payroll WHERE employee_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, employeeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    employee = new PayRoll();
                    employee.setEmployeeId(rs.getString("employee_id"));
                    employee.setName(rs.getString("name"));
                    employee.setDepartment(rs.getString("department"));
                    employee.setBasicSalary(rs.getDouble("basic_salary"));
                    employee.setHra(rs.getDouble("hra"));
                    employee.setAllowances(rs.getDouble("allowances"));
                    employee.setDeductions(rs.getDouble("deductions"));
                    employee.setGrossSalary(rs.getDouble("gross_salary"));
                    employee.setNetSalary(rs.getDouble("net_salary"));
                    employee.setPaymentDate(rs.getString("payment_date"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employee;
    }


}
