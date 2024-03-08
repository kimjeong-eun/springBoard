<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %> <!-- 외부파일 삽입용 -->
    
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">게시판 게시글</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Read Page
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                           
                            <div class="form-group">
                           		<label >Bno</label><input class="form-control" name="bno" value='<c:out value = "${board.bno }"/>' readonly="readonly"/>       
                           	</div>

                           	<div class="form-group">
                           		<label >Title</label><input class="form-control" name="title"  value='<c:out value = "${board.title }"/>' readonly="readonly"/>
                           	</div>
                           	<div class="form-group">
                           		<label >Text Area</label><textarea class="form-control" rows="3" name="content"  readonly="readonly" ><c:out value = "${board.content }"/></textarea>
                           	</div>
                           	 <div class="form-group">
                           		<label >Writer</label><input class="form-control" name="writer" value="${board.writer }" readonly="readonly"/>
                           	</div>
                           	<button data-oper='modify' class="btn btn-default" >수정</button>
                           	<button data-oper='list' class="btn btn-info">글목록</button>
                           	
               <!--댓글 추가  -->                    	                           	
             <div class="row">
                <div class="col-lg-12">
                <!-- /.panel -->
        		<div class="panel panel-default">
        			<div class = "panel-heading">
        				<i class="fa fa-comments fa-fw"></i>Reply
        				<button id="addReplyBtn" class="btn btn-primary btn-xs pull-right">New Reply</button>
        			</div>
      		
        		<!-- /.panel-heading -->
        		<div class="panel-body">
        			<ul class="chat">
        				<li class="left clearfix" data-rno='12'>
        				<div>
        					<div class="header">
        						<strong class="primary-font">user00</strong>
        						<small class="pull-right text-muted">2024-03-07 13:13</small>
        					</div>
        					<p>Good job!</p>
        				</div>
        				</li>
        			</ul>
        		</div>
        	</div>
        </div>
       </div>		
	<!--댓글 끝-->
	<!--.chat-panel추가  -->
	<div class="panel-footer">
		
	
	
	
	
	</div>
	
	
                           	<form id="operForm" action="/board/modify" method="get">
                           		<input type="hidden" id="bno" name="bno" value ='<c:out value="${board.bno }" />' />
                           		<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum }'/>"/>
                           		<input type="hidden" name="amount" value="<c:out value='${cri.amount }'/>"/>
                           		<input type="hidden" name="keyword" value="<c:out value='${cri.keyword }'/>"/>
                           		<input type="hidden" name="type" value="<c:out value='${cri.type }'/>"/>
   		
                           	</form> <!-- 링크를 직접 처리해도되지만 폼을 이용해서 처리하는 방법 (히든용) -->
                           	
                         </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
        </div>
	    
	    <!-- 모달창 -->
        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                        	<label>Reply</label>
                        	<input class="form-control" name="reply" value="New Reply!!!">
                        </div>
                        
                        <div class="form-group">
                        	<label>Replyer</label>
                        	<input class="form-control" name=replyer value="replyer">
                        </div>
                        <div class="form-group">
                        	<label>Reply Date</label>
                        	<input class="form-control" name="replyDate" value="">
                        </div>                       
                    </div>
                    <div class="modal-footer">
                    	<button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
                        <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
                        <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
                        <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						        
                      	
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>	    
          
        <script type="text/javascript" src="/resources/js/reply.js"></script>
        
        <script>
        
        	//console.log("===============");
        	//console.log("JS Test");
        	
        	$(document).ready(function() {
				
        		var bnoValue = '<c:out value="${board.bno}"/>';
        		var replyUL = $(".chat");
        		
        		showList(1);
        		
        		function showList(page) {
        			
        			replyService.getList({bno:bnoValue,page:page||1},function(replyCnt,list){
        			
        				console.log("replyCnt:" + replyCnt);
        				console.log("list:" + list);

        				if(page== -1){
        					pageNum = Math.ceil(replyCnt/10.0);
        					showList(pageNum);
        					return;
        				}	
        				
        				var str = "";
        				
        				if(list==null || list.length==0){
        					//replyUL.html(""); 
        					
        					return;
        				}
        				
        				for(var i=0,len=list.length ||0; i<len;i++){
        					str +="<li class='left clearfix' data-rno='"+list[i].rno+"'>";
        					str+="   <div><div class='header'><strong class='primary-font'>["
        							+list[i].rno+"] " + list[i].replyer+"</strong>";
        				    str+="    <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
        					str+=" 	  <p>"+list[i].reply+"</p></div></li>";
        					
        				}
        				
        				replyUL.html(str); //댓글목록 html에 뿌림
        				showReplyPage(replyCnt);
        				
        			});

				} //end showList
				
				/* 댓글 페이징 처리 */
        	    var pageNum = 1;
        	    var replyPageFooter = $(".panel-footer");
        	    
        	    function showReplyPage(replyCnt){
        	      
        	      var endNum = Math.ceil(pageNum / 10.0) * 10;  
        	      var startNum = endNum - 9; 
        	      
        	      var prev = startNum != 1;
        	      var next = false;
        	      
        	      if(endNum * 10 >= replyCnt){
        	        endNum = Math.ceil(replyCnt/10.0);
        	      }
        	      
        	      if(endNum * 10 < replyCnt){
        	        next = true;
        	      }
        	      
        	      var str = "<ul class='pagination pull-right'>";
        	      
        	      if(prev){
        	        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
        	      }

        	      
        	      for(var i = startNum ; i <= endNum; i++){
        	        
        	        var active = pageNum == i? "active":"";
        	        
        	        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
        	      }
        	      
        	      if(next){
        	        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
        	      }
        	      
        	      str += "</ul></div>";
        	      
        	      console.log(str);
        	      
        	      replyPageFooter.html(str);
        	    }
        	    
        	    
        	    replyPageFooter.on("click","li a",function(e){
        	    	
        	    	
        	    	e.preventDefault();
        	    	console.log("page click");
        	    	
        	    	var targetPageNum = $(this).attr("href");
        	    	console.log("targetPageNum: " + targetPageNum);
        	    	
        	    	pageNum = targetPageNum ; 
        	    	
        	    	showList(pageNum);
        	    });

        	    /* 댓글 페이징 처리 끝 */
				
				var modal = $(".modal");
				var modalInputReply = modal.find("input[name='reply']");
				var modalInputReplyer = modal.find("input[name='replyer']");
				var modalInputReplyDate = modal.find("input[name='replyDate']");
				
				var modalModBtn = $("#modalModBtn");
				var modalRemoveBtn = $("#modalRemoveBtn");
				var modalRegisterBtn = $("#modalRegisterBtn");
				
				$("#addReplyBtn").on("click",function(e){
					
					modal.find("input").val("");
					modalInputReplyDate.closest("div").hide(); 
					// 등록 날짜 안보이게 비활성화 
					
					modal.find("button[id != 'modalCloseBtn']").hide(); //클로즈 버튼 말고 다 비활
	
					modalRegisterBtn.show(); //등록 버튼은 활성화 
	
					$(".modal").modal("show");
				
				});
				
				
				//새로운 댓글 추가 처리
				
				modalRegisterBtn.on("click",function(e){
					
					var reply = {
							
							reply : modalInputReply.val(),
							replyer:modalInputReplyer.val(),
							bno:bnoValue
							
					}; //json객체
					
					replyService.add(reply,function(result){
						
						alert(result); //댓글 등록 성공여부
						modal.find("input").val(""); //input창 지움
						modal.modal("hide"); //모달닫기
						//showList(1);
						showList(-1);
					});

				});
				
				//이벤트위임?
				
				$(".chat").on("click","li",function(e){
					
					var rno = $(this).data("rno"); //li 항목의 data-rno 값
					
					replyService.get(rno,function(replyData){
						
						modalInputReply.val(replyData.reply);
						
						modalInputReplyer.val(replyData.replyer);
						modalInputReplyDate.val(replyService.displayTime(replyData.replyDate))
										.attr("readonly","readonly");
						modal.data("rno",replyData.rno);
						
						modalRegisterBtn.hide();
						modalModBtn.show();
						modalRemoveBtn.show();
						
						$(".modal").modal("show");
						
					});
				});

				
				//댓글 수정 / 삭제 처리
				modalModBtn.on("click",function(e){
					
					var reply = {rno:modal.data("rno"),reply:modalInputReply.val()};
					
					replyService.update(reply,function(result){
						
						alert(result);
						modal.modal("hide");
						showList(pageNum);
						
					});	
					
				});
				
				modalRemoveBtn.on("click",function(e){
					
					var rno = modal.data("rno");
					
					replyService.remove(rno,function(result){
						
						alert(result);
						modal.modal("hide");
						showList(pageNum);

					});
				});

			});

        	//replyService 안에 add함수 실행 (즉시함수 ajax사용)
        	//replyService.add(
        		//{reply:"JS Test" , replyer:"tester", bno:bnoValue}
        		//,
        	//	function(result){
        		//	alert("RESULT :" + result);
        	//	}
        	
        //	); 
        
        	//replyService.getList({bno:bnoValue , page:1} , function(list){ //json객체와 콜백함수 넘김
        		
        		//for(var i=0 , len=list.length||0; i<len; i++){
        			//console.log(list[i]);
        		//}
        		
        //	});
        	
        //23번 댓글 삭제 테스트
       // replyService.remove(23, function(count){
        
        //	console.log(count);
        //	if(count==="success"){
        		//alert("REMOVED");
        	//}
        	
       // }, function(err){
        	//alert('ERROR....');
       // });
 	
        //22번 댓글 업데이트 테스트
        //replyService.update({rno:22,bno:bnoValue,reply:"수정되었어용 rest"},
        					//function(result) {
							//	alert("수정완료~");
						//	});
        
/*         replyService.get(10, function(data) {
			
        	console.log(data); //data에 result가 들어옴
        	
		}); */
        
        </script>
        

        <script type="text/javascript">
        	
        	$(document).ready(function() {
				
        		/* console.log(replyService);  js 테스트용 */ 
        		
        		var operForm = $("#operForm"); //id가 operForm인 요소를 가져옴
        		
        		$("button[data-oper='modify']").on("click" , function(e) {

        			e.preventDefault();  //기본 이벤트 막음
        			operForm.attr("action","/board/modify").submit();
        			/* 수정 버튼을 누르면 bno 값을 hidden태그로 전함 */	
				});
        		
        		$("button[data-oper='list']").on("click" , function(e) {
					
        			e.preventDefault();  //기본 이벤트 막음
        			operForm.find("#bno").remove(); /*히든태그 지움*/
        			operForm.attr("action" , "/board/list");
        			operForm.submit();
        			
				});	
			});
        	
        </script>
        

 <%@ include file="../includes/footer.jsp" %> <!-- 외부파일 연결 -->       
