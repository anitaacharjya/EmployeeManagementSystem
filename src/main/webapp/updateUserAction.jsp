<%@page import="com.pcs.db.Dbconnect"%>
<%@ page import="com.pcs.employee.vo.User" %>
<%@ page import="com.pcs.employee.dao.impl.UserDaoImpl" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>

<%
    String username = request.getParameter("username");
    String name = request.getParameter("name");
    String gender = request.getParameter("gender");
    String dob = request.getParameter("dob");
    String emp_id = request.getParameter("emp_id");
    String doj = request.getParameter("doj");
    String email = request.getParameter("email");
    String mobileno = request.getParameter("mobileno");
    String address = request.getParameter("address");
    String password = request.getParameter("password");

    boolean f = false;
    Connection conn = null;
    try {
        
        conn = Dbconnect.getConn();

        UserDaoImpl userDao = new UserDaoImpl(conn);
        User user = new User();
        user.setUsername(username);
        user.setName(name);
        user.setGender(gender);
        user.setDob(dob);
        user.setEmp_id(emp_id);
        user.setDoj(doj);
        user.setEmail(email);
        user.setMobileno(mobileno);
        user.setAddress(address);
        user.setPassword(password);

        f = userDao.updateUser(user);
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (conn != null) {
            try {
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    if (f) {
        response.sendRedirect("EmployeeList.jsp");
    } else {
        response.sendRedirect("EmployeeList.jsp");
    }
%>
