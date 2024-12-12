package com.example.member;

import com.example.board.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberService {
    @Autowired
    MemberDAO memberDAO;

    public MemberVO getMember(MemberVO memberVO) {
        System.out.println("Checking database for UserId: " + memberVO.getUserId());
        return memberDAO.getMember(memberVO);
    }
}
