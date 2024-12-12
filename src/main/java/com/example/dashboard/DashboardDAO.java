package com.example.dashboard;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class DashboardDAO {
    @Autowired
    SqlSessionTemplate sqlSession;

    public List<DashboardVO> getSubjectsByUserId(String userId) {
        List<DashboardVO> subjects = sqlSession.selectList("Dashboard.getSubjectsByUserId", userId);
        return subjects;
    }

    public List<DashboardVO> getAllSubjects() {
        List<DashboardVO> subjects = sqlSession.selectList("Dashboard.getAllSubjects");
        return subjects;
    }
}