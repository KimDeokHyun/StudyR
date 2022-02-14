#[미션 1-1] 데이터 읽기전 메모리 모두 제거
rm(list=ls())
ls()

dir()
setwd("C:/Sources/StudyR/1월28일/data_r") 
file="cust_order_data.csv"
df=read.csv(file,sep='\t',encoding='ANSI')
head(df)


#[미션. 1-2] 총데이터의 갯수와 변수 성격 확인

## --- [코드작성] 총데이터의 갯수 (행과 열의 갯수 확인)
str(df)
###데이터:510470개, 변수:16

## --- [코드작성] 각 변수의 성격확인


 $ SEX           : chr  
 $ AGE           : chr
 $ REG_DATE      : chr  
 $ ORDER_DATE    : chr  
 $ ORDER_HOUR    : chr  
 $ ORDER_WEEKDAY : chr  
 $ IS_WEEKEND    : logi  
 $ GOODS_CODE    : int 
 $ LGROUP        : int
 $ MGROUP        : int  
 $ SGROUP        : int  
 $ DGROUP        : int  
 $ GOODS_NAME    : chr
 $ PRICE         : int  
 $ QTY           : int  

##위로 3개의 자료만 읽기
df[c(1:5),]

## --- [코드작성] 변수명(필드명)만 출력
names(df)


#[미션. 1-3] 아래의 2개 변수(필드)외에 나머지 변수에 대하여 해석

 $ AGE           : "10"단위로 구분된 나이
 $ REG_DATE      : 구매일자  
 $ ORDER_DATE    : 생산일자  
 $ ORDER_HOUR    : 주문시간  
 $ ORDER_WEEKDAY : 주문요일  
 $ IS_WEEKEND    : 주말or평일의 TF값 
 $ GOODS_CODE    : 상품코드 
 $ LGROUP        : int
 $ MGROUP        : int  
 $ SGROUP        : int  
 $ DGROUP        : int  
 $ GOODS_NAME    : 상품이름
 $ PRICE         : 가격  
 $ QTY           : int  

str(df)

#[미션. 2-1] 결측치 확인 (참고R교재 33p-34p)
is.na(df)

##---[코드작성] df의 전체 결측치 갯수 확인
sum(is.na(df)) 0

#---[코드작성] 각 변수별 결측치 갯수 확인
colsums(is.na(df))