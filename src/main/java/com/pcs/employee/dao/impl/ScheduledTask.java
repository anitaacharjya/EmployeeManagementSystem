package com.pcs.employee.dao.impl;

import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import com.pcs.db.Dbconnect;
import com.pcs.employee.vo.WorkReportVo;

public class ScheduledTask {

    private Timer timer;

    public ScheduledTask() {
        timer = new Timer(true);
        timer.scheduleAtFixedRate(new CheckReportsTask(), 0, 24 * 60 * 60 * 1000); // Run daily
    }

    class CheckReportsTask extends TimerTask {
        @Override
        public void run() {
        	WorkReportDaoImpl dao = new WorkReportDaoImpl(Dbconnect.getConn());
            // Get today's date
            String today = new java.sql.Date(System.currentTimeMillis()).toString();
            // Get list of employees without work report for today
            List<WorkReportVo> employeesWithoutReport = dao.getEmployeesWithoutReport();

            for (WorkReportVo emp : employeesWithoutReport) {
                // Send email notification to each employee
                String subject = "Missing Work Report";
                String content = "Dear " + emp.getName()+ ",\n\n" +
                                 "Please submit your daily work report for today.\n\n" +
                                 "Thank you.\n\n"+
                                 "PCS GLOBAL Pvt.Ltd";
                System.out.println("name : "+emp.getName());
                EmailUtil.sendEmail(emp.getEmail(), subject, content);
            }
        }
    }
}
