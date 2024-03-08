package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;


public interface BoardMapper { //마이바티스를 이용하여 sql처리함

	//@Select("select * from tbl_board where bno > 0") // bno > 0 -> bno가 pk여서 index처리가 돼서 빠른 결과를 확인할 수 있다.
	public List<BoardVO> getList(); //추상메서드 (구현 클래서에서 동작)
	
	public List<BoardVO> getListWithPaging(Criteria cri); //페이징이 가미된 메서드
	
	public void insert(BoardVO board ); //추상메서드 -> board 객체를 받아서 insert sql문을 처리한다.
	public void insertSelectKey(BoardVO board); // insert전에 시퀀스 객체로 번호를 먼저 받아 insert 처리함.
	public BoardVO read(Long bno); // bno를 받아 객체를 가져옴 
	public int delete(Long bon); //bno를 받아 객체를 삭제함
	public int update(BoardVO board); // board객체를 업데이트 처리
	
	public int getTotalCount(Criteria cri); //토탈 게시물을 구함
	
	public void updateReplyCnt(@Param("bno") Long bno , @Param("amount") int amount);
	
	
}