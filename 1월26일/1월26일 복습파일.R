###복습 시작

#1. 파일 불러오기
  dir()
  df=read.csv("전국무인교통단속카메라표준데이터.csv")  #불러오기
  str(df)  								 #확인

#2. 필요한 컬럼 선택
  df1=df[,c(1:9)]   #불러오기
  str(df1)          #확인
  summary(df)

#3 df1$columm 2의 이상한 이름 확인하기.
  unique(df1[,2])               #01, 09, 10, 03
  #=table(df[,2]) 
  subset(df,시도명=='01')
    #-01=서울특별시 / #03=대구 / #10=강원도 #9=경기도  
    #subset():전체 데이터에서 조건에 맞는 행들만 추출하는 기능

#4 Character -> Factor
  df$시도명=factor(df$시도명)
  levels(df$시도명)
  barplot(table(df$시도명)) #바플릿 출력

#5 초기화
  rm(list=ls())
  ls()
  df

#6 컬럼명 변경 
  names(df1)[1]='카메라이름' #변경
  str(df1) 			   #확인

#7 연결 명령어
  names(df1)[1]=paste(names(df1)[1],'-ber',sep='')
   #R은 문자열 연결을 +로 x
  paste('a','b','c',sep='')
  str(df1)

#8 조건에 맞는 자료만 필터링해서 새로운 데이터 셋 제작 (subSet)
  #subset을 이용하여 단속구분이 1인 자료만 필터링
  단속1=(subset(df,단속구분=='1')) #type:chr
  str(단속1)

★★#9 자료셋을 새로 제작해서 csv로 저장하기★★다시해보기

  부산=subset(df1,시도명=='부산광역시') #df1 내 시도명=부산광역시인 데이터를 부산
  unique(부산$시군구명)

#10 폴더만들기  
  names(df1)
  colbunho=2
  folderName=paste(names(df)[colbunho],sep='')
  dir.create(folderName)
  #savefile=paste('./저장/',folderName,'/')

