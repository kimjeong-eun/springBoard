package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
//페이징 처리에 필요한 검색 처리 조건용 코드
	
	private int pageNum; // 페이지 번호
	private int amount; // 목록 개수
	
	private String type;
	private String keyword;
	
	public Criteria() {
		
		this(1,10);	//기본 페이지 번호는  1 , 기본 목록 개수는 10
	}
	
	public Criteria(int pageNum , int amount) {
		
		this.pageNum = pageNum;
		this.amount =amount;	
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}

	//여러개의 파라미터들을 연결해서 url 형태로 만들어주는 기능
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		
				return builder.toUriString();
	}
		
}
