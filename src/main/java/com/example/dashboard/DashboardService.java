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
        return subjects;
    }

    public List<DashboardVO> getAllSubjects() {
        List<DashboardVO> subjects = dashboardDAO.getAllSubjects();
        return subjects;
    }

    public void addSubject(String userId, String subjectName) {
        dashboardDAO.addSubject(userId, subjectName);
    }

    public boolean editSubject(String userId, String subjectName, String newName) {
        return dashboardDAO.editSubject(userId, subjectName, newName) > 0;
    }

    public boolean deleteSubject(String userId, String subjectName) {
        return dashboardDAO.deleteSubject(userId, subjectName) > 0;
    }
}