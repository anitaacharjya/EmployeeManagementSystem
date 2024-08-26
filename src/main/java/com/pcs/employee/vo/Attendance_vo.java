package com.pcs.employee.vo;

public class Attendance_vo {
	
    private String emp_id;
    private String checkin;
    private String checkout;
    private String mode;
    private String latitude;
    private String longitude;
    private String date;
    private String address;
    private String shift;
	@Override
	public String toString() {
		return "Attendance_vo [emp_id=" + emp_id + ", checkin=" + checkin + ", checkout=" + checkout + ", mode=" + mode
				+ ", latitude=" + latitude + ", longitude=" + longitude + ", date=" + date + ", address=" + address
				+ "]";
	}
	public String getEmp_id() {
		return emp_id;
	}
	public void setEmp_id(String emp_id) {
		this.emp_id = emp_id;
	}
	public String getCheckin() {
		return checkin;
	}
	public void setCheckin(String checkin) {
		this.checkin = checkin;
	}
	public String getCheckout() {
		return checkout;
	}
	public void setCheckout(String checkout) {
		this.checkout = checkout;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getShift() {
		return shift;
	}
	
	public void setShift(String shift) {
		this.shift = shift;
		
	}

	
	}
