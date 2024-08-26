package com.pcs.employee.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.pcs.employee.vo.WorkReportVo;

public class WorkReportDaoImpl {
	 private Connection conn;

	    public WorkReportDaoImpl(Connection conn) {
	        this.conn = conn;
	    }
	    
	    public String saveWorkReport(WorkReportVo workreportvo) {
	    	String success = "false";
	        try {
	        	long millis = System.currentTimeMillis();
	            java.sql.Date date1 = new java.sql.Date(millis);
	            String todaydate = String.valueOf(date1);
	            String emp_id = workreportvo.getEmp_id();
	            
	            
	        	// Update the attendance table
	            String updateAttendanceSQL = "UPDATE attendance " +
	                                         "SET work_report_submitted = ? " +
	                                         "WHERE emp_id = ? AND date = ?";

	            PreparedStatement updateStatement = conn.prepareStatement(updateAttendanceSQL);
	            updateStatement.setBoolean(1, true);
	            updateStatement.setString(2, emp_id);
	            updateStatement.setString(3, todaydate);
	            
	            updateStatement.executeUpdate();
	        	
	        	int workreport = submittedWorkReportToday(emp_id);
	        	
	        	if(workreport == 0) {
	        	
	            String sql = "INSERT INTO work_report (emp_id, report_date, time_slot, task_category, task_details) VALUES (?, ?, ?, ?, ?)";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1,workreportvo.getEmp_id() );
	            ps.setString(2,workreportvo.getReport_date() );
	            ps.setString(3,workreportvo.getTime_slot() );
	            ps.setString(4,workreportvo.getTask_catagory() );
	            ps.setString(5,workreportvo.getTask_details() );
	            

	            int rowsInserted = ps.executeUpdate();
	            if (rowsInserted > 0) {
	                success = "new";
	            }
	            
	        	}else {
	        		 success = "old";
	        	}
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return success;
	    }
	    
	    public List<WorkReportVo> getWorkReportsByEmpId(String empId) {
	        List<WorkReportVo> workReports = new ArrayList<>();
	        try {
	            String sql = "SELECT * FROM work_report WHERE emp_id = ?";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, empId);
	            ResultSet rs = ps.executeQuery();

	            while (rs.next()) {
	                WorkReportVo report = new WorkReportVo();
	                report.setEmp_id(rs.getString("emp_id"));
	                report.setReport_date(rs.getString("report_date"));
	                report.setTime_slot(rs.getString("time_slot"));
	                report.setTask_catagory(rs.getString("task_category"));
	                report.setTask_details(rs.getString("task_details"));
	                workReports.add(report);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return workReports;
	    }

	    public int countDistinctTimeSlots() {
	        int count = 0;
	        try {
	            String sql = "SELECT COUNT(DISTINCT time_slot) AS distinct_time_slots FROM work_report";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ResultSet rs = ps.executeQuery();

	            if (rs.next()) {
	                count = rs.getInt("distinct_time_slots");
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return count;
	    }
	    public Map<String, Integer> getUsersPerTimeSlot() {
	        Map<String, Integer> timeSlotUserCount = new HashMap<>();
	        try {
	            String sql = "SELECT time_slot, COUNT(DISTINCT emp_id) AS user_count FROM work_report GROUP BY time_slot";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ResultSet rs = ps.executeQuery();

	            while (rs.next()) {
	                String timeSlot = rs.getString("time_slot");
	                int userCount = rs.getInt("user_count");
	                timeSlotUserCount.put(timeSlot, userCount);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return timeSlotUserCount;
	    }
	    
	    public List<WorkReportVo> getEmployeesWithoutReport() {
	        List<WorkReportVo> employees = new ArrayList<>();
	        
            
	        
	        try {
	        	
	        	long millis = System.currentTimeMillis();
	            java.sql.Date date1 = new java.sql.Date(millis);
	            String todaydate = String.valueOf(date1);
	            
	        String sql = "SELECT r.emp_id, r.name, r.email, a.checkin_time, a.checkout_time, a.work_report_submitted FROM attendance a JOIN register r \n"
	        		+ "ON a.emp_id = r.emp_id WHERE a.date = ? AND a.checkout_time IS NOT NULL AND a.work_report_submitted = FALSE";

	      
	        PreparedStatement ps = conn.prepareStatement(sql);
	             ps.setString(1, todaydate);
	            ResultSet rs = ps.executeQuery();
	                while (rs.next()) {
	                	WorkReportVo emp = new WorkReportVo();
	                    emp.setEmp_id(rs.getString("emp_id"));
	                    emp.setName(rs.getString("name"));
	                    emp.setEmail(rs.getString("email"));
	                    employees.add(emp);
	                }
	            }
	         catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return employees;
	    }
	    
	 // Method to check if the user has already submitted work report today
	    public int submittedWorkReportToday(String empId) {
	        int count = 0;
	        try {
	            // Query to check if there is a check-in record for today
	            String sql = "SELECT COUNT(*) as COUNT FROM work_report WHERE emp_id = ? AND report_date = CURRENT_DATE";
	            PreparedStatement stmt = conn.prepareStatement(sql);
	            stmt.setString(1, empId);
	            ResultSet rs = stmt.executeQuery();
	            if (rs.next()) {
	                count = rs.getInt("COUNT");
	                System.out.println("inside resultset: " + count);
	            }
	            System.out.println("count = " + count);
	        } catch (SQLException e) {
	            e.printStackTrace();
	            // Handle exception as per your application's error handling strategy
	        } 
	        
	        return count;  // Default to 0 if there's any error or no records found
	    }
	    
	    public List<WorkReportVo> getWorkReportsByEmpIdAndDate(String empId, String month, String year) {
	        List<WorkReportVo> workReports = new ArrayList<>();
	        String sql = "SELECT * FROM work_report WHERE emp_id = ? AND MONTH(report_date) = ? AND YEAR(report_date) = ?";

	        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
	            stmt.setString(1, empId);
	            stmt.setInt(2, Integer.parseInt(month));
	            stmt.setInt(3, Integer.parseInt(year));

	            ResultSet rs = stmt.executeQuery();
	            while (rs.next()) {
	                WorkReportVo report = new WorkReportVo();
	                report.setEmp_id(rs.getString("emp_id"));
	                report.setReport_date(rs.getString("report_date"));
	                report.setTime_slot(rs.getString("time_slot"));
	                report.setTask_catagory(rs.getString("task_category"));
	                report.setTask_details(rs.getString("task_details"));
	                workReports.add(report);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return workReports;
	    }
	    
	}


