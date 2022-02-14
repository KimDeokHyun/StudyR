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

