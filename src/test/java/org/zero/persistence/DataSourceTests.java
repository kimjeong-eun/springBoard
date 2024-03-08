package org.zero.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class) // junit으로 테스트 코드
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml") //참고할 파일 
@Log4j2 //log4j2를 이용해서 로그 출력(콘솔에 찍히는 로그) //Lombok 라이브러리를 이용해서 로그를 기록하는 변수 생성 > log.info()
public class DataSourceTests {

	@Setter(onMethod_ = @Autowired )
	private DataSource dataSource; //생성자 자동주입 
	
	@Setter(onMethod_ = @Autowired )
	private SqlSessionFactory sqlSessionFactory ;
	
	@Test //junit 테스트
	public void testConnection() {
		
		try(Connection con = dataSource.getConnection()){
			log.info("========================");
			log.info(con);
			log.info("========================");
			
		}catch(Exception e) {
			
			fail(e.getMessage());
		}
	}
	
	@Test
	public void testMyBatis() {
		
		try(SqlSession session = sqlSessionFactory.openSession(); Connection con = session.getConnection();){
			log.info("========================");
			log.info(session);
			log.info(con);
			log.info("========================");
		}catch(Exception e) {
			fail(e.getMessage());
		}
		
	}

}
