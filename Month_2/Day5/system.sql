--기존의 구문 형태를 그대로 사용하고자 한다
--최초에 한번 실행하기
alter session set "_ORACLE_SECRIPT" = TRUE;

--아이디 생성
CREATE USER busan IDENTIFIED BY dbdb;

--사용자 비밀번호 변경
ALTER USER busan IDENtiFIED BY dbdb;

--사용자 삭제하기
Drop User busan;

--생성한 사용자에게 권한 부여하기
--접속권한, 관리자권한 모두 부여
GRANT CONNECT, RESOURCE,DBA TO busan;

--권한 회수하기
REVOKE DBA FROM busan;
