package org.zerock.mapper;

import java.util.List;
import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zero.persistence.DataSourceTests;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class) // junit으로 테스트 코드
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") //참고할 파일 
@Log4j2 
public class ReplyMapperTests {
//인터페이스로 만든 매퍼 테스트용
	
	@Setter(onMethod_ = @Autowired ) //세터와 생성자 자동주입
	private ReplyMapper mapper; 
	
	@Test
	public void testMapper() {
		
		log.info("======================");
		log.info(mapper);
		log.info("======================");
	}
	
	private Long[] bnoArr = {60L,61L,62L,63L,64L}; //부모객체 bno값 확인
	@Test
	public void testCreate() { //bno가 있는 값을 확인하여 반복 더미데이터를 삽입
		
		IntStream.rangeClosed(1, 10).forEach(i->{
			
			ReplyVO vo = new ReplyVO();
			
			//게시물의 번호
			vo.setBno(bnoArr[i%5]); //위에 만든 배열을 5로나눈 나머지
			vo.setReply("댓글테스트"+i);
			vo.setReplyer("replyer"+i); //더미 객체를 생성
			
			mapper.insert(vo); //더미 객체를 매퍼에서 insert작업을 한다.
		});
	
	}
	
	@Test
	public void testRead() {
		
		Long targetRno = 5L;
		
		ReplyVO vo = mapper.read(targetRno);
		
		log.info("============================");
		log.info(vo);
		log.info("============================");
		
	}
	
	@Test
	public void testDelete() {
		
		Long targetRno = 1L;
		mapper.delete(targetRno);
		
	}
	
	@Test
	public void testUpdate() {
		
		Long targeRno = 10L;
		
		ReplyVO vo = mapper.read(targeRno);
		
		vo.setReply("update Reply");
		int count = mapper.update(vo);
		log.info("============================");
		log.info("Update count " + count);
		log.info("============================");
		
		
	}
	
	@Test
	public void testList() {
		
		Criteria cri = new Criteria();
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(reply -> log.info(reply));
		
	}
	
	@Test
	public void testList2() {
		
		Criteria cri = new Criteria();
		
		List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
		replies.forEach(reply -> log.info(reply));
		
	}
	
}
