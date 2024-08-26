package com.pcs.employee.vo;

import java.sql.Timestamp;

public class CheckOut_vo {
	private String checkoutTime;
	private String id;
	public String getCheckoutTime() {
		return checkoutTime;
	}

	public void setCheckoutTime(String checkoutTime) {
		this.checkoutTime = checkoutTime;
	}
	
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "CheckOut_vo [checkoutTime=" + checkoutTime + ", id=" + id + "]";
	}

	
	

}
