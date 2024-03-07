package org.zerock.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO { //db에있는 자료를 객체화 시키는 용도

	private Long rno; //댓글번호
	private Long bno; //게시글번호
	private String reply; //댓글
	private String replyer; //댓글작성자
	private Date replyDate; //댓글작성일
	private Date updateDate; //댓글수정일
	
}
