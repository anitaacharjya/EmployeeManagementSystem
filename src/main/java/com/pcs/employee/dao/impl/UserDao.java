package com.pcs.employee.dao.impl;

import java.util.List;

import com.pcs.employee.vo.User;

public interface UserDao {
public boolean userRegister(User us);
public int countRegisteredUsers();
public User login(String username,String password);
public List<User> getAllUsers();
}
