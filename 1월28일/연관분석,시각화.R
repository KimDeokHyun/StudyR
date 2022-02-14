dir()
setwd("C:/Sources/StudyR/1월28일")

df=read.csv("CUST_ORDER_OUTPUT2.csv",sep='\t',encoding='ANSI',
stringsAsFactors = TRUE)

str(df)


df <- df[df$SEX != "*",]

head(df,10)

#구매일자, 성별, 구매 건수만 추출하여 별도의 데이터 프레임을 만들기.
sex1 <- subset(df, select=c(ORDER_DATE,SEX,QTY))
sex1

#패키지설치
install.packages('arules')
library(lubridate)

#월만 추출해서 month라는 새로운 열을 추가
sex2 <- cbind(sex1, month=month(sex1$ORDER_DATE))
head(sex2,5)

install.packages('wordcloud')
library(wordcloud)


dcast(sex2, SEX ~ month,value.var="QTY",sum)

#------------------------------------------
install.packages('arules')
library(arules)

#arules 시각화 라이브러리
install.packages('arulesViz')
library(arulesViz)
#용어 : 트랜젝션파일
#용어 : 마스터파일

#------------------------------------------
dir()
tran=read.transactions('train.txt',format='basket',sep=',')

str(tran)
head(tran)
class(train)
tran@data@i

#지지도0.3 향상도 0.1 이상 자료 (0.1은 10%를 의미함)
rule = apriori(tran,parameter=list(supp=0.3 , conf=0.1))
inspect(rule)
inspect(rule[1:10])

# lift(향상도) 높은순으로 10개
inspect(sort(rule,by="lift")[1:10]) 

넥타이(A), 셔츠(B) 신뢰도
	넥타이와 셔츠의 지지도 / 넥타이의 지지도
	0.50/0.50 => 1

셔츠(B), 넥타이(B)의 신뢰도
	셔츠와 넥타이의 지지도 / 셔츠의 지지도
	0.50/0.75 => 0.6666


#-------------------------------------
#시각화
library(arulesViz)
가로(지지도), 세로(신뢰도), 색상(향상도) 
아래 자료는 지지도 0.25, 신뢰도 0.5와 1일때 향상도가 높음, 진한빨강색이 표시됨.
plot(rule)

savePlot("Pic3",type="png")

##매트릭스차트
# Ihs(가로축)-조건(x아이템)과 rhs(세로축)-결과(y아이템) 으로구성한매트릭스그래프
plot(rules,method="grouped")

##네트워크차트
# 각규칙별로어떤아이템들이 연관되어묶여있는지 보여주는네트워크그래프
plot(rule,method="graph")
