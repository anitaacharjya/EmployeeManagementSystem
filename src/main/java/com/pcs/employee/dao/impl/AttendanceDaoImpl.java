package com.pcs.employee.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.pcs.employee.vo.Attendance_vo;
import com.pcs.employee.vo.WorkReportVo;

public class AttendanceDaoImpl {
    
    private Connection conn;

    public AttendanceDaoImpl(Connection conn) {
        this.conn = conn;
    }

    public String emp_attendance(Attendance_vo attendance_vo) {
    	String success = "false";
        
        try {
            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            String todaydate = String.valueOf(date);
            String emp_id = attendance_vo.getEmp_id();
            int attandencevalue = hasCheckedInToday(emp_id);
            System.out.println("attandencevalue : " +attandencevalue);
            if(attandencevalue==0) {
            	
            	System.out.println("inside attandancde");
            	
            	String sql = "INSERT INTO attendance (emp_id, checkin_time, working_mode, latitude, longitude, date, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                
                ps.setString(1, attendance_vo.getEmp_id());
                ps.setString(2, attendance_vo.getCheckin());
                ps.setString(3, attendance_vo.getMode());
                ps.setString(4, attendance_vo.getLatitude());
                ps.setString(5, attendance_vo.getLongitude());
                ps.setString(6, todaydate);
                ps.setString(7, attendance_vo.getAddress());
                int rowsInserted = ps.executeUpdate();
                if (rowsInserted > 0) {
                    success = "new";
                }
                
                
            	
            }
            else {
            	success = "old";
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return success;
    }

    public boolean updateCheckoutTime(String employeeId, String checkoutTimeStr) {
    	boolean success = false;
        try {
            long millis = System.currentTimeMillis();
            java.sql.Date date = new java.sql.Date(millis);
            String todaydate = String.valueOf(date);
            
           
            
            String emp_id = employeeId;
            boolean result = isCheckOutPresent(employeeId);
            System.out.println("checkoutvalue : " + result);
            if(result == false) {
            	
            	System.out.println("inside checkout");
            	
            String sql = "UPDATE attendance SET checkout_time = ? WHERE emp_id = ? AND date = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            
            stmt.setString(1, checkoutTimeStr);
            stmt.setString(2, employeeId);
            stmt.setString(3, todaydate);
            
            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
            	 success = true;
            } 
            
            }else {
            	 success = false;
            }
        }
           catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
        
    }

    public List<Attendance_vo> getAllAttendance() {
        List<Attendance_vo> list1 = new ArrayList<>();
        Attendance_vo attendance_vo = null;

        try {
            String sqlString = "SELECT emp_id, checkin_time, working_mode, latitude, longitude, checkout_time, date, address FROM attendance";
            PreparedStatement pStatement = conn.prepareStatement(sqlString);
            
            ResultSet rSet = pStatement.executeQuery();
            
            while (rSet.next()) {
                attendance_vo = new Attendance_vo();
                attendance_vo.setEmp_id(rSet.getString(1));
                attendance_vo.setCheckin(rSet.getString(2));
                attendance_vo.setMode(rSet.getString(3));
                attendance_vo.setLatitude(rSet.getString(4));
                attendance_vo.setLongitude(rSet.getString(5));
                attendance_vo.setCheckout(rSet.getString(6));
                attendance_vo.setDate(rSet.getString(7));
                attendance_vo.setAddress(rSet.getString(8));
                list1.add(attendance_vo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list1;
    }

    // Method to check if the user has already checked in today
    public int hasCheckedInToday(String empId) {
        int count = 0;
        try {
            // Query to check if there is a check-in record for today
            String sql = "SELECT COUNT(*) as COUNT FROM attendance WHERE emp_id = ? AND date = CURRENT_DATE";
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
    
    
    public boolean isCheckOutPresent(String employeeId) {
        boolean checkOutPresent = false;

        

        try{
        	String query = "SELECT checkout_time FROM attendance WHERE emp_id = ? AND date = CURRENT_DATE AND checkout_time IS NOT NULL;";
        	PreparedStatement stmt = conn.prepareStatement(query);
        	stmt.setString(1, employeeId);

           ResultSet rs = stmt.executeQuery();
           checkOutPresent = rs.next(); // If there's a result, check-out time is present
            System.out.println("checkOutPresent : " + checkOutPresent);

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return checkOutPresent;
    }
    public List<Attendance_vo> getAttendanceByEmpId(String empId) {
        List<Attendance_vo> attendanceList = new ArrayList<>();
        String query = "SELECT emp_id, checkin_time, checkout_time, working_mode, latitude, longitude, date, address FROM attendance WHERE emp_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, empId);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Attendance_vo attendance = new Attendance_vo();
                    attendance.setEmp_id(rs.getString("emp_id"));
                    attendance.setCheckin(rs.getString("checkin_time"));
                    attendance.setCheckout(rs.getString("checkout_time"));
                    attendance.setMode(rs.getString("working_mode"));
                    attendance.setLatitude(rs.getString("latitude"));
                    attendance.setLongitude(rs.getString("longitude"));
                    attendance.setDate(rs.getString("date"));
                    attendance.setAddress(rs.getString("address"));
                    attendanceList.add(attendance);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return attendanceList;
    }


    
}
