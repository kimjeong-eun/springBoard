package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardMapperTests;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class) // junit으로 테스트 코드
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") //참고할 파일 
@Log4j2 
public class BoardServiceTests {

	@Setter(onMethod_ = @Autowired )
	private BoardService service ; //인터페이스를 필드로 연동 (구현 객체까지 활성화)
	
	@Test
	public void testExist(){
		log.info("=====================================");
		log.info(service); //콘솔에 service필드에 대한 출력
		log.info("=====================================");
		assertNotNull(service); //null에대한 처리를 진행 

	}
	
	@Test
	public void testRegister() {
		
		BoardVO board = new BoardVO(); //빈 객체 생성
		board.setTitle("서비스로 만든 글");
		board.setContent("서비스로 만들 내용");
		board.setWriter("kje"); //프론트에서 폼데이터를 받아야 함.
		
		service.register(board); // 서비스 인터페이스에 있는 추상 메서드 실행 
		
		log.info("생성된 게시물의 번호는 ????? " + board.getBno());
	}
	
	@Test
	public void testGetList() {
		
		service.getList(new Criteria(2,5)).forEach(board -> log.info(board));
		//서비스 계층에 있는 getList메서드를 실행하면 매퍼에 있는 getList가 실행되며 sql문이 동작한다.
		//리턴은 list안에 BoardVO객체를 가지고 돌아온다.
	}
	
	@Test
	public void testGet() {
		
		log.info(service.get(1L));
		
	}
	
	@Test
	public void testDelete() {
		
		log.info("삭제 결과 출력 : " + service.remove(2L)); //2번이 있는지 확인하고 실행

	}
	
	@Test
	public void testUpdate() { //게시물을 먼저 찾아서 객체로 등록 후 수정 작업을 진행
		
		
		BoardVO board = service.get(1L); //게시물을 먼저 찾아와 변수에 넣음
		
		if(board == null) {
			return ; //가져온 게시물이 없으면 돌아감.
		}else {
			
			board.setTitle("제목 수정됨");
			log.info("수정된 결과: "+ service.modify(board)); //boolean으로 결과 나옴.
		}
		
		
		
		
	}
	
	
}
