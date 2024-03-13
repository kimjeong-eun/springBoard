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
	//User 클래스는 UserDetails 인터페이스를 구현한 구현체이기 때문에 해당 클래스 상속받음
	//부모 클래스인 User의 생성자를 호출해야함
	//그 과정에서 AuthVO인스턴스는 GrandAuthority객체로 변환해줘야 함 (stream과 map 사용)
	//User 클래스 상속받았기 때문에 해당 클래스 메서드 사용ㅇ가능
		
	private static final long serialVersionUID = 1L;

	private MemberVO member; //jsp에서 사용하기 위함
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


