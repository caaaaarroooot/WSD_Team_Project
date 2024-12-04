package com.example.board;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class BoardDAO {

    @Autowired
    SqlSessionTemplate sqlSession;

    public List<BoardVO> getBoardList() {
        List<BoardVO> list = sqlSession.selectList("Board.getBoardList");
        return list;
    }

//    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
//        this.jdbcTemplate = jdbcTemplate;
//    }
//
//    public int insertBoard(BoardVO vo) {
//        return jdbcTemplate.update(BOARD_INSERT, new Object[]{vo.getTitle(), vo.getWriter(), vo.getContent()});
//    }
//
//    // 글 삭제
//    public int deleteBoard(int id) {
//        return jdbcTemplate.update(BOARD_DELETE, id);
//    }
//
//    public int updateBoard(BoardVO vo) {
//        return jdbcTemplate.update(BOARD_UPDATE, new Object[]{vo.getTitle(), vo.getWriter(), vo.getContent(), vo.getSeq()});
//    }
//
//    public BoardVO getBoard(int seq) {
//        return jdbcTemplate.queryForObject(BOARD_GET, new Object[]{seq},
//                new BeanPropertyRowMapper<BoardVO>(BoardVO.class));
//    }
//
//    public int getTotalcnt() {
//        return (int)jdbcTemplate.queryForObject("Select count(*) from BOARD",Integer.class );
//    }
}
