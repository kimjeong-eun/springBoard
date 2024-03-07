package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;


@Log4j2 //log.info로 콘솔 출력
@Service // 서비스 계층임을 선언 spring이 알아차릴 수 있도록
@AllArgsConstructor //lombok에서 생성자를 자동으로 구성 
public class BoardServiceImpl implements BoardService{
//인터페이스에 실제 코드가 작성괴는 구현체
	
	private BoardMapper mapper ; //영속계층으로 데이터 처리(jdbc)
	
	@Override
	public void register(BoardVO board) {
		//게시물을 등록하는 서비스를 제공한다.
		
		log.info("register 메서드 실행중........" + board);
		mapper.insertSelectKey(board); //매퍼에 있는 insert 쿼리문 실행이됨

	}
	@Override
	public BoardVO get(Long bno) {
		//한개의 게시물 번호를 이용하여 객체를 받아온다.
		
		log.info("get메서드 실행중 ...... 찾은 번호: " + bno);
		
		return mapper.read(bno); //매퍼에 있는 read메서드를 실행하면 bno로 객체를 찾아온다.
	}

	@Override
	public boolean modify(BoardVO board) {
		// 파라미터로 객체를 받아 수정을 진행한다..
		
		log.info("modify 메서드 실행중 .......받은 객체 : "+ board);
		
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(Long bno) {
		// 파라미터로 bno를 받아 삭제를 진행한다.
		
		return mapper.delete(bno)==1;
	}

	/*
	 * @Override public List<BoardVO> getList() { // //게시물의 모든 리스트를 출력한다.
	 * 
	 * log.info("getList메서드 실행중 .......");
	 * 
	 * return mapper.getList(); //매퍼에 있는 getList메서드를 실행해서 결화를 리턴한다.
	 * 
	 * }
	 */
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		// 
		
		log.info("getList메서드 실행중 ....cri값은:" + cri); 
		
		return mapper.getListWithPaging(cri);
	}
	@Override
	public int getTotal(Criteria cri) {
		// 총 게시물을 구함

		return mapper.getTotalCount(cri);
	}

}
