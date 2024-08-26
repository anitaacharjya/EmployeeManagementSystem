package com.pcs.employee.vo;

public class Leave {
	private String name;
	private String id;
	private String leaveType;
	private String leaveSubject;
	private String description;
	private String startDate;
	private String endDate;
	private String applyDate;
	private String status;
	private String leave_report_id;
	private String email;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLeaveType() {
		return leaveType;
	}
	public void setLeaveType(String leaveType) {
		this.leaveType = leaveType;
	}
	public String getLeaveSubject() {
		return leaveSubject;
	}
	public void setLeaveSubject(String leaveSubject) {
		this.leaveSubject = leaveSubject;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getApplyDate() {
		return applyDate;
	}
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getLeave_report_id() {
		return leave_report_id;
	}
	public void setLeave_report_id(String leave_report_id) {
		this.leave_report_id = leave_report_id;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "Leave [name=" + name + ", id=" + id + ", leaveType=" + leaveType + ", leaveSubject=" + leaveSubject
				+ ", description=" + description + ", startDate=" + startDate + ", endDate=" + endDate + ", applyDate="
				+ applyDate + ", status=" + status + ", leave_report_id=" + leave_report_id + ", email=" + email + "]";
	}
	
}
