package com.pcs.employee.vo;

public class WorkReportVo {
private String emp_id;
private String name;
private String email;
private String report_date;
private String time_slot;
private String task_catagory;
private String task_details;

public String getEmp_id() {
	return emp_id;
}
public void setEmp_id(String emp_id) {
	this.emp_id = emp_id;
}
public String getReport_date() {
	return report_date;
}
public void setReport_date(String report_date) {
	this.report_date = report_date;
}
public String getTime_slot() {
	return time_slot;
}
public void setTime_slot(String time_slot) {
	this.time_slot = time_slot;
}
public String getTask_catagory() {
	return task_catagory;
}
public void setTask_catagory(String task_catagory) {
	this.task_catagory = task_catagory;
}
public String getTask_details() {
	return task_details;
}
public void setTask_details(String task_details) {
	this.task_details = task_details;
}



public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
@Override
public String toString() {
	return "WorkReportVo [emp_id=" + emp_id + ", name=" + name + ", email=" + email + ", report_date=" + report_date
			+ ", time_slot=" + time_slot + ", task_catagory=" + task_catagory + ", task_details=" + task_details
			+ ", shift_start=" + ", shift_end="  + "]";
}


}
