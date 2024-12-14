package com.example.dashboard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Collections;
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
        subjects = dashboardService.getUserSubjects(userId);  // 사용자별 과목을 가져옴


        int subjectsSize = (subjects != null) ? subjects.size() : 0;

        ModelAndView mv = new ModelAndView("dashboard");
        mv.addObject("subjects", subjects);
        mv.addObject("subjectsSize", subjectsSize);

        return mv;
    }
    @PostMapping("/addSubject")
    public String addSubject(@RequestParam("subjectName") String subjectName, HttpSession session) {
        String userId = (String) session.getAttribute("userId");  // 세션에서 userId를 가져옴

        if (userId != null && subjectName != null && !subjectName.isEmpty()) {
            // SubjectService에서 DB에 저장하는 메서드 호출, userId와 함께 과목 추가
            dashboardService.addSubject(userId, subjectName);
        }
        return "redirect:/dashboard"; // 과목 추가 후 대시보드로 리디렉션
    }

    @PostMapping("/editSubject")
    public String editSubject(@RequestParam("oldSubjectName") String oldSubjectName,
                              @RequestParam("newSubjectName") String newSubjectName,
                              HttpSession session) {
        String userId = (String) session.getAttribute("userId");  // 세션에서 userId를 가져옴

        if (userId != null && oldSubjectName != null && newSubjectName != null && !newSubjectName.isEmpty()) {
            // SubjectService에서 DB에서 과목 수정하는 메서드 호출
            dashboardService.editSubject(userId, oldSubjectName, newSubjectName);
        }
        return "redirect:/dashboard"; // 과목 수정 후 대시보드로 리디렉션
    }

    @PostMapping("/deleteSubject")
    public String deleteSubject(@RequestParam("subjectName") String subjectName, HttpSession session) {
        System.out.println("과목 삭제 요청 수신: " + subjectName);

        String userId = (String) session.getAttribute("userId");  // 세션에서 userId를 가져옴

        if (userId != null && subjectName != null && !subjectName.isEmpty()) {
            // SubjectService에서 DB에서 과목 삭제하는 메서드 호출
            dashboardService.deleteSubject(userId, subjectName);
        }
        return "redirect:/dashboard"; // 과목 삭제 후 대시보드로 리디렉션
    }

}