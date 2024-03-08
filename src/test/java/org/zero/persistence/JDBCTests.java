package org.zero.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;

import lombok.extern.log4j.Log4j2;

@Log4j2 //테스트 로그로 출력
public class JDBCTests {

	static {
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
		} catch (ClassNotFoundException e) {
		
			e.printStackTrace();
		}		
	} //static 종료
	
	@Test //junit 테스트
	public void testConnection() {
		
		try ( Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","book","book")){
				log.info(con);
			
		} catch (SQLException e) {
			fail(e.getMessage());
			e.printStackTrace();
		}

	}	
}
