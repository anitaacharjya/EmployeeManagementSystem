package com.pcs.employee.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.pcs.db.Dbconnect;
import com.pcs.employee.vo.User;

public class UserDaoImpl implements UserDao {

    private Connection conn;

    public UserDaoImpl(Connection conn) {
        super();
        this.conn = conn;
    }

    @Override
    public boolean userRegister(User us) {
        boolean f = false;
        try {
            // SQL query to insert into the `register` table
            String sql = "INSERT INTO register (name, dob, gender, address, city, state, country, marital_status, nationality, " +
                         "email, mobile, telephone, identity_document, identity_number, employment_type, joining_date, " +
                         "blood_group, designation, department, emp_id, role, pan_number, bank_name, bank_account_number, " +
                         "ifsc_code, pf_account_number, username, password) " +
                         "VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = conn.prepareStatement(sql);
            
            // Set the fields in the `register` table
            ps.setString(1, us.getName());
            ps.setString(2, us.getDob());
            ps.setString(3, us.getGender());
            ps.setString(4, us.getAddress());
            ps.setString(5, us.getCity());
            ps.setString(6, us.getState());
            ps.setString(7, us.getCountry());
            ps.setString(8, us.getMaritalStatus());
            ps.setString(9, us.getNationality());
            ps.setString(10, us.getEmail());
            ps.setString(11, us.getMobileno());
            ps.setString(12, us.getTelephone());
            ps.setString(13, us.getIdentityDocument());
            ps.setString(14, us.getIdentityNumber());
            ps.setString(15, us.getEmploymentType());
            ps.setString(16, us.getDoj());
            ps.setString(17, us.getBloodGroup());
            ps.setString(18, us.getDesignation());
            ps.setString(19, us.getDepartment());
            ps.setString(20, us.getEmp_id());
            ps.setString(21, us.getRole());
            ps.setString(22, us.getPanNumber());
            ps.setString(23, us.getBankName());
            ps.setString(24, us.getBankAccountNumber());
            ps.setString(25, us.getIfscCode());
            ps.setString(26, us.getPfAccountNumber());
            ps.setString(27, us.getUsername());
            ps.setString(28, us.getPassword());

            int i = ps.executeUpdate();
            
            // SQL query to insert into the `user` table
            String sqlforreg = "INSERT INTO user (emp_id, password, name, email) VALUES (?, ?, ?, ?)";
            PreparedStatement ps1 = conn.prepareStatement(sqlforreg);
            
            // Set the fields in the `user` table
            ps1.setString(1, us.getEmp_id());
            ps1.setString(2, us.getPassword());
            ps1.setString(3, us.getName());
            ps1.setString(4, us.getEmail());

            int j = ps1.executeUpdate();
            
            if (i == 1 && j == 1) {
                f = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }


    @Override
    public User login(String emp_id, String password) {
        User us = null;
        try {
            String sql = "SELECT emp_id,password,name,email FROM user WHERE emp_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, emp_id);
            

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                us = new User();
               
               
                us.setEmp_id(rs.getString(1));
                us.setPassword(rs.getString(2));
                us.setName(rs.getString(3));
                us.setEmail(rs.getString(4));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return us;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        try {
            // SQL query to select all fields from the register table
            String sql = "SELECT name, dob, gender, address, city, state, country, marital_status, nationality, email, mobile, " +
                         "telephone, identity_document, identity_number, employment_type, joining_date, blood_group, designation, department, " +
                         "pan_number, bank_name, bank_account_number, ifsc_code, pf_account_number, emp_id, username, password FROM register";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            // Loop through the result set
            while (rs.next()) {
                User us = new User();
                // Set user object fields based on the result set
                us.setName(rs.getString(1)); // name
                us.setDob(rs.getString(2)); // dob
                us.setGender(rs.getString(3)); // gender
                us.setAddress(rs.getString(4)); // address
                us.setCity(rs.getString(5)); // city
                us.setState(rs.getString(6)); // state
                us.setCountry(rs.getString(7)); // country
                us.setMaritalStatus(rs.getString(8)); // maritalStatus
                us.setNationality(rs.getString(9)); // nationality
                us.setEmail(rs.getString(10)); // email
                us.setMobileno(rs.getString(11)); // mobileno
                us.setTelephone(rs.getString(12)); // telephone
                us.setIdentityDocument(rs.getString(13)); // identityDocument
                us.setIdentityNumber(rs.getString(14)); // identityNumber
                us.setEmploymentType(rs.getString(15)); // employmentType
                us.setDoj(rs.getString(16)); // doj
                us.setBloodGroup(rs.getString(17)); // bloodGroup
                us.setDesignation(rs.getString(18)); // designation
                us.setDepartment(rs.getString(19)); // department
                us.setPanNumber(rs.getString(20)); // panNumber
                us.setBankName(rs.getString(21)); // bankName
                us.setBankAccountNumber(rs.getString(22)); // bankAccountNumber
                us.setIfscCode(rs.getString(23)); // ifscCode
                us.setPfAccountNumber(rs.getString(24)); // pfAccountNumber
                us.setEmp_id(rs.getString(25)); // emp_id
                us.setUsername(rs.getString(26)); // username
                us.setPassword(rs.getString(27)); // password
                // Add the user object to the user list
                userList.add(us);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Return the list of users
        return userList;
    }
    public List<User> getAllUsersByEmp_Id(String emp_id) {
        List<User> userList = new ArrayList<>();
        try {
        	Dbconnect dbconnect = new Dbconnect();
        	Connection conn = dbconnect.getConn();
            // SQL query to select all fields from the register table
            String sql = "SELECT name, dob, gender, address, city, state, country, marital_status, nationality, email, mobile, " +
                         "telephone, identity_document, identity_number, employment_type, joining_date, blood_group, designation, department, " +
                         "pan_number, bank_name, bank_account_number, ifsc_code, pf_account_number, emp_id, username, password FROM register where emp_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, emp_id);
            ResultSet rs = ps.executeQuery();
            // Loop through the result set
            while (rs.next()) {
                User us = new User();
                // Set user object fields based on the result set
                us.setName(rs.getString(1)); // name
                us.setDob(rs.getString(2)); // dob
                us.setGender(rs.getString(3)); // gender
                us.setAddress(rs.getString(4)); // address
                us.setCity(rs.getString(5)); // city
                us.setState(rs.getString(6)); // state
                us.setCountry(rs.getString(7)); // country
                us.setMaritalStatus(rs.getString(8)); // maritalStatus
                us.setNationality(rs.getString(9)); // nationality
                us.setEmail(rs.getString(10)); // email
                us.setMobileno(rs.getString(11)); // mobileno
                us.setTelephone(rs.getString(12)); // telephone
                us.setIdentityDocument(rs.getString(13)); // identityDocument
                us.setIdentityNumber(rs.getString(14)); // identityNumber
                us.setEmploymentType(rs.getString(15)); // employmentType
                us.setDoj(rs.getString(16)); // doj
                us.setBloodGroup(rs.getString(17)); // bloodGroup
                us.setDesignation(rs.getString(18)); // designation
                us.setDepartment(rs.getString(19)); // department
                us.setPanNumber(rs.getString(20)); // panNumber
                us.setBankName(rs.getString(21)); // bankName
                us.setBankAccountNumber(rs.getString(22)); // bankAccountNumber
                us.setIfscCode(rs.getString(23)); // ifscCode
                us.setPfAccountNumber(rs.getString(24)); // pfAccountNumber
                us.setEmp_id(rs.getString(25)); // emp_id
                us.setUsername(rs.getString(26)); // username
                us.setPassword(rs.getString(27)); // password
                // Add the user object to the user list
                userList.add(us);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // Return the list of users
        return userList;
    }



    public List<User> getUsersByRole(String role) {
        List<User> userList = new ArrayList<>();
        try {
            String sql = "SELECT name, gender, dob, emp_id, doj, email, mobileno, address, username, password, role FROM register WHERE role = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, role);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User us = new User();
                us.setName(rs.getString(1));
                us.setGender(rs.getString(2));
                us.setDob(rs.getString(3));
                us.setEmp_id(rs.getString(4));
                us.setDoj(rs.getString(5));
                us.setEmail(rs.getString(6));
                us.setMobileno(rs.getString(7));
                us.setAddress(rs.getString(8));
                us.setUsername(rs.getString(9));
                us.setPassword(rs.getString(10));
                us.setRole(rs.getString(11));
                userList.add(us);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }

    public boolean updateUser(User us) {
        boolean f = false;
        try {
            String sql = "UPDATE register SET name = ?, gender = ?, dob = ?, emp_id = ?, doj = ?, email = ?, mobileno = ?, address = ?, password = ? WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, us.getName());
            ps.setString(2, us.getGender());
            ps.setString(3, us.getDob());
            ps.setString(4, us.getEmp_id());
            ps.setString(5, us.getDoj());
            ps.setString(6, us.getEmail());
            ps.setString(7, us.getMobileno());
            ps.setString(8, us.getAddress());
            ps.setString(9, us.getPassword());
            ps.setString(10, us.getUsername());

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean deleteUser(String username) {
        boolean f = false;
        try {
            String sql = "DELETE FROM register WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }

    public User getUserByUsername(String username) {
        User us = null;
        try {
            String sql = "SELECT name, gender, dob, emp_id, doj, email, mobileno, address, username, password, role FROM register WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                us = new User();
                us.setName(rs.getString(1));
                us.setGender(rs.getString(2));
                us.setDob(rs.getString(3));
                us.setEmp_id(rs.getString(4));
                us.setDoj(rs.getString(5));
                us.setEmail(rs.getString(6));
                us.setMobileno(rs.getString(7));
                us.setAddress(rs.getString(8));
                us.setUsername(rs.getString(9));
                us.setPassword(rs.getString(10));
                us.setRole(rs.getString(11));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return us;
    }

    public int countRegisteredUsers() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM register";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    public List<User> searchUsers(String query) throws Exception {
        String sql = "SELECT * FROM register WHERE emp_id LIKE ? OR username LIKE ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + query + "%");
            stmt.setString(2, "%" + query + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                List<User> userList = new ArrayList<>();
                while (rs.next()) {
                    User user = new User();
                    user.setEmp_id(rs.getString("emp_id"));
                    user.setName(rs.getString("name"));
                    user.setAddress(rs.getString("address"));
                    user.setGender(rs.getString("gender"));
                    user.setDob(rs.getString("dob"));
                    user.setDoj(rs.getString("doj"));
                    user.setMobileno(rs.getString("mobileno"));
                    user.setEmail(rs.getString("email"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    userList.add(user);
                }
                return userList;
            }
        }
    }
    
    public int countUniqueRoles() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(DISTINCT role) FROM register";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}
