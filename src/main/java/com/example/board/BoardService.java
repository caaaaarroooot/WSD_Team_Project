package com.example.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardService {

    @Autowired
    BoardDAO boardDAO;
    public List<BoardVO> getBoardList(){
        return boardDAO.getBoardList();
    }

    public List<BoardVO> getBoardsBySubject(String subjectName) {
        return boardDAO.getBoardsBySubject(subjectName);
    }
    public BoardVO getBoardById(int id) {
        return boardDAO.getBoardById(id);
    }

    public int insertBoard(BoardVO vo) {return boardDAO.insertBoard(vo);}
    public int deleteBoard(int id) {
        return boardDAO.deleteBoard(id);
    }
    public int updateBoard(BoardVO vo) {return boardDAO.updateBoard(vo);}
    public BoardVO getBoard(int seq){return boardDAO.getBoard(seq);}
    public int getTotalcnt() {return boardDAO.getTotalcnt();}

    public int incrementLikes(int id) {
        boardDAO.updateLikes(id);
        return boardDAO.getLikes(id);
    }
    public List<BoardVO> searchBoards(String searchKeyword) {
        return boardDAO.searchBoards(searchKeyword);
    }

    public void incrementViewCount(int id) {
        boardDAO.updateViewCount(id);
    }
    }
