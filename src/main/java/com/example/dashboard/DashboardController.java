package com.example.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class DashboardController {
    @Autowired
    private DashboardService dashboardService;

    @GetMapping("/dashboard")
    public ModelAndView dashboard(HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        List<DashboardVO> subjects = dashboardService.getUserSubjects(userId);

        int subjectsSize = (subjects != null) ? subjects.size() : 0;

        ModelAndView mv = new ModelAndView("dashboard");
        mv.addObject("subjects", subjects);
        mv.addObject("subjectsSize", subjectsSize);

        return mv;
    }
}
