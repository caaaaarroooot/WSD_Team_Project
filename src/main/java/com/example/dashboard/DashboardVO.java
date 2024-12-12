package com.example.dashboard;

public class DashboardVO {
    private int id;
    private String user_id;
    private String subject_name;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserId() {
        return user_id;
    }

    public void setUserId(String userId) {
        this.user_id = userId;
    }

    public String getSubjectName() {
        return subject_name;
    }

    public void setSubjectName(String subjectName) {
        this.subject_name = subjectName;
    }
    // toString() 메서드 오버라이드
    @Override
    public String toString() {
        return "DashboardVO{" +
                "subjectName='" + subject_name + '\'' +
                '}';
    }
}