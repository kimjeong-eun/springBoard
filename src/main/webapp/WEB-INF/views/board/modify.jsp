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
            <!-- 첨부 파일 목록 -->
                      		
                      		<div class='bigPictureWrapper'>
								  <div class='bigPicture'>
								  </div>
								</div>
			
								<style>
								.uploadResult {
								  width:100%;
								  background-color: gray;
								}
								.uploadResult ul{
								  display:flex;
								  flex-flow: row;
								  justify-content: center;
								  align-items: center;
								}
								.uploadResult ul li {
								  list-style: none;
								  padding: 10px;
								  align-content: center;
								  text-align: center;
								}
								.uploadResult ul li img{
								  width: 100px;
								}
								.uploadResult ul li span {
								  color:white;
								}
								.bigPictureWrapper {
								  position: absolute;
								  display: none;
								  justify-content: center;
								  align-items: center;
								  top:0%;
								  width:100%;
								  height:100%;
								  background-color: gray; 
								  z-index: 100;
								  background:rgba(255,255,255,0.5);
								}
								.bigPicture {
								  position: relative;
								  display:flex;
								  justify-content: center;
								  align-items: center;
								}
								
								.bigPicture img {
								  width:600px;
								}
								
								</style>
	                      		
                      		<div class="row">
                      			<div class="col-1g-12">
                      				<div class="panel panel-default">
                      				
                      				<div class="panel-heading">Files</div>
                      				
                      				<div class="panel-body">
                      				
                      					<div class="form-group uploadDiv">
                      					
                      						<input type="file" name="uploadFile" multiple="multiple">
                      				
                      					</div>
                      					<div class="uploadResult">
                      						<ul>
                      						<!-- 여기에 첨부파일 목록 보임  -->
                      						</ul>
	               						</div>
	               					</div>
	               				</div>
	               			</div>
                      		
                      	</div> <!-- 첨부 파일 목록 끝  -->
            
            
            
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
        
  <!--첨부 파일 관련 js  --> 
        <script>
        	
        	$(document).ready(function(){
        		
        		(function(){
        			
        			 var bno = '<c:out value="${board.bno}"/>';
        			    
        			    $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
        			    
        			      console.log(arr);
        			      
        			      var str = "";


        			      $(arr).each(function(i, attach){
        			          
        			          //image type
        			          if(attach.fileType){
        			            var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
        			            
        			            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
        			            str +=" data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
        			            str += "<span> "+ attach.fileName+"</span>";
        			            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' "
        			            str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
        			            str += "<img src='/display?fileName="+fileCallPath+"'>";
        			            str += "</div>";
        			            str +"</li>";
        			          }else{
        			              
        			            str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' "
        			            str += "data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
        			            str += "<span> "+ attach.fileName+"</span><br/>";
        			            str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' "
        			            str += " class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
        			            str += "<img src='/resources/img/attach.png'></a>";
        			            str += "</div>";
        			            str +"</li>";
        			          }
        			       });

        			      
        			      $(".uploadResult ul").html(str);
        				
        			});
        		})();
        		
        		$(".uploadResult").on("click","button",function(e){
        			
        			console.log("delete file");
        			
        			if(confirm("해당 파일을 지우겠습니까?")){
        				
        				var targetLi = $(this).closest("li");
        				targetLi.remove();
        			}
        		});

        		
        		/*  게시글 수정 시 첨부파일 추가 */
        		
        		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        		var maxSize = 5242880 //5mb
        		

    			function checkExtension(fileName , fileSize){
    				
    				if(fileSize >= maxSize){
    					alert("파일 사이즈 초과");
    					return false;
    				}
    				
    				if(regex.test(fileName)){
    					alert("해당 종류의 파일은 업로드할 수 없습니다.");
    					return false;
    				}
    				
    				return true;
    				
    			}
    			
    			$("input[type='file']").change(function(e){
    				
    				var formData = new FormData(); //가상의 폼데이타
    				
    				var inputFile = $("input[name='uploadFile']");
    				
    				var files = inputFile[0].files;
    				
    				for(var i = 0; i<files.length ; i++){
    					if(!checkExtension(files[i].name,files[i].size)){
    						
    						return false;
    						
    					}
    					formData.append("uploadFile" , files[i]);
    				}
    				
    				
    				$.ajax({
    					url:'/uploadAjaxAction',
    					processData:false, //쿼리스트링 방지
    					contentType:false, //기본 타입 방지
    					data: formData,
    					type:'POST',
    					dataType:'json',
    					success: function(result){
    						console.log(result);
    						showUploadResult(result);
    					}
    				});
    			});
    			
    			
    			function showUploadResult(uploadResultArr){
    			    
    			    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
    			    
    			    var uploadUL = $(".uploadResult ul");
    			    
    			    var str ="";
    			    
    			    $(uploadResultArr).each(function(i, obj){ //i: 인덱스 obj: fileDTO
    			    
    			        /* //image type
    			        if(obj.image){
    			          var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
    			          str += "<li><div>";
    			          str += "<span> "+ obj.fileName+"</span>";
    			          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
    			          str += "<img src='/display?fileName="+fileCallPath+"'>";
    			          str += "</div>";
    			          str +"</li>";
    			        }else{
    			          var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);            
    			            var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
    			              
    			          str += "<li><div>";
    			          str += "<span> "+ obj.fileName+"</span>";
    			          str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
    			          str += "<img src='/resources/img/attach.png'></a>";
    			          str += "</div>";
    			          str +"</li>";
    			        } */
    					//image type
    					
    					if(obj.image){
    						var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
    						str += "<li data-path='"+obj.uploadPath+"'";
    						str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
    						str +" ><div>";
    						str += "<span> "+ obj.fileName+"</span>";
    						str += "<button type='button' data-file=\'"+fileCallPath+"\' "
    						str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
    						str += "<img src='/display?fileName="+fileCallPath+"'>";
    						str += "</div>";
    						str +"</li>";
    					}else{
    						var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
    					    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
    					      
    						str += "<li "
    						str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"' ><div>";
    						str += "<span> "+ obj.fileName+"</span>";
    						str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' " 
    						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
    						str += "<img src='/resources/img/attach.png'></a>";
    						str += "</div>";
    						str +"</li>";
    					}

    			    });
    			    
    			    uploadUL.append(str);
    			  }
					/* 첨부파일 추가 끝 */
        		
        	});

        </script>    

<script>

	$(document).ready(function () {
		
		var formObj = $("form"); //폼요소 가져옴
		
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

			}else if(operation==="modify"){
				
				  var str = "";
			        
			        $(".uploadResult ul li").each(function(i, obj){
			          
			          var jobj = $(obj);
			          
			          console.dir(jobj);
			          
			          // 컨트롤러로 보내면 @ModelAttribute 가 알아서 setter로 매칭
			          str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			          str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			          str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			          str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
			          
			        });
			        formObj.append(str).submit();
			}
			
			formObj.submit(); //스크립트에 적용된 코드를 수행해라
		});
	});

</script>

 <%@ include file="../includes/footer.jsp" %> <!-- 외부파일 연결 -->       
