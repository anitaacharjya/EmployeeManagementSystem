<%@page import="com.pcs.db.Dbconnect"%>
<%@ page import="com.pcs.employee.dao.impl.UserDaoImpl" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>

<%
    String username = request.getParameter("username");

    boolean f = false;
    Connection conn = null;
    try {
        conn =Dbconnect.getConn();

        UserDaoImpl userDao = new UserDaoImpl(conn);
        f = userDao.deleteUser(username);
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
