package com.pcs.employee.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.pcs.db.Dbconnect;
import com.pcs.employee.vo.Leave;

public class LeaveDaoImpl {
	private Connection conn;

	Dbconnect dbconnect = new Dbconnect();

	public LeaveDaoImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	public boolean applyLeave(Leave lv) {
		boolean f = false;
		try {
			Connection conn = dbconnect.getConn();
			String sql = "INSERT INTO leave_report(emp_id, leave_type, leave_subject, description, start_date, end_date, apply_date, status, leave_report_id,email) VALUES (?, ?, ?, ?, ?, ?, ?, ? , ?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, lv.getId());
			ps.setString(2, lv.getLeaveType());
			ps.setString(3, lv.getLeaveSubject());
			ps.setString(4, lv.getDescription());
			ps.setString(5, lv.getStartDate());
			ps.setString(6, lv.getEndDate());
			ps.setString(7, lv.getApplyDate());
			ps.setString(8, lv.getStatus());
			ps.setString(9, lv.getLeave_report_id());
			ps.setString(10, lv.getEmail());

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return f;
	}

	public List<Leave> getLeavesByUserId(String empid) {
	    List<Leave> userList = new ArrayList<>();
	    String sql = "SELECT * FROM leave_report WHERE emp_id = ?";
	    Connection conn = dbconnect.getConn();
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, empid);
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                Leave us = new Leave();
	                us.setId(rs.getString("emp_id"));
	                us.setDescription(rs.getString("description"));
	                us.setLeaveType(rs.getString("leave_type"));
	                us.setLeaveSubject(rs.getString("leave_subject"));
	                us.setStartDate(rs.getString("start_date"));
	                us.setEndDate(rs.getString("end_date"));
	                us.setApplyDate(rs.getString("apply_date"));
	                us.setStatus(rs.getString("status"));
	                us.setEmail(rs.getString("email")); // Assuming email is stored in the leave_report table
	                userList.add(us);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace(); // Replace with logger in production
	    }
	    return userList;
	}


	public int countTotalLeaves() {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM leave_report";
		try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}

	public List<Leave> getAllLeaveReports() {
		List<Leave> leaveList = new ArrayList<>();
		String sql = "SELECT * FROM leave_report";
		Connection conn = dbconnect.getConn();
		try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				Leave lv = new Leave();
				lv.setLeave_report_id("leave_report_id");
				lv.setId(rs.getString("emp_id"));
				lv.setDescription(rs.getString("description"));
				lv.setLeaveType(rs.getString("leave_type"));
				lv.setLeaveSubject(rs.getString("leave_subject"));
				lv.setDescription(rs.getString("description"));
				lv.setStartDate(rs.getString("start_date"));
				lv.setEndDate(rs.getString("end_date"));
				lv.setApplyDate(rs.getString("apply_date"));
				lv.setStatus(rs.getString("status"));
				lv.setLeave_report_id(rs.getString("leave_report_id"));
				lv.setEmail(rs.getString("email"));
				leaveList.add(lv);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return leaveList;
	}

	
	public boolean deleteLeave(int leaveReportId) {
		boolean f = false;
		String sql = "DELETE FROM leave_report WHERE leave_report_id = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, leaveReportId);
			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return f;
	}

	public Leave getLeaveById(int leaveReportId) {
		Leave leave = null;
		String sql = "SELECT * FROM leave_report WHERE leave_report_id = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, leaveReportId);
			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {
					leave = new Leave();
					leave.setLeave_report_id(rs.getString("leave_report_id"));
					leave.setId(rs.getString("emp_id"));
					leave.setLeaveType(rs.getString("leave_type"));
					leave.setLeaveSubject(rs.getString("leave_subject"));
					leave.setDescription(rs.getString("description"));
					leave.setStartDate(rs.getString("start_date"));
					leave.setEndDate(rs.getString("end_date"));
					leave.setApplyDate(rs.getString("apply_date"));
					leave.setStatus(rs.getString("status"));
					leave.setEmail(rs.getString("email"));
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return leave;
	}
	public boolean updateLeave(Leave leave) {
	    boolean result = false;
	    String sql = "UPDATE leave_report SET leave_type = ?, leave_subject = ?, description = ?, start_date = ?, end_date = ?, apply_date = ?, status = ? WHERE leave_report_id = ?";

	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, leave.getLeaveType());
	        ps.setString(2, leave.getLeaveSubject());
	        ps.setString(3, leave.getDescription());
	        ps.setString(4, leave.getStartDate());
	        ps.setString(5, leave.getEndDate());
	        ps.setString(6, leave.getApplyDate());
	        ps.setString(7, leave.getStatus());
	        ps.setString(8, leave.getLeave_report_id());

	        int rowsAffected = ps.executeUpdate();
	        if (rowsAffected > 0) {
	            result = true;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return result;
	}


}
