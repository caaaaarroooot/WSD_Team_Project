package com.example.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
    public String list(@RequestParam(value = "subjectName", required = false) String subjectName, Model model) {
        List<BoardVO> boards;
        System.out.println(subjectName);
        if (subjectName != null && !subjectName.isEmpty() ) {
            boards = boardService.getBoardsBySubject(subjectName);  // 필터링된 게시물
        } else {
            boards = boardService.getBoardList();  // 전체 게시물
        }
        model.addAttribute("list", boards);
        model.addAttribute("subjectName", subjectName);
        return "posts";  // JSP 파일 이름
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
        BoardVO board = boardService.getBoardById(id);
        model.addAttribute("board", board);
        return "view"; // view.jsp로 이동
    }

    @PostMapping("/board/like/{id}")
    public ResponseEntity<Map<String, Object>> likePost(@PathVariable("id") int id) {
        try {
            int updatedLikes = boardService.incrementLikes(id);
            Map<String, Object> response = new HashMap<>();
            response.put("likes", updatedLikes);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "좋아요 요청 처리 중 오류가 발생했습니다.");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponse);
        }
    }
//    @RequestMapping(value = "/board/edit/{id}", method = RequestMethod.GET)
//    public String boardEdit(@PathVariable("id") Integer id, Model model){
//        BoardVO vo = boardService.getBoard(id);
//        model.addAttribute("boardVO", vo);
//        return "editform";
//    }
//
//    @RequestMapping(value = "/board/editok", method = RequestMethod.POST)
//    public String boardEditOk(BoardVO vo){
//        int i = boardService.updateBoard(vo);
//        if(i == 0)
//            System.out.println("데이터 추가 실패!");
//        else
//            System.out.println("데이터 추가 성공!");
//        return "redirect:list";
//    }

//    @RequestMapping(value = "/board/delete/{id}", method = RequestMethod.GET)
//    public String boardDelete(@PathVariable("id") Integer id){
//        int i = boardService.deleteBoard(id);
//
//        return "redirect:../list";
//    }


}
