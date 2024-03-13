package org.zerock.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberMapper;
import org.zerock.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import lombok.extern.log4j.Log4j2;

@Log4j2
public class CustomUserDetailsService implements UserDetailsService {
	//해당 클래스는 security-context.xml에  bean객체로 등록되어있음
	//return 타입이 UserDetails이기때문에 MemberVO객체를 적절히 변환해야함
	//변환을 하기 위해 CustomUser클래스를 생성함
	//CustomUser클래스는 스프링 시큐리티의 User 클래스(UserDetails 인터페이스 구현체)를 상속받아 구현함
	
	  @Setter(onMethod_ = { @Autowired })
	  private MemberMapper memberMapper;
	  
	  @Override public UserDetails loadUserByUsername(String userName) throws
	  UsernameNotFoundException {
	  
	  log.warn("Load User By UserName : " + userName);
	  
	   //userName means userid MemberVO vo = memberMapper.read(userName);
	  
	  //log.warn("queried by member mapper: " + vo);
	  MemberVO vo = memberMapper.read(userName); //userName => userid임
	  
	  return vo == null ? null : new CustomUser(vo);
	  
	  }
	 

}
