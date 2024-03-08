package org.zerock.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@WebAppConfiguration
@Log4j2
public class BoardControllerTests {
//board의 분기를 담당하는 컨트롤러 테스트
//@Test 메서드별로 테스트를 히였지만 프론트가 없는 테스트이기때문에 mocMVC를 활용하겠다.
	
	@Setter(onMethod_ = @Autowired )
	private WebApplicationContext ctx ; //크롬 대체
	
	private MockMvc mockMvc; //스프링 전용 프론트 테스트
	
	@Before // import org.junit.Before
	public void setup() {
		//웹브라우저 처럼 파라미터를 처리하기 위해서 테스트 코드로 사전동작용
		
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	
	}//@Test 동작 전에 무조건 선행 되어야하는 코드
	
	@Test
	public void testList() throws Exception{
		
		log.info( 
		mockMvc.perform(MockMvcRequestBuilders.get("/board/list")
				.param("pageNum", "2").param("amount", "7")
				) //http://localhost/board/list를 get방식으로 요청
		.andReturn().getModelAndView().getModelMap());
		//결과는     //모델에 있는 데이터를 view처리  //결과를 Map처럼 표로 받겠다.
	}	
	
	@Test
	public void testRegister() throws Exception{
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/register")
				.param("title", "컨트롤러 입력 테스트 제목") //title파라미터 전달
				.param("content" ,"컨트롤러 입력 테스트 내용") //content파라미터 전달
				.param("writer","kkw") ).andReturn() .getModelAndView().getViewName(); //writer 파라미터 전달
				log.info("testRegister 컨트롤러 테스트 완료 : " + resultPage);		
	}
	
	@Test
	public void testGet() throws Exception{
		
		log.info(mockMvc.perform(MockMvcRequestBuilders.get("/board/get").param("bno","2"))
				.andReturn().getModelAndView().getModelMap());
	}
	
	@Test
	public void testModify() throws Exception{
		
		String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/modify")
				.param("bno","1").param("title", "컨트롤러로 수정된 제목")
				.param("content","컨트롤러로 수정된 내용")
				.param("writer","kkw")).andReturn().getModelAndView().getViewName();
		log.info(resultPage); //처리 후 결과 페이지 redirect/list	
	}
	
	@Test
	public void testRemove() throws Exception{
		
		String ressultPage = mockMvc.perform(MockMvcRequestBuilders.post("/board/remove").param("bno", "25")).andReturn().getModelAndView().getViewName();
		
		log.info(ressultPage);
		
	}
		
}
