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

        // 모델에서 데이터를 확인하는 방법
        Map<String, Object> model = mv.getModel();  // ModelAndView에서 모델 데이터 가져오기
        System.out.println("Model contents: " + model);

        // "subjects" 값 출력
        List<DashboardVO> subjectsFromModel = (List<DashboardVO>) model.get("subjects");
        System.out.println("Subjects: " + subjectsFromModel);

        // "subjectsSize" 값 출력
        Integer subjectsSizeFromModel = (Integer) model.get("subjectsSize");
        System.out.println("Subjects Size: " + subjectsSizeFromModel);

        return mv;
    }
}
