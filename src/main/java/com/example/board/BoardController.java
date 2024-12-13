package com.example.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
//
//    @RequestMapping(value = "/board/addok", method = RequestMethod.POST)
//    public String boardAddOK(BoardVO vo){
//        int i = boardService.insertBoard(vo);
//        if(i == 0)
//            System.out.println("데이터 추가 실패!");
//        else
//            System.out.println("데이터 추가 성공!");
//        return "redirect:list";
//    }
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

    @RequestMapping(value = "/board/view/{id}", method = RequestMethod.GET)
    public String boardView(@PathVariable("id") Integer id, Model model) {
        BoardVO board = boardService.getBoard(id);  // 게시글 조회
        model.addAttribute("board", board);  // 조회된 게시글 정보를 Model에 추가
        return "view";  // view.jsp 파일로 이동
    }


}
