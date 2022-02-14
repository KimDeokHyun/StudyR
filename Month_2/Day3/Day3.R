library(dplyr)
library(ggplot2)

#시계열 그래프 만들기
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

#박스플릿 만들기
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

#[예제 1]--------------------------------------------------
#Q1. economics데이터 활용. psavert가 시간에 따른 변화를 시계열 그래프로 만들어라
ggplot(data=economics, aes(x=date, y = psavert))+geom_line()

#Q2. class가 "compact", "subcompact", "suv"인 자동차의 cty가 어떻게 다른지 비교.
#새 차종의 cty를 나타낸 상자그림을 만들어라
mpg1 = mpg %>% 
  filter(class %in% c("compact", "subcompact", "suv"))

ggplot(data = mpg1, aes(x=class, y = cty)) + geom_boxplot()

#ggplot2 함수----------------------------------------------
geom_point()   #산점도
geom_col()     #막대 그래프 - 요약표
geom_bar()     #막대 그래프 - 원자료
geom_line()    #선 그래프
geom_boxplot() #상자 그림



