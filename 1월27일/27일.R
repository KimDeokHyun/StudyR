#cowsay패키지

install.packages('cowsay')
library(cowsay)
say('heoo', by='snowman')
say('Hello world!', by='cat')

byNameList=c('cat', 'ghost', 'ant')
for (byName in byNameList){
say('heoo', by=byName)}

#------------------------------------

#reshape2패키지

install.packages('reshape2')
library(reshape2)

#자료 파악 : 변수의 성격과 해설

head(tips) #구조파악
str(tips)  #구조파악 
unique(tips$day) ->펙터 Fri, Sat, Sun, thur

#total_bill : 전체지불비융 		 / Num
#tip    : tip비용			 / Num
#sex    : 성별(카드결제자) 	 	 / Fac
#smoker : 흡연석/비흡연석    	 / Fac
#day    : 요일(Fri,Sat,Sun,Thur)/ Fac
#time   : 방문시간 			 / Fac
#size   : 방문인원			 / int

sum(is.na(tips))

for (i in 1:length(tips)){
	if (class(tips[,i])
? ? ?

#------------------------------------
#가설과 검증
#1번가설 : 성별에 따르는 tips의 비용응 같다
#  0가설(귀무가설)
#  검증을 통해서 비용은 같다 ->귀무가설 선택
#  비용이 다르다 ->귀모가설 기각, 대립가설 선택
#  p.value통해서 확인
#  일반적인 가설검증은 데이터집계를 통해서 비교
table(tips[,3])     #성별의 빈도수, 전체데이터에서 발생회수 
table(tips[,4])

for(i in 3:7){
print(table(tips[,i]))} #성별의 빈도수, 전체데이터에서 발생횟수

din=subset(tips,time=='Dinner') #din = time이 dinner인 자료 추출
lun=subset(tips,time=='Lunch')  #lun = time이 lunch인 자료 추출

table(tips$time) #테이블 조회
table(din$day)
table(lun$day)
head(din)

colMeans(din[c('total_bill','tip','size')]) #식사비,팁,인원수 평균
colMeans(lun[c('total_bill','tip','size')])

colSums(din[c('total_bill','tip','size')]) #식사비, 팁, 인원수 합계
colSums(lun[c('total_bill','tip','size')])
str(tips)

par(mfrow=c(2,1))
plot(din$tip)    # 누가 많이 줬는지 확인하기위해
plot(lun$tip)

tmp=subset(lun, tip>=4) #lunch데이터 중 tip이 4이상인 자료 추출

#
summary(tmp)
summary(lun)
summary(tips,tips$day=='Fri')
#>>점심을먹는 사람 중 팁을 4원이상을 준 인원수에 따른 테이블 수

tmp=subset(tips,tips$day=='Fri')
table(tmp$size)

#----------------------------------------------
성별에 다라 tip의 차이가 없다.
table(tips[,3])
s.M=subset(tips,tips$sex=='Male')
s.F=subset(tips,tips$sex=='Female')
summary(s.M)
summary(s.F)

par(mfrow=c(2,1))
plot(s.F$tip,main='F - Tips')
plot(s.M$tip,main='M - Tips')

plot(s.F$size,main='F - size')
plot(s.M$size,main='M - size')

#----------------------------------------------
savePlot("7번_tip_4종",type="png")  #Plot저장
str(s)
s=tips
plot(s)
plot(s[,1],s[,2]) #팁 대비 지불금액
plot(s[,7],s[,1]) #인원수 대비 가격
colNum=c(1,2,7)
par(mfrow=c(3,1))
for (i in colNum){
	plot(s[,i],main=names(s)[i])}
#---------------------------------------------
mtcars
str(mtcars)
mt=mtcars[,c(1,3,5,6)]
str(mt)
plot(mtcars[,c(1,3,5,6)])

#---------------------------------------------
#피어슨상관계수 (-1~1 사이 값)
cor(mtcars[,c(1,3,5,6)])

#머신러닝(기계학습)
 -독립변수들과 종속변수의 분석을 통한 예측.분류
 -기계가 학습하여 모델을 생성하고 새로운 데이터를 예측하거나 분류
  그 중 사진, 오디오, 비디오 등의 비정형데이터는 양이 엄청 많음
  이러한 비정형데이터에 특화된 분석은 인공신경망을 이용. 이를 딥러닝 

 
 -독립변수(x)끼리는 상관도가 너무 높으면 안됨.
 -상관도가 너무 높은 경우를 다중공선성이라함
 -다중공선성은 VIF(분산팽창지수)로 10이상나오는 걸 의미
 -이런 경우 X변수를 제거하고, VIF를 보고 반복...

install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(mt,histogram=TRUE, pch=19)
#----------------------------------------------

tips
str(tips)
boxplot(tip~day,data=tips,main='날짜',
col=c('red','yellow','green','blue'))

tmp=subset(tips,day=='Sat')
par(mfrow=c(2,2))
boxplot(tip~size,data=tips)
boxplot(tip~sex,data=tips)
boxplot(tip~smoker,data=tips)
boxplot(tip~time,data=tips)


