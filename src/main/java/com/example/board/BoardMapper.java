package com.example.board;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardMapper {
    List<BoardVO> getBoardList();

    List<BoardVO> getBoardsBySubject(String subjectName);

    int insertBoard(BoardVO board);
}
