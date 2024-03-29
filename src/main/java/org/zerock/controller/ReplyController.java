package org.zerock.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyPageDTO;
import org.zerock.domain.ReplyVO;
import org.zerock.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;


@RestController //rest컨트롤러 
@RequestMapping("/replies/*")
@Log4j2
@AllArgsConstructor
public class ReplyController {

	private ReplyService service; //해당 인터페이스의 구현객체를 알아서 불러옴 
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value = "/new",
			consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE} )
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		
		log.info("ReplyVO:" + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply Insert Count :" + insertCount);
	
		return insertCount == 1
				? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		//삼항연산자로 처리
	}
	
	@GetMapping(value = "/pages/{bno}/{page}", //http://localhost/replies/pages/60/1 -> 60번 글에 쓰여진 댓글 목록 1페이지를 보여달라
			produces = {MediaType.APPLICATION_XML_VALUE ,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page ,@PathVariable("bno") Long bno){
		
		
		log.info("getList.....................");
		Criteria cri = new Criteria(page,10);
		log.info(cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno),HttpStatus.OK);
	}
	
	@GetMapping(value = "/{rno}",
			produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno){
		
		log.info("get:"+rno);
		
		return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
	}
	
	//댓글 삭제
	@PreAuthorize("principal.username==#vo.replyer")
	@DeleteMapping(value = "/{rno}")
	public ResponseEntity<String> remove(@RequestBody ReplyVO vo ,@PathVariable("rno") Long rno){
		
		log.info("remove:" + rno);
		return service.remove(rno)==1
				? new ResponseEntity<>("success",HttpStatus.OK) //body에 success담음 
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//댓글 수정
	@PreAuthorize("principal.username == #vo.replyer")
	@RequestMapping(method = {RequestMethod.PUT , RequestMethod.PATCH},
					value="/{rno}", consumes = "application/json")
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") Long rno){
		
		vo.setRno(rno);
		
		log.info("modify: "+vo);
		
		return service.modify(vo)==1
				? new ResponseEntity<>("success",HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}

}
