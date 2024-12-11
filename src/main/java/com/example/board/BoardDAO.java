package com.example.board;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardDAO {

    @Autowired
    SqlSessionTemplate sqlSession;

    public List<BoardVO> getBoardList() {
        return sqlSession.selectList("Board.getBoardList");
    }

//    public int getTotalcnt() {
//        return sqlSession.selectOne("Board.getTotalcnt");
//    }

//    // Insert, update, delete 메서드도 MyBatis 방식으로 작성 가능
//    public int insertBoard(BoardVO vo) {
//        return sqlSession.insert("Board.insertBoard", vo);
//    }
//
//    public int deleteBoard(int id) {
//        return sqlSession.delete("Board.deleteBoard", id);
//    }
//
//    public int updateBoard(BoardVO vo) {
//        return sqlSession.update("Board.updateBoard", vo);
//    }
//
//    public BoardVO getBoard(int seq) {
//        return sqlSession.selectOne("Board.getBoard", seq);
//    }
}
