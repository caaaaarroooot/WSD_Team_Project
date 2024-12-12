package com.example.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DashboardService {
    @Autowired
    private DashboardDAO dashboardDAO;

    public List<DashboardVO> getUserSubjects(String userId) {
        List<DashboardVO> subjects = dashboardDAO.getSubjectsByUserId(userId);
        System.out.println("Subjects in Service: " + subjects);
        return subjects;
    }
}