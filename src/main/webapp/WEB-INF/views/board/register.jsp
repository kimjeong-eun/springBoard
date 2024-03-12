<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%@ include file="../includes/header.jsp" %> <!-- 외부파일 삽입용 -->
    
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">게시글 등록</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board Register
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                           
                           <!--spring리 관리하는 model영역에 3개의 값이 넘어감  -->
                           <form role="form" action="/board/register" method="post">
                           	<div class="form-group">
                           		<label >Title</label><input class="form-control" name="title" >
                           	</div>
                           	<div class="form-group">
                           		<label >Text Area</label><textarea class="form-control" rows="3" name="content"></textarea>
                           	</div>
                           	 <div class="form-group">
                           		<label >Writer</label><input class="form-control" name="writer"  value="<sec:authentication property='principal.username'/>" readonly="readonly">
                           	</div>
                           	<button type="submit" class="btn btn-default">Submit Button</button>
                           	<button type="reset" class="btn btn-default">Reset</button>
                           	
                           	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"/>
                           	
                           </form>
                         </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->         
                </div>
                <!-- /.col-lg-6 -->
                
               <!-- 파일 첨부 폼  -->
              <div class="row">
              	<div class="col-lg-12">	
              		<div class="panel panel-default">
              			
              			
              			<div class="panel-heading">파일 첨부</div>
              			
              			<div class="panel-body">
              				<div class="form-group uploadDiv">
              					<input type="file" name="uploadFile" multiple>
              				</div>
              				
              				<div class="uploadResult">
              				
              					<ul>
              					
              					</ul>
              				
              				</div>	             			
              			</div><!--end panel body  -->	
              			
              		</div>
              	
              	</div>

              </div>
          		<!-- 파일 첨부 끝 -->
         
            </div>
            <!-- /.row -->
        </div>

	<script type="text/javascript">
		$(document).ready(function(e){
			var formObj = $("form[role='form']");
			
			$("button[type='submit']").on("click",function(e){
				
				e.preventDefault();
				
				console.log("submit clicked");
				
				/* 파일 리스트 처리  */
				
				var str ="";
				
				$(".uploadResult ul li").each(function(i , obj){
					
					var jobj = $(obj);
					
					  console.dir(jobj);
				      console.log("-------------------------");
				      console.log(jobj.data("filename"));
				      
				      
				      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
				      
				});
				 console.log(str);
				    
				formObj.append(str).submit();

				
			});
			
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			
			var maxSize = 5242880 ; //5mb
			
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
			
			/* csrf 토큰 처리  */
			
			var csrfHeaderName = "${_csrf.headerName}";  //"X-CSRF-TOKEN"
			var csrfTokenValue = "${_csrf.token}";		// 
			
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
					beforeSend: function(xhr){   // 헤더에 csrf 값 추가
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
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
			 
			//이벤트 위임
			$(".uploadResult").on("click","button",function(e){
				
				console.log("delete file");
				
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				
				var targetLi = $(this).closest("li"); //선택한 요소를 포함하면서 가장 가까운 상위 요소를 선택합니다.
				
				$.ajax({
					
					url: '/deleteFile',
					data:{fileName:targetFile , type : type},
					beforeSend: function(xhr) {
						
						xhr.setRequestHeader(csrfHeaderName , csrfTokenValue);
					},
					dataType : 'text',
					type:'POST',
					 success: function(result){
						alert(result);
						targetLi.remove();
					 }
					
					
					
				}); //end ajax
			});

		});

		
		
	
	
	
	</script>




 <%@ include file="../includes/footer.jsp" %> <!-- 외부파일 연결 -->       
