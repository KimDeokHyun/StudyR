모든행,1~4열 출력
iris[,c(1:4)]
iris[,-5]
iris[,c(1:ncol(iris)-1)]

#---------------------------------------

#설문(일상생활)
1. 빈도수 분석
2. 연관성 분석
 >colsums(), rowsums()등을 통해 비율 분석

#---------------------------------------

#영문텍스트분석(데이터 마이닝)에 특화된 tm패키지등에 매트릭스 적용
 >konlpy패키지

#---------------------------------------

외부 파일 불러오기

setwd("C:/Sources/StudyR/1월26일") #워킹디렉토리 설정
dir() #디렉토리 내 파일 확인
fileName="전국무인교통단속카메라표준데이터.csv"
df=read.csv(fileName)
head(df)
str(df)

barplot(table(df$시도명))   # plot 내 01, 10은 무엇?

#01, 03, 10, 9
subset(df,시도명=='01')      #subset():전체 데이터에서 조건에 맞는 행들만 추출하는 기능
tmp=(subset(df,시도명=='01')) #시도명이 '01'인 행을 tmp로. 
str(tmp)                    #시도명이 '01'인 행의 구조 확인
summary(factor(tmp$시군구명))   #시군구명이 '서초구'만 있는가
table(tmp$시군구명)
unique(tmp$시군구명)

subset(df,시도명=='10')
tmp2=(subset(df,시도명=='10'))
str(tmp2)
summary(factor(tmp2$시군구명))   #시군구명이 '양구군'만 있는가
table(tmp2$시군구명)
unique(tmp2$시군구명)

#---------------------------------------

###################################
###데이터 형 변환
### 1. character를 factor로 변환
###  - 시도명, 시군구명, 도로종류, 도로노선명
###
### 2. 숫자를 factor로 변환하는 파생변수
###  - 설치연도, 제한속도
###################################
df$시도명=factor(df$시도명)
df$시군구명=factor(df$시군구명)
df[,3]=factor(df[,3])
df[,4]=factor(df[,4])
df[,6]=factor(df[,6])
str(df)
summary(df)
levels(df[,2])    #2열 종류 보여주기.

#---------------------------------------

##숫자를 factor로 변환하는 파생변수
df$설치연도Factor=factor(df$설치연도) #새로운 변수 만들기
ncol(df)   #colum 갯수 확인
str(df)    #colum 갯수 확인
summary(df)    #파생변수 columm 잘 넣어졌는가 확인

plot(df[,24])  #설치연도 추세 확인(x축 : 설치연도, Y축 : 행(갯수)

#---------------------------------------

##복습용 176쪽 매트릭스 구조가 필용한 이유
str(df)

ma=df$제한속도
ncol(ma) # X
nrow(ma) # X
length(ma)
summary(ma)

ma=df[,c(10:11)]  #ma = 위도,경도 
head(ma)
colSums(ma)
rowSums(ma)

#---------------------------------------

##컬럼명 정리
# -names(df)작업한 인덱싱번호에 컬럼명 변경
# -names(df) = c(' ','' '),(.....)

names(df)[1] = '카메라Num'
df$제한속도Factor=factor(df$제한속도)
names(df)[25] = '제한속도factor'
names(df)
names(df)[1]=paste(names(df)[1],'-ber',sep='')   #R은 문자열 연결을 +로 x

#---------------------------------------

##연결 명령어 
paste('a','b','c',sep='')
str(df)

#---------------------------------------

##필요한 컬럼만 모아서 별도의 데이터셋 제작
# -1. 불필요한 컬럼을 제거함으로서 수행속도를 높임
# -2. 분석하고자 하는 내용에 맞게끔 새로운 데이터프레임 구성
str(df)
df1=df[,c(2,3,4,7,11,13,14,16)]      #열 번호 보기 위해 names(df)사용
str(df1)
df2=df[,c(10,11,13,14)] # col : 위도,경도,단속구분,제한속도
str(df2)


#---------------------------------------

##조건에 맞는 자료만 필터링 해서 새로운 데이터 셋 제작(subset)
str(df1)

#단속구분을 unique하게 받아보기.
unique(df1$단속구분)

names(df1)

#subset을 이용하여 단속구분이 1인 자료만 필터링
단속1=(subset(df,단속구분=='1')) #type:chr
str(단속1)

#subset을 이용하여서 제한속도가 50인 자료만 필터링
제한=subset(df,제한속도==50)    #type:int
str(제한)

#subset을 이용하여 단속구분이 1인 자료 제외하고 필터링
단속x1=(subset(df,단속구분!='1')) #type:chr
str(단속x1)

#subset을 이용하여 단속구분1이고 시도명이 '경기도'인 자료 필터링
table(df1$시도명)
경기도단속1=subset(df,단속구분=='1' & 시도명=='경기도')
str(경기도단속1)

#---------------------------------------

##자료셋을 새로 제작해서 csv로 저장하기
부산=subset(df1,시도명=='부산광역시')
unique(부산$시군구명)

sido=unique(df1$시도명)
cnt=length(sido)
length(sido)
index=1

#select='경기도'
#tmp=subset(df1,시도명=='select')
tmp
fileName=paste(sido[index],'.csv',sep='')
write.csv(tmp,'경기도.csv')

##
sido=unique(df1$시군구명)
cnt=length(sido)
length(sido)

for(index in 1:cnt){
	tmp=subset(df1,시군구명==sido[index])

	fileName=paste('./시도명/',sido[index],'.csv',sep='')
	write.csv(tmp,fileName)
}
#----------------------------------
##폴더만들기
names(df1)
colbunho=2
folderName=paste(names(df)[colbunho],sep='')
dir.create(folderName)

#savefile=paste('./저장/',folderName,'/')
#----------------------------------
tmp=names(df1)
index=1
findCol=tmp[index]

폴더명=paste(,findCol,sep='')
dir.create(폴더명)
---------------------------------
dataList=unique(df1[,index])
head(unique(df1[,index]))

for(index2 in 1:length(dataList)){
	tmp=subset(df1, df1[,index]==index2)
	fileName=paste(폴더명,index2,'.csv',sep='')
	write.csv(tmp,filename)
}
-------------------------------------------
-------------------------------------------
##R메모리 변수 모두 제거
rm(list=ls())
ls()
----------------------

dir()
df=read.csv(dir()[2],stringsAsFactors = TRUE)
str(df)

df1=df[,c(1:9)]
str(df1)

##df1자료를 작업자료.csv로 저장
write.csv(df1,'작업자료.csv')

----------------------------------------
##기술통계
df=read.csv('작업자료.csv',stringsAsFactors = TRUE)
df=df[,-1]
summary(df)
sum(is.na(df))
colName=names(df)
for ( i in 1:cnt){
 sum(is.na(df[,i])))
}

##결측치 패키지 
install.packages('naniar') #naniar 패키지 설치
library(naniar) #naniar 패키지를 불러옵니다.
naniar::miss_case_summary(df) # case : 행 기준
naniar::miss_var_summary(df) # variable : 변수 기준
naniar::vis_miss(df) #결측치 시각화
naniar::gg_miss_var(df)
naniar::gg_miss_upset(df)
savePlot("무인카메라결측치1",type="png")  #Plot저장

install.packages('VIM')
library(VIM)
VIM::aggr(df)
savePlot("무인카메라결측치2",type="png")  #Plot저장

install.packages('Amelia')
library(Amelia)
missmap(df)
savePlot("무인카메라결측치",type="png")  #Plot저장

#--------------------------

데이터출처 : 공공데이터 포털의 '전국무인교통단속카메라표준데이터.csv'
수집방법 : 수동다운로드
데이터처리 프로그램 : R
데이터셋 개요 
 변수:23개 / 총 데이터 수 : 19581개
dir()
df=read.csv(dir()[4],stringsAsFactors = TRUE)

str(df)