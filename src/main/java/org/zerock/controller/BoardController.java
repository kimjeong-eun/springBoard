package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.imageio.stream.FileCacheImageInputStream;
import javax.print.attribute.standard.MediaTray;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller //spring이 관여
@Log4j2
@RequestMapping("/board/*") //http://localhost:80/board/????
@AllArgsConstructor // 스프링이 알아서 생성자 필요시 만들어준다.
public class BoardController {

	
	private BoardService service; //boardcontroller가 동작하면 자동으로 서비스도 만들어짐
	
	@GetMapping("/list") //http://localhost/board/list
	public void list( Criteria cri, Model model){
		             //@ModelAttribute 생략가능
		
		log.info("=======================");
		log.info("list컨트롤러 메서드 실행 중");
		log.info("=======================");
		
		model.addAttribute("list", service.getList(cri));
		//model.addAttribute("pageMaker" , new PageDTO(cri, 101));
		//모델 영역에 list라는 이름으로 결과를 저장한다. (select * from 테이블 bno>0)		
		
		int total = service.getTotal(cri);
		log.info("total ="+total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		
	} //리턴타입이 void이면 매핑명으로 된 jsp파일을 찾는다. (/WEB-INF/views/board/list.jsp
	
	@PostMapping("/register") //http://localhost/board/register
	@PreAuthorize("isAuthenticated()")
	public String register(@ModelAttribute BoardVO board , RedirectAttributes rttr) {
		// RedirectAttributes rttr 1회용으로 값 저장용
		// BoardVO board : form에서 넘어온 객체
		log.info("-------------------");
		log.info("register 컨트롤러 메서드 실행..." + board);
		
		
		if(board.getAttachList()!= null) {
			board.getAttachList().forEach( attach -> log.info(attach));
		}
		
		log.info("-------------------");
		service.register(board); // 서비스 계층을 통해서 매퍼로 값이 전달
		
		rttr.addFlashAttribute("result", board.getBno()); //1회용 값으로 jsp에게 전달
								//key   ,   value
		return "redirect:/board/list"; // 메서드 실행후 경로를 지정한다.	
	}

	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()") 
	public void register() {
		// http://localhost/board/register로 요청 시 register.jsp에게 보냄

	}
	
	@GetMapping({"/get","/modify"}) //http://localhost/board/get?bno=1 or http://localhost/board/modify?bno=1
	public void get(@RequestParam("bno") Long bno, Model model , @ModelAttribute("cri") Criteria cri) {
		//@RequestParam("bno") Long bno -> url로 넘어온 bno를 롱타입이 bno변수에 넣음
		//Model model -> Spring이 관리하는 메모리 영역에 값을 가져옴

		log.info("/get 컨트롤러 메서드 실행 .... bno : " + bno);
		model.addAttribute("board",service.get(bno));
		//스프링이 관리하는 모델 영역에 board라는 이름으로 값(BoardVO)을 추가한다.
	}
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify") //http://localhost/board/modify
	public String modify(BoardVO board , RedirectAttributes rttr , @ModelAttribute("cri") Criteria cri) {
						//@modelAttribute 가 알아서 setter로 매칭
		log.info("modify 컨트롤러 메서드 실행중 ....... " + board);
		if(service.modify(board)) { //true일 때
			rttr.addFlashAttribute("result","success");
		}
		
		/*
		 * rttr.addAttribute("pageNum",cri.getPageNum());
		 * rttr.addAttribute("amount",cri.getAmount());
		 * rttr.addAttribute("type",cri.getType());
		 * rttr.addAttribute("keyword",cri.getKeyword());
		 */
		
		
		return "redirect:/board/list" + cri.getListLink(); //처리 후 돌아갈 페이지
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove") // http://localhost/board/remove? bno = 2
	public String remove(@RequestParam("bno") Long bno , RedirectAttributes rttr , @ModelAttribute("cri") Criteria cri ,String writer) {
		
		log.info("remove 컨트롤러 메서드 실행 중......... 받은 번호는 ? : " + bno);
		
		 List<BoardAttachVO> attachList = service.getAttachList(bno);
		 
		if(service.remove(bno)) { //삭제가 성공시 true가 넘어옴
			
			//첨부 파일 삭제
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result","success"); // 1회용 값으로 전달됨
		}
		/*
		 * rttr.addAttribute("pageNum",cri.getPageNum());
		 * rttr.addAttribute("amount",cri.getAmount());
		 * rttr.addAttribute("type",cri.getType());
		 * rttr.addAttribute("keyword",cri.getKeyword());
		 */
		
		return "redirect:/board/list" +cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList" , produces = MediaType.APPLICATION_JSON_VALUE )
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno){
	
		log.info("getAttachList" + bno);
		
		return new ResponseEntity<List<BoardAttachVO>>(service.getAttachList(bno),HttpStatus.OK);
		
		
	}
	
	//첨부 파일을 삭제하기 위한 메서드
	private void deleteFiles(List<BoardAttachVO> attachList) {
		
		if(attachList == null || attachList.size()==0) {
			return;
		}
		
		attachList.forEach(attach ->{
			
			
			try {
				
				Path file = Paths.get("c:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				
				Files.deleteIfExists(file); //파일이 존재한다면 삭제!
				
				if(Files.probeContentType(file).startsWith("image")) {
					
					Path thumbNail = Paths.get("c:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumbNail);
				}	
			}catch (Exception e) {
				// TODO: handle exception
			}
			
		});
		
	}

}
