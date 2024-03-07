package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

	private int startPage; 		//시작페이지 번호
	private int endPage; 		//마지막 페이지 번호
	private boolean prev, next; //앞 뒤 유무
	private int total; 			//게시물 총 개수
	private Criteria cri ;		//블럭과 행수(현재 페이지)
	
	public PageDTO(Criteria cri , int total) { // cri (pageNum : 1 , amount : 10 total(101)
		
		
		this.cri = cri;
		this.total = total;
	
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) *10;
		
        this.startPage =this.endPage-9;
                         
		int realEnd = (int)(Math.ceil((total* 1.0)/cri.getAmount()));
		
		if(realEnd < this.endPage) {
			
			this.endPage = realEnd;	
		}
		this.prev = this.startPage > 1;
		this.next = this.endPage<realEnd;

	}
	
}
