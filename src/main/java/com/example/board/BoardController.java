package com.example.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
        System.out.println(subjectName);
        // 과목 이름으로 필터링하는 경우
        if (subjectName != null && !subjectName.isEmpty()) {
            boards = boardService.getBoardsBySubject(subjectName);
        }
        // 검색어로 필터링하는 경우
        else if (searchKeyword != null && !searchKeyword.isEmpty()) {
            boards = boardService.searchBoards(searchKeyword);
        }
        // 기본 리스트
        else {
            boards = boardService.getBoardList();
        }

        // 정렬 옵션 처리
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
    public String boardAddOK(@ModelAttribute BoardVO vo) {
        int i = boardService.insertBoard(vo);
        if (i == 0) {
            System.out.println("데이터 추가 실패!");
            return "error";
        } else {
            System.out.println("데이터 추가 성공!");
            return "redirect:/board/list";
        }
    }

    @GetMapping("/board/view/{id}")
    public String view(@PathVariable("id") int id, Model model) {
        boardService.incrementViewCount(id);

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

    @GetMapping("/board/delete/{id}")
    public ResponseEntity<Map<String, Object>> deletePost(@PathVariable("id") int id) {
        Map<String, Object> response = new HashMap<>();
        try {
            int result = boardService.deleteBoard(id);
            if (result > 0) {
                response.put("success", true);
            } else {
                response.put("success", false);
                response.put("message", "게시물이 존재하지 않습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "서버 오류가 발생했습니다.");
            e.printStackTrace();
        }
        return ResponseEntity.ok(response);
    }
}
