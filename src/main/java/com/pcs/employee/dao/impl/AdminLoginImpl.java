package com.pcs.employee.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.pcs.employee.vo.AdminVo;

public class AdminLoginImpl implements AdminLogin {
	private Connection conn;

	public AdminLoginImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	@Override
	public AdminVo login(String username, String password) {

		AdminVo Av = null;
		System.out.println("Under admin login");

		 try {
		        String sql = "select username,password from admin where username=? and password=?";
		        PreparedStatement ps = conn.prepareStatement(sql);
		        ps.setString(1, username);
		        ps.setString(2, password);

		        ResultSet rs = ps.executeQuery();

		        if (rs.next()) {
		            Av = new AdminVo();
		            Av.setUsername(rs.getString(1));
		            Av.setPassword(rs.getString(2));
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		return Av;
	}

   
	
	
	

}
