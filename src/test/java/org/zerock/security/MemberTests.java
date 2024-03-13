package org.zerock.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
  "file:src/main/webapp/WEB-INF/spring/root-context.xml",
  "file:src/main/webapp/WEB-INF/spring/security-context.xml"
  })
@Log4j2
public class MemberTests {

  @Setter(onMethod_ = @Autowired)
  private PasswordEncoder pwencoder; //패스워드 인코더 (security-context.xml에 bean으로 등록되어있슴
  
  @Setter(onMethod_ = @Autowired)
  private DataSource ds;  //root-context.xml에 있는dataSource 매핑
  
  @Test
  public void testInsertMember() {

    String sql = "insert into tbl_member(userid, userpw, username) values (?,?,?)";
    
    for(int i = 0; i < 100; i++) {
      
      Connection con = null;
      PreparedStatement pstmt = null;
      
      try {
        con = ds.getConnection(); // 커넥션 객체 참조변수에 데이터소스 객체가 커넥션 줌
        pstmt = con.prepareStatement(sql); 
        
        pstmt.setString(2, pwencoder.encode("pw" + i)); //패스워드를 인코딩해서 넣음
        
        if(i <80) {
          
          pstmt.setString(1, "user"+i);
          pstmt.setString(3,"일반사용자"+i);
          
        }else if (i <90) {
          
          pstmt.setString(1, "manager"+i);
          pstmt.setString(3,"운영자"+i);
          
        }else {
          
          pstmt.setString(1, "admin"+i);
          pstmt.setString(3,"관리자"+i);
          
        }
        
        pstmt.executeUpdate();  //실행
        
      }catch(Exception e) {
        e.printStackTrace();
      }finally {
        if(pstmt != null) { try { pstmt.close();  } catch(Exception e) {} }
        if(con != null) { try { con.close();  } catch(Exception e) {} }
        
      }
    }//end for
  }
  
  @Test
  public void testInsertAuth() {
    
    
    String sql = "insert into tbl_member_auth (userid, auth) values (?,?)";
    
    for(int i = 0; i < 100; i++) {
      
      Connection con = null;
      PreparedStatement pstmt = null;
      
      try {
        con = ds.getConnection();
        pstmt = con.prepareStatement(sql);
      
        
        if(i <80) {
          
          pstmt.setString(1, "user"+i);
          pstmt.setString(2,"ROLE_USER");  //권한 표현식 
          
        }else if (i <90) {
          
          pstmt.setString(1, "manager"+i);
          pstmt.setString(2,"ROLE_MEMBER"); //멤버
          
        }else {
          
          pstmt.setString(1, "admin"+i);
          pstmt.setString(2,"ROLE_ADMIN"); //어드민
          
        }
        
        pstmt.executeUpdate();
        
      }catch(Exception e) {
        e.printStackTrace();
      }finally {
        if(pstmt != null) { try { pstmt.close();  } catch(Exception e) {} }
        if(con != null) { try { con.close();  } catch(Exception e) {} }
        
      }
    }//end for
  }
}