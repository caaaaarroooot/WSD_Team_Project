package com.example.member;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO {
    @Autowired
    SqlSessionTemplate sqlSession;
    public MemberVO getMember(MemberVO member) {
        System.out.println("Executing query with UserId: " + member.getUserId());
        return sqlSession.selectOne("Member.getMember", member);
    }
}
