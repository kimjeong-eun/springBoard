/**
 * 
 */
 
 console.log("Reply Module");
 
 var replyService= (function(){ //즉시 실행함수 (익명함수)
	
  function add(reply , callback){ //자바스크립트 객체와 콜백 함수를 넘김
	
	console.log("reply.....add 함수 실행")
	
	$.ajax({
		
		type : 'post', //post방식으로 
		url	 : '/replies/new', // 컨트롤러로 보냄
		data : JSON.stringify(reply), //JSON.stringify( )는 자바스크립트의 값을 JSON 문자열로 변환한다.
		contentType :"application/json; charset=utf-8",
		success : function(result,status,xhr){
			
					if(callback){ //콜백함수가 있다면 result 삽입
						
						callback(result); //result는 ajax의 결과 
					}
			
				},
		error : function(xhr,status,er){
					if(error){
						error(er);
					}
				}
			
		})	
	}
	
	//	댓글 가져오기 메서드
	
	function getList(param , callback , error){
		
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/"+bno+"/"+page+".json",  //해당 페이지에서 json가져옴
			function(data){				//가져온 후 json을 data변수에 할당 ,
				if(callback){	//넘어온 콜백 함수가 있다면 json 할당
					//callback(data);
					callback(data.replyCnt, data.list);
				}
			}).fail(function(xhr,status,err){
				if(error){
					error();
				}
				
			});
	}
	
	
	//삭제 메서드
	
	function remove(rno , callback , error){
		
		$.ajax({
			type: 'delete',
			url:'/replies/'+rno,
			success: function(deleteResult,status,xhr){
				
				if(callback){
					callback(deleteResult);
				}
				
			} ,
		
			error: function(xhr,status,er){
				if(error){
					error(er);
				}
			}		
		});	
	}
	
	//댓글 수정 메서드
	function update(reply,callback,error){
		
		console.log("RNO :" + reply.rno);
		
		$.ajax({  //비동기 요청
			
			type:'put',
			url:'/replies/'+reply.rno,
			data:JSON.stringify(reply),
			contentType:"application/json; charset=utf-8",
			success: function(result,status,xhr){
				if(callback){
					callback(result);
				}
			},
			error:function(xhr,status,er){
				if(error){
					error(er);
				}
			}			
		});		
	}
	
	//특정 댓글 조회 메서드
	
	function get(rno,callback,error){
		//http get요청
		$.get("/replies/"+rno+".json",function(result){ //해당 url로 get요청을 보내고 성공 시 함수 실행
			
			if(callback){
				callback(result);
			}
			
		}).fail(function(xhr,status,err){
			if(error){ //에러처리 함수가 있다면
				error();
			}
		});	
	}
	
	//시간처리
	function displayTime(timeValue){
		//댓글 등록일 가져옴
		
		var today = new Date(); //오늘날짜
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap<(1000 * 60 * 60 * 24)){
			
			
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();

			return [ (hh > 9 ? '' : '0') + hh, ':',(mi > 9 ? '' : '0')+mi , ':' , (ss > 9 ? '' : '0')+ss ].join('');
		
		}else{
			
			var yy= dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1; 	
			var dd = dateObj.getDate();
			
			
			return [ yy , '/' , (mm > 9 ? '': '0')+mm , '/' , (dd > 9 ? '' : '0')+dd].join('');
			
		}	
	}
	
	return { add:add,getList:getList,remove:remove,update:update,get:get , displayTime:displayTime};
})();