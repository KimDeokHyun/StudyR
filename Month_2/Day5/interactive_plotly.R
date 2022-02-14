#1. 인터랙티브 그래프 
# (1) plotly 패키지로 그래프 생성  
#install.packages("plotly") 
library(plotly)
library(ggplot2)

# 인터랙티브 산점도 그래프 생성
p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()

ggplotly(p)


# 인터랙티브 막대 그래프 생성
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) + 
  geom_bar(position = "dodge")

ggplotly(p)

# (2) dygraphs 패키지로 인터랙티브 시계열 그래프 생성
#install.packages("dygraphs")
library(dygraphs)
library(xts)

economics <- ggplot2::economics
head(economics)

# 시계열 그래프 생성
eco = xts(economics$unemploy, order.by = economics$date)
head(eco)

# 그래프 생성
dygraph(eco)

#날짜 범위 선택 기능
dygraph(eco) %>% dyRangeSelector()

#여러 값 표현하기
eco_a = xts(economics$psavert, order.by = economics$date)        #저축률

eco_b = xts(economics$unemploy/1000, order.by = economics$date)  #실업자 수

합치기
eco2 = cbind(eco_a,eco_b)     #데이터 결합
eco2
colnames(eco2) = c("psavert", "unemploy")

#그래프 생성
dygraph(eco2) %>% dyRangeSelector()  
