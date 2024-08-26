package com.pcs.employee.controller;

import com.pcs.employee.dao.impl.ScheduledTask;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class ContextListener implements ServletContextListener {

    private ScheduledTask scheduledTask;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        scheduledTask = new ScheduledTask();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Clean up resources
    }
}
