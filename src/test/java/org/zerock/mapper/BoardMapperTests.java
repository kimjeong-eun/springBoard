package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zero.persistence.DataSourceTests;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class) // junit으로 테스트 코드
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") //참고할 파일 
@Log4j2 
public class BoardMapperTests {
//인터페이스로 만든 매퍼 테스트용
	
	@Setter(onMethod_ = @Autowired ) //세터와 생성자 자동주입
	private BoardMapper mapper; 
	
	@Test
	public void testGetList() { //콘솔에서 리스트 목록 보기
		
		mapper.getList().forEach(board -> log.info(board));;	
	}
	@Test
	public void testInsert() {
		
		BoardVO board = new BoardVO(); //빈 객체 생성
		log.info("=====================================");
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("kkw"); //객체의 값 삽입 완료
		log.info("=====================================");
		mapper.insert(board);
		
		log.info(board);
	}
	
	@Test 
	public void testInsertSelectKey() {
		
		BoardVO board = new BoardVO(); //빈 객체 생성
		log.info("=====================================");
		board.setTitle("새로 작성하는 글");
		board.setContent("새로 작성하는 내용");
		board.setWriter("kkw"); //객체의 값 삽입 완료
		log.info("=====================================");
		
		mapper.insertSelectKey(board);
		
		log.info(board);
	}
	
	@Test
	public void testRead() {
		BoardVO board = mapper.read(22L); 
		// read메서드를 실행하면서 매개값으로 bno 1을 보내고
		//결과를 BoardVO 객체로 받는다. (변수는 board)
		
		log.info(board); //toString 이 되어있어 콘솔로 모든 값이 보임
	}
	
	@Test
	public void testDelete() {
		
		log.info("=====================================");
		log.info("삭제된 게시물 수 : "+ mapper.delete(3L));
		log.info("=====================================");

	}
	
	@Test
	public void testUpdate() {
		
		BoardVO board  = new BoardVO(); //빈객체 생성
		
		board.setBno(5L);
		board.setTitle("수정된 제목");
		board.setContent("수정된 내용");
		board.setWriter("kje");
	
		log.info("=====================================");
		log.info("수정된 개수" + mapper.update(board));
		log.info("=====================================");
	}
	
	@Test
	public void testPaging() {
		
		Criteria cri = new Criteria();
		cri.setPageNum(3); //10개씩 1페이지
		cri.setAmount(10);
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		log.info("=====================================");
		list.forEach(board -> log.info(board.getBno()));
		log.info("=====================================");
	}
	
	@Test
	public void testSearch() {
		
		Criteria cri = new Criteria();
		cri.setKeyword("새로");
		cri.setType("TC");
		
		List<BoardVO> list = mapper.getListWithPaging(cri);
		
		list.forEach(board -> log.info(board));
		
	}
	
	
}
