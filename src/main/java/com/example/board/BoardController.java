package com.example.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BoardController {

    @Autowired
    private BoardService boardService;

    @RequestMapping("/")
    public String home(){
        return "index";
    }

    @GetMapping("/board/list")
    public String list(@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                       @RequestParam(value = "sortOption", required = false) String sortOption,
                       @RequestParam(value = "subjectName", required = false) String subjectName, // 추가된 파라미터
                       Model model) {
        List<BoardVO> boards;
        // 검색어가 존재하면 검색된 게시글을 가져옴
        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            boards = boardService.searchBoards(searchKeyword, subjectName);
        } else {
            // 검색어가 없으면 주어진 과목(subjectName)에 따른 게시글을 가져옴
            boards = boardService.getBoardsBySubject(subjectName);
        }

        // 정렬 옵션 처리 (필터링된 게시글에 대해서만 정렬)
        if ("title".equals(sortOption)) {
            boards.sort(Comparator.comparing(BoardVO::getTitle));
        } else if ("regdate".equals(sortOption)) {
            boards.sort(Comparator.comparing(BoardVO::getRegdate).reversed());
        } else if ("likes".equals(sortOption)) {
            boards.sort(Comparator.comparing(BoardVO::getLike).reversed());
        }

        // 모델에 데이터 추가
        model.addAttribute("list", boards);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("sortOption", sortOption);
        model.addAttribute("subjectName", subjectName);

        return "posts"; // 반환할 뷰 이름
    }




    @RequestMapping(value = "/board/addpostform", method = RequestMethod.GET)
    public String boardAdd(){
        return "addpostform";
    }

    @RequestMapping(value = "/board/addok", method = RequestMethod.POST)
    public String boardAddOK(@ModelAttribute BoardVO vo, HttpSession session) {
        // 세션에서 현재 로그인된 사용자의 userid 값을 가져옴
        String userid = (String) session.getAttribute("userId");

        if (userid != null) {
            // BoardVO 객체에 userid 값 설정
            vo.setUserid(userid);
        } else {
            // userid가 없으면 (로그인되지 않은 상태일 경우)
            System.out.println("로그인되지 않은 사용자");
            return "redirect:/login"; // 로그인 페이지로 리다이렉트
        }

        // 데이터 추가
        int i = boardService.insertBoard(vo);
        if (i == 0) {
            System.out.println("데이터 추가 실패!");
            return "error";
        } else {
            System.out.println("데이터 추가 성공!");
            System.out.println("VO: " + vo.toString());
            return "redirect:/board/list?subjectName=" + vo.getSubject();
        }
    }



    @GetMapping("/board/view/{id}")
    public String view(@PathVariable("id") int id, Model model) {
//        boardService.incrementViewCount(id);

        BoardVO board = boardService.getBoardById(id);
        model.addAttribute("board", board);

        return "view";
    }

    @PostMapping("/board/like/{id}")
    public ResponseEntity<Map<String, Object>> likePost(@PathVariable("id") int id) {
        try {
            int updatedLikes = boardService.incrementLikes(id);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("likes", updatedLikes);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("error", "좋아요 요청 처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }

    @RequestMapping(value = "/board/edit/{id}", method = RequestMethod.GET)
    public String boardEdit(@PathVariable("id") Integer id, Model model){
        BoardVO vo = boardService.getBoard(id);
        model.addAttribute("boardVO", vo);
        return "editform";
    }

    @RequestMapping(value = "/board/editok", method = RequestMethod.POST)
    public String boardEditOk(BoardVO vo) {
        int i = boardService.updateBoard(vo);
        if (i == 0) {
            System.out.println("데이터 수정 실패!");
            return "error";
        } else {
            System.out.println("데이터 수정 성공!");
            return "redirect:/board/view/" + vo.getId(); // 수정된 게시물 상세 페이지로 이동
        }
    }

    @RequestMapping(value = "/board/delete/{id}", method = RequestMethod.POST)
    public String deletePost(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        System.out.println("게시글 삭제 요청 수신: " + id);
        boardService.deleteBoard(id);
        System.out.println("board/delete: " + id);
        return "redirect:/board/list";  // 게시물 삭제 후 목록으로 리디렉션
    }
}
