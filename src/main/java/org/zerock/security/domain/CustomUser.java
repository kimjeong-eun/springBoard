package org.zerock.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.zerock.domain.MemberVO;

import lombok.Getter;

@Getter    //security의 user 클래스를 상속받아서 처리함
public class CustomUser extends User {

	private static final long serialVersionUID = 1L;

	private MemberVO member;
														//user클래스의 생성자 따라감
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);         //부모에서 Set<GrantedAuthority> 를 받고 있기때문에
														//collection은 set list 둘다 참조 가능
	}

	public CustomUser(MemberVO vo) {

		super(vo.getUserid(), vo.getUserpw(), vo.getAuthList().stream()  //authVO객체가 list형태로 넘어옴
				.map(auth -> new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
				//새로운 스트림으로 만드는 메서드						//stream변환 후 다시 list로 변환하는 코드	
		this.member = vo;
	}
}
