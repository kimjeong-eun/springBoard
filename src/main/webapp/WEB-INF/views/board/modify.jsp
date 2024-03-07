<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %> <!-- 외부파일 삽입용 -->
    
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">게시판 게시글 수정</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Modify Page
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                           <form role="form" action="/board/modify" method="post">
                            <div class="form-group">
                           		<label >Bno</label><input class="form-control" name="bno" value='<c:out value = "${board.bno }"/>' readonly="readonly"/>       
                           	</div>

                           	<div class="form-group">
                           		<label >Title</label><input class="form-control" name="title"  value='<c:out value = "${board.title }"/>' />
                           	</div>
                           	<div class="form-group">
                           		<label >Text Area</label><textarea class="form-control" rows="3" name="content"><c:out value = "${board.content }"/></textarea>
                           	</div>
                           	 <div class="form-group">
                           		<label >Writer</label><input class="form-control" name="writer" value="${board.writer }" readonly="readonly"/>
                           	</div>
                         	<div class="form-group">
                           		<label >RegiDate</label><input class="form-control" name="regidate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regidate }"/>' readonly="readonly"/>
                           	</div>
  					
        					<div class="form-group">
                           		<label >UpdateDate</label><input class="form-control" name="updatedate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updatedate }"/>' readonly="readonly"/>
                           	</div>	
                           	
                           	<button  type="submit" data-oper='modify' class="btn btn-default" >수정</button>
                            <button  type="button" data-oper='remove' class="btn btn-danger" >삭제</button>
                           	<button type="button"  data-oper='list' class="btn btn-info" >글목록</button>
                        
                        	<input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>"/>
                        	<input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>"/>
                        	<input type="hidden" name="type" value="<c:out value='${cri.type}'/>"/>
                        	<input type="hidden" name="keyword" value="<c:out value='${cri.keyword}'/>"/>
                       
                        </form>
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
<script>

	$(document).ready(function () {
		
		var formObj = $("form");
		
		$("button").on("click", function(e) {
			
			e.preventDefault();  //기본 이벤트 막음
			
			//data-OO 으로 지정해서 가져올 수 있음
			var operation = $(this).data("oper"); //button 태그의 data-oper값을 가져옴
			
			console.log(operation);
			
			if(operation === "remove"){
				formObj.attr("action","/board/remove"); //form의 속성을 바꿈
			}else if(operation === "list"){
				
				formObj.attr("action","/board/list").attr("method","get");
				var pageNumTag = $("input[name='pageNum']").clone(); //해당 태그 복사
				var amountTag = $("input[name='amount']").clone(); //해당 태그 복사
				var keywordTag = $("input[name='keyword']").clone(); //해당 태그 복사
				var typeTag = $("input[name='type']").clone(); //해당 태그 복사
				
				
				formObj.empty(); //list로 돌아갈 때 폼 안의 데이터를 삭제한 상태로 
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);

			}
			
			formObj.submit(); //스크립트에 적용된 코드를 수행해라
		});
	});

</script>

 <%@ include file="../includes/footer.jsp" %> <!-- 외부파일 연결 -->       
