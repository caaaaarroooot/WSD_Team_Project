package com.example.member;

public class MemberVO {
    private String userId;
    private String password;
    private String username;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userid) {
        this.userId = userid;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}