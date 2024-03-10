package org.zerock.domain;

import lombok.Data;

@Data
public class BoardAttachVO {

	private String uuid; //랜덤생성번호
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private Long bno;
	
	
}
