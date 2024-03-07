<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
                           		<label >Writer</label><input class="form-control" name="writer" >
                           	</div>
                           	<button type="submit" class="btn btn-default">Submit Button</button>
                           	<button type="reset" class="btn btn-default">Reset</button>
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

 <%@ include file="../includes/footer.jsp" %> <!-- 외부파일 연결 -->       
