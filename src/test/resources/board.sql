-------------------------------------------------------------게시판용
create sequence seq_board ;--자동 번호 생성

create table tbl_board(

 bno number(10,0),
 title nvarchar2(200) not null,
 content nvarchar2(2000) not null,
 writer nvarchar2(50) not null,
 regidate date default sysdate,
 updatedate date default sysdate
 
); --board 테이블 생성

alter table tbl_board add constraint pk_board primary key(bno);
--tbl_board 테이블에 규약 이름으로 pk_board를 명명하고 bno를 기본키로 설정

insert into tbl_board (bno, title , content , writer) 
	values (seq_board.nextval , '테스트 제목' , '테스트 내용' , 'user00');
	
select /*+ index_desc(tbl_board pk_board)*/ * from tbl_board where bno>0; --실행계획

select * from tbl_board order by bno desc; --bno를 기준으로 내림차순 정렬

select /*+ FULL(tbl_board) */ rownum rn, bno, title from tbl_board where bno > 0 order by bno;

 	select bno ,title content, writer, regidate, updatedate
 	
 	from(
 	
 	select /*+ INDEX_DESC(tbl_board pk_board) */ rownum rn , bno, title, content , writer,
 				 regidate, updatedate from tbl_board 
 				 					  where rownum <=20 
 	) where rn > 10;
 	
  	
insert into TBL_BOARD(bno,title,content,writer) values(60,'댓글용제목' , '댓글용내용' , 'kje');


 ---------------------------------------------------------
 ------------------------------------------------------------댓글용
 --board객체의 (bno 60~70 사용)
 
select * from tbl_reply order by rno desc;

create table tbl_reply(

	rno number(10,0),
	bno number(10,0) not null,
	reply varchar2(1000) not null, 
	replyer varchar2(50) not null,
	replyDate date default sysdate,
	updateDate date default sysdate
	
	);

 	create sequence seq_reply; 
 	
 	alter table tbl_reply add constraint pk_reply primary key(rno);
 	alter table tbl_reply add constraint fk_reply_board foreign key (bno) references tbl_board(bno) on delete cascade;
 	
 	alter table tbl_reply drop constraint fk_reply_board;
 	
 	select * from TBL_REPLY;
 	
 	
 	
----인덱스 생성

 create index idx_reply on tbl_reply(bno desc, rno asc);
 	
 
 ---댓글과 댓글수에 대한 처리
 
 alter table tbl_board add (replycnt number default 0);
 update tbl_board set replycnt = (select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno);
 
----첨부파일을 위한 준비

 create table tbl_attach(
 
 	uuid varchar2(100) not null,
 	uploadPath varchar2(200) not null,
 	fileName varchar2(100) not null,
 	filetype char(1) default 'I',
 	bno number(10,0)
 	
 );
 
 alter table tbl_attach add constraint pk_attach primary key(uuid);
 
 alter table tbl_attach add constraint fk_attach foreign key(bno) references tbl_board(bno);
 
 select * from tbl_attach;
 
 
 
 --스프링 시큐리티 설정 (기본틀 구조)
 
 create table users(
 
 	username varchar2(50) not null primary key,
 	password varchar2(50) not null,
 	enabled char(1) default '1' );

 create table authorities(
 
 	username varchar2(50) not null,
 	authority varchar2(50) not null,
 	constraint fk_authorities_users foreign key(username) references users(username)
 
 
 );
 
 create unique index ix_auth_username on authorities (username , authority);
 
 insert into users(username,password) values ('user00' ,'pw00');
 insert into users(username,password) values ('member00' ,'pw00');
 insert into users(username,password) values ('admin00' ,'pw00');
 
 insert into AUTHORITIES (username,authority) values ('user00','ROLE_USER');
 insert into AUTHORITIES (username,authority) values ('member00','ROLE_MANAGER');
 insert into AUTHORITIES (username,authority) values ('admin00','ROLE_MANAGER');
 insert into AUTHORITIES (username,authority) values ('admin00','ROLE_ADMIN');
 
 select * from AUTHORITIES;
 
 ----------------
 --스프링 시큐리티 테이블설정 2 (일반적으로 사용하는 테이블)
 
 create table tbl_member(
 
 	userid varchar2(50) not null primary key,
 	userpw varchar2(100) not null,
 	username varchar2(100) not null,
 	regdate date default sysdate,
 	updatedate date default sysdate,
 	enabled char(1) default '1');
 	

 create table tbl_member_auth(
 
 	userid varchar2(50) not null,
 	auth varchar2(50) not null,
 	constraint kf_member_auth foreign key(userid) references tbl_member(userid)
 );
 
 select * from tbl_member_auth;
 select * from tbl_member;
 
 
 
