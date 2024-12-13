package com.example.dashboard;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    public void addSubject(String userId, String subject) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("subjectName", subject);
        System.out.println(userId + " " + subject);
        sqlSession.insert("Dashboard.addSubject", paramMap);
    }
    // 과목 수정
    public int editSubject(String userId, String subject, String newName) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("subject", subject);
        paramMap.put("newName", newName);
        return sqlSession.update("Dashboard.editSubject", paramMap);
    }

    // 과목 삭제
    public int deleteSubject(String userId, String subject) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userId", userId);
        paramMap.put("subject", subject);
        return sqlSession.delete("Dashboard.deleteSubject", paramMap);
    }
}