package com.example.member;

import com.example.board.BoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value="/login")
public class MemberController {

    @Autowired
    MemberService service;

    @RequestMapping(value="/login", method = RequestMethod.GET)
    public String login(){
        return "login";
    }

    @RequestMapping(value="/loginOk",method=RequestMethod.POST)
    public String loginCheck(HttpSession session, MemberVO vo){
        String returnURL = "";
        if (session.getAttribute("login") != null ){
            session.removeAttribute("login");
        }

        MemberVO loginvo = service.getMember(vo);
        if ( loginvo != null ){
            // 로그인성공
            System.out.println("로그인성공!");
            session.setAttribute("login", loginvo);
            // 로그인 후 리다이렉트할 때, userId 세션에 저장
            session.setAttribute("userId", vo.getUserId());
            returnURL = "redirect:/dashboard";         }
        else {
            // 로그인실패
            System.out.println("로그인실패!");
            returnURL = "redirect:/login/login";
        }
        return returnURL;
    }

    // 로그아웃하는부분
    @RequestMapping(value="/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return"redirect:/login/login";
    }
}
