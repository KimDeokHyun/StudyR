# RJDBC패키지 설치
install.packages("RJDBC")
library(RJDBC)

# 오라클 드라이버 연결 경로 설정
driver = JDBC ("oracle.jdbc.OracleDriver" ,
              classPath = "C:/DEV/Tool/sqldeveloper-21.2.1.204.1703-x64/sqldeveloper/jdbc/lib/ojdbc8.jar")
              
driver             

#오라클 접속하기
conn = dbConnect(driver,
                 "jdbc:oracle:thin:@//localhost:1521/orcl",
                 "busan","dbdb")

conn

#데이터 [입력/수정/삭제]
#dbSendQuery()함수는 동일하게 사용

sql_in <- paste("insert into test",
                "(AA, BB, CC) ",
                " values('a1', 'b1', 'c1')")
sql_in  #확인

in_stat = dbSendQuery(conn, sql_in)
in_stat

dbClearResult(in_stat)

#데이터 조건 [조회]
sql_sel = " Select* From test where AA = 'a1'"
sql_sel #확인

getData = dbGetQuery(conn, sql_sel)
getData

getData$AA

str(getData)

###오라클 접속 해제 (필수)
dbDisconnect(conn)
  
