package com.pcs.employee.vo;

import java.sql.Date;

public class PayRoll {
	
	private String employeeId;
    private String name;
    private String department;
    private double basicSalary;
    private double govtStipend;
    private double hra;
    private double allowances;
    private double deductions;
    private double grossSalary;
    private double netSalary;
    private String paymentDate;
    private String designation;
    private String bankName;
    private String bankAccountNumber;
    public String getDesignation() {
		return designation;
	}
	public void setDesignation(String designation) {
		this.designation = designation;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankAccountNumber() {
		return bankAccountNumber;
	}
	public void setBankAccountNumber(String bankAccountNumber) {
		this.bankAccountNumber = bankAccountNumber;
	}
	public String getPfAccountNumber() {
		return pfAccountNumber;
	}
	public void setPfAccountNumber(String pfAccountNumber) {
		this.pfAccountNumber = pfAccountNumber;
	}
	private String pfAccountNumber;
    
	public String getEmployeeId() {
		return employeeId;
	}
	public void setEmployeeId(String employeeId) {
		this.employeeId = employeeId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public double getBasicSalary() {
		return basicSalary;
	}
	public void setBasicSalary(double basicSalary) {
		this.basicSalary = basicSalary;
	}
	public double getHra() {
		return hra;
	}
	public void setHra(double hra) {
		this.hra = hra;
	}
	public double getAllowances() {
		return allowances;
	}
	public void setAllowances(double allowances) {
		this.allowances = allowances;
	}
	public double getDeductions() {
		return deductions;
	}
	public void setDeductions(double deductions) {
		this.deductions = deductions;
	}
	public double getGrossSalary() {
		return grossSalary;
	}
	public void setGrossSalary(double grossSalary) {
		this.grossSalary = grossSalary;
	}
	public double getNetSalary() {
		return netSalary;
	}
	public void setNetSalary(double netSalary) {
		this.netSalary = netSalary;
	}
	
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	
	
	public double getGovtStipend() {
		return govtStipend;
	}
	public void setGovtStipend(double govtStipend) {
		this.govtStipend = govtStipend;
	}
	@Override
	public String toString() {
		return "PayRoll [employeeId=" + employeeId + ", name=" + name + ", department=" + department + ", basicSalary="
				+ basicSalary + ", govtStipend=" + govtStipend + ", hra=" + hra + ", allowances=" + allowances
				+ ", deductions=" + deductions + ", grossSalary=" + grossSalary + ", netSalary=" + netSalary
				+ ", paymentDate=" + paymentDate + ", designation=" + designation + ", bankName=" + bankName
				+ ", bankAccountNumber=" + bankAccountNumber + ", pfAccountNumber=" + pfAccountNumber + "]";
	}
	
	
    

}
