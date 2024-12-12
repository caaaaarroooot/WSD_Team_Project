package com.example.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class DashboardController {
    @Autowired
    private DashboardService dashboardService;

    @GetMapping("/dashboard")
    public ModelAndView dashboard(HttpSession session) {
        String userId = (String) session.getAttribute("userId");

        // userId가 'admin'일 경우 모든 과목을 가져옴
        List<DashboardVO> subjects;
        if ("admin".equals(userId)) {
            subjects = dashboardService.getAllSubjects();  // 모든 과목을 가져옴
        } else {
            subjects = dashboardService.getUserSubjects(userId);  // 사용자별 과목을 가져옴
        }

        int subjectsSize = (subjects != null) ? subjects.size() : 0;

        ModelAndView mv = new ModelAndView("dashboard");
        mv.addObject("subjects", subjects);
        mv.addObject("subjectsSize", subjectsSize);

        return mv;
    }
}