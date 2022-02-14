#산점도 만들기
library(ggplot2)

#배경설정하기 (x축 displ, y축 hwy로 지정해 배경생성)
ggplot(data=mpg, aes(x = displ, y= hwy))

# 배경에 산점도 추가
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

#축 범위를 조절 (X축 3~6, Y축 10~30)
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)

#ggplot2 코드 가독성 높이기
## 한 줄로 작성
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)

## + 뒤에서 줄 바꾸기
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)


#[예제 1]----------------------------------------------
#Q1. mpg 데이터의 x축은 cty, y축은 hwy의 산점도 만들기
ggplot(data=mpg, aes(x=cty, y=hwy))+ geom_point()

#Q2. 패키지의 midwest 데이터 이용 x 축 poptotal(전체 인구), y축 popasian 산점도
#전체 인구는 50 만 명 이하, 아시아인 인구는 1 만 명 이하인 지역만 산점도에 표시되게 설정
ggplot(data=midwest, aes(x=poptotal, y=popasian)) +
  geom_point() +
  xlim(0, 500000) +
  ylim(0, 10000)

#-------------------------------------------------
#막대그래프 만들기
#집단별 평균표 만들기
df_mpg = mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))
df_mpg

#그래프 생성
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

#크기 순으로 정렬하기
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()

#빈도 막대그래프
ggplot(data = mpg, aes(x = drv)) + geom_bar()

#x 축 연속 변수, y 축 빈도
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

#[예제 2]----------------------------------------------
#Q1 데이터 : mpg suv차종 대상 평균cty가 가장 높은 회사 다섯 곳을 막대 그래프로 표현. 연비 높은순으로 정렬
df = mpg %>% 
  filter(class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty)) %>% 
  head(5)
ggplot(data = df, aes(x = reorder(manufacturer, -mean_cty),
                      y = mean_cty)) + geom_col()

#Q2. 어떤 class가 가장 많은지 알아보자. 자동차 종류별 빈도를 표현한 막대 그래프로 표현
ggplot(data = mpg, aes(x = class)) + geom_bar()
