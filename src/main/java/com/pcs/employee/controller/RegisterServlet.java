package com.pcs.employee.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.pcs.db.Dbconnect;
import com.pcs.employee.dao.impl.UserDaoImpl;
import com.pcs.employee.vo.User;



@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse res) throws ServletException, IOException {
	    try {
	    	 // Retrieve form data from request
	        String name = request.getParameter("name");
	        String dob = request.getParameter("dob");
	        String gender = request.getParameter("gender");
	        String address = request.getParameter("address");
	        String city = request.getParameter("city");
	        String state = request.getParameter("state");
	        String country = request.getParameter("country");
	        String maritalStatus = request.getParameter("marital_status");
	        String nationality = request.getParameter("nationality");
	        String email = request.getParameter("email");
	        String mobile = request.getParameter("mobile");
	        String telephone = request.getParameter("telephone");
	        String identityDocument = request.getParameter("identity_document");
	        String identityNumber = request.getParameter("identity_number");
	        String employmentType = request.getParameter("employment_type");
	        String joiningDate = request.getParameter("joining_date");
	        String bloodGroup = request.getParameter("blood_group");
	        String designation = request.getParameter("designation");
	        String department = request.getParameter("department");
	        String empId = request.getParameter("emp_id");
	        String role = request.getParameter("role");
	        String panNumber = request.getParameter("pan_number");
	        String bankName = request.getParameter("bank_name");
	        String bankAccountNumber = request.getParameter("bank_account_number");
	        String ifscCode = request.getParameter("ifsc_code");
	        String pfAccountNumber = request.getParameter("pf_account_number");
	        String username = request.getParameter("username");
	        String password = request.getParameter("password");

	        // Create User object and set its fields
	        User user = new User();
	        user.setName(name);
	        user.setDob(dob);
	        user.setGender(gender);
	        user.setAddress(address);
	        user.setCity(city);
	        user.setState(state);
	        user.setCountry(country);
	        user.setMaritalStatus(maritalStatus);
	        user.setNationality(nationality);
	        user.setEmail(email);
	        user.setMobileno(mobile);
	        user.setTelephone(telephone);
	        user.setIdentityDocument(identityDocument);
	        user.setIdentityNumber(identityNumber);
	        user.setEmploymentType(employmentType);
	        user.setDoj(joiningDate);
	        user.setBloodGroup(bloodGroup);
	        user.setDesignation(designation);
	        user.setDepartment(department);
	        user.setEmp_id(empId);
	        user.setRole(role);
	        user.setPanNumber(panNumber);
	        user.setBankName(bankName);
	        user.setBankAccountNumber(bankAccountNumber);
	        user.setIfscCode(ifscCode);
	        user.setPfAccountNumber(pfAccountNumber);
	        user.setUsername(username);
	        user.setPassword(password);

	        // Store User object in session
	        HttpSession session = request.getSession();
	        session.setAttribute("user", user);

	        // Use UserDaoImpl to register the user
	        UserDaoImpl dao = new UserDaoImpl(Dbconnect.getConn());
	        boolean f = dao.userRegister(user);

	        // Redirect based on registration success or failure
	        if (f) {
	            session.setAttribute("Success", "User registration successful");
	            res.sendRedirect("register.jsp");
	        } else {
	            session.setAttribute("Failed", "Something went wrong");
	            res.sendRedirect("register.jsp");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}

}
