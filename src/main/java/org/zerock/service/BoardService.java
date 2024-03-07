package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardService {
//서비스 계층을 담당한다. 
//서비스 계층이란 매퍼에서 넘어온 여러개의 dto나 vo객체를 믹스한다.
//인터페이스로 클래스를 만들었기 때문에 여기서 생성한 메서드는 추상 메서드이다.

	public void register(BoardVO board); //게시물을 등록한다. (폼에서 받음)
	
	public BoardVO get(Long bno); //번호를 이용해서 게시물을 한개 객체로 가져온다.
	
	public boolean modify(BoardVO board); //객체를 받아 수정한다. 리턴은 수정 성공/실패
	
	public boolean remove(Long bno); //번호를 받아 삭제한다. 리턴은 성공 실패

//	public List<BoardVO> getList() ; // 전체 게시물을 받아 리스트안에 객체로 리턴한다.
	
	public List<BoardVO> getList(Criteria cri) ; //페이징 조건 추가
	
	public int getTotal(Criteria cri);
	
}
