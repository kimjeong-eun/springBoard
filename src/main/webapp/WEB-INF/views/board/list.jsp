<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %> <!-- 외부파일 삽입용 -->
    
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">게시판 페이지 테스트</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board List Page
                            <button id="regBtn" type="button" class="btn btn-xs pull-right">등록</button>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" ><!-- id="dataTables-example"  페이징처리됨-->
                                <thead>
                                    <tr>
                                        <th>#번호</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                <!--  model.addAttribute("list", service.getList());    -->
                                
                                <c:forEach items="${list }" var="board">
                                
                                	<tr><!--가로줄 -->
                                		<td><c:out value="${board.bno}"/></td>
                                		
										<td> <a class="move" href="<c:out value='${board.bno}'/>"><c:out value="${board.title }"></c:out></a></td>	
                                		<td><c:out value="${board.writer}"/></td>
                                		
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regidate }"/></td>        
                                		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updatedate }"/></td>                             	
                                	</tr>
                                </c:forEach>
  								
                                </table>
                                
                               <!-- 검색 조건 처리  --> 
				   			  <div class='row'>
									<div class="col-lg-12">
				
										<form id='searchForm' action="/board/list" method='get'>
											<select name='type'>
												<option value=""
													<c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
												<option value="T"
													<c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
												<option value="C"
													<c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
												<option value="W"
													<c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
												<option value="TC"
													<c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목
													or 내용</option>
												<option value="TW"
													<c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목
													or 작성자</option>
												<option value="TWC"
													<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>>제목
													or 내용 or 작성자</option>
											</select> 
											<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' />
											<input type='hidden' name='pageNum' 	value='<c:out value="${pageMaker.cri.pageNum}"/>' />
											<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
											<button class='btn btn-default'>Search</button>
										</form>
									</div>
								</div>
                                <!-- 페이징 처리 코드 추가 -->
	     						<div class='pull-right'>
									<ul class="pagination">
				
										<c:if test="${pageMaker.prev}">
											<li class="paginate_button previous"><a href="${pageMaker.startPage-1}">Previous</a>
											</li>
										</c:if>
				
										<c:forEach var="num" begin="${pageMaker.startPage}"	end="${pageMaker.endPage}">
											<li class="paginate_button"><a href="${ num }">${num}</a></li>
										</c:forEach>
				
										<c:if test="${pageMaker.next}">
											<li class="paginate_button next"><a href="${pageMaker.endPage+1 }">Next</a></li>
										</c:if>
									</ul>
								</div>
								
								<!--  end Pagination -->
								
								<form  id ="actionForm" action="/board/list" method="get">
									<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"/>
									<input type="hidden" name="amount" value="${pageMaker.cri.amount }"/>								
									<input type="hidden" name="type" value="${pageMaker.cri.type}"/>								
									<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}"/>								
								</form>	<!--페이징 처리에 필요한 값을 가져와 감춤 -->


                                 <!-- Modal 창 추가-->
	                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	                                <div class="modal-dialog">
	                                    <div class="modal-content">
	                                        <div class="modal-header">
	                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                                            <h4 class="modal-title" id="myModalLabel">BoardListModal</h4>
	                                        </div>
	                                        <div class="modal-body">
	                                          처리가 완료되었습니다. 
	                                         </div>
	                                        <div class="modal-footer">
	                                            <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	                                            <button type="button" class="btn btn-primary">저장</button>
	                                        </div>
	                                    </div>
	                                    <!-- /.modal-content -->
	                                </div>
	                                <!-- /.modal-dialog -->
	                            </div>
	                            <!-- /.modal -->
	                            
                            
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
       
	<script type="text/javascript"> /* 1회용을 전달 받은 값일 모달로 출력 */
	
	
	
		$(document).ready(function(){
			var result = '<c:out value="${ result }"/>';	
			/* rttr.addFlashAttribute("result", board.getBno()) ; */	
			
			checkModal(result);
			
			history.replaceState({} , null , null); /* 뒤로가기 문제 해결용 */
			
			function checkModal(result) {
				
				if (result === '' || history.state) {
					/* result 값이 없을 때 */
					return;
				}
				
				if (parseInt(result)> 0) {
					/* 0보다 초과값이 들어 왔을 때 */
					$(".modal-body").html("게시글" + parseInt(result)+ "번이 등록되었습니다.");
				}
				
				$("#myModal").modal("show"); // 모달창 보이기
			}
			
			$("#regBtn").on("click" , function() {
				
				self.location = "/board/register";
				/* 19행에 있는 #regBtn이 클릭되면 동작하는 스크립트 */
				
			});
			
			//페이징 처리용 링크 추가
			
		 	var actionForm = $("#actionForm");
			
			$(".paginate_button a").on("click",function(e){
				e.preventDefault(); // 기본 이벤트 동작 사용 안함
				console.log('click');
				actionForm.find("input[name='pageNum']").val($(this).attr("href")); //클릭된 a 태그의 href속성을 부여 
				actionForm.submit();
			});		
			
			//게시물 제목을 클릭했을 때 이벤트 처리
			
			$(".move").on("click",function(e){
				e.preventDefault();
				actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
				actionForm.attr("action","/board/get");
				actionForm.submit();
				
			});
			
			//검색 버튼의 이벤트 처리
			
			var searchForm = $("#searchForm");
			
			$("#searchForm button").on("click" , function(e){
				
				if(!searchForm.find("option:selected").val()){
					
					alert("검색 종류를 선택하세요");
					return false;
				}
				if(!searchForm.find("input[name='keyword']").val()){
					
					alert("키워드를 입력하세요");
					return false;
				}
				
				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();
				
				searchForm.submit();
				
			});
	
		});
	</script>
 

 <%@ include file="../includes/footer.jsp" %> <!-- 외부파일 연결 -->       

        
        