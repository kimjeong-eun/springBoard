package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	//xml과 연동해서 sql처리
	
	public int insert(ReplyVO vo); //vo객체를 받아 insert처리용 return은 1개의 처리 완료
	
	public ReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri, @Param("bno") Long bno);
	// myBatis에서 2개 이상의 데이터를 전달할 때 @Param 사용 #{}으로 사용가능
	
	public int getCountByBno(Long bno); //댓글 개수를 가져옴

	
	
}


