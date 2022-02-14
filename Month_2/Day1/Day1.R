#영어 점수 변수 생성
english <- c(90, 80, 60, 70)
english

#수학 점수 변수 생성
math <- c(50, 60, 100, 20)
math

class <- c(1, 1, 2, 2)
class

#반(class)변수 추가
df_midterm <- data.frame(english, math, class)
df_midterm

##파이썬은 index 0부터 시작, R은 1부터 시작

mean(df_midterm$english)
mean(df_midterm$math)

#readxl 패키지 설치
install.packages("readxl")
library(readxl)

#excel열기
dir()
df_exam <- read_excel("./Data/excel_exam.xlsx")
df_exam

df_exam_novar <- read_excel("./Data/excel_exam_novar.xlsx")
df_exam_novar

#csv열기
df_csv_exam <- read.csv("./Data/csv_exam.csv")
df_csv_exam

write.csv(df_midterm, file = "./Data/df_midterm_1.csv")

#----------------------------------------------------------

exam <- read.csv("./Data/csv_exam.csv")
exam

head(exam)   #상위5개 데이터 출력
View(exam)   #새 창에서 출력
dim(exam)    #행,열 개수
str(exam)    #데이터 타입 및 속성 확인
summary(exam)#데이터 요약


#dplyr 설치
install.packages("dplyr")
library(dplyr)

#데이터프레임 생성
df_raw <- data.frame(var1 = c(1,2,1),var2=c(2,3,2))
df_raw

#복사본 만들기
df_new <-df_raw

#var2를 v2로 수정
df_new <- rename(df_new, v2 = var2)
df_new

#파생변수 생성 (컬럼추가)

df <- data.frame(var1 = c(4,3,8),var2 = c(2,6,1))
df$var_sum <- df$var1 + df$var2
df$var_Mean <-(df$var1 +df$var2)/2
df

#mpg 데이터 확인
mpg <- as.data.frame(ggplot2::mpg)
mpg

#데이터 앞부분 10개 조회
head(mpg,10)

#통합 연비 변수 평균 생성
mpg$total <- (mpg$cty + mpg$hwy)/2
mpg

#히스토그램 생성
hist(mpg$total)

#table
table(mpg$test)

#라이브러리 추가
install.packages("ggplot")
library(ggplot2)

#플롯
qplot(mpg$test)

#중첩 조건문을 활용하여 통합연비 등급 변수 추가
#total을 기준으로 A,B,C 등급 부여 (등급->범주)
mpg$grade <-ifelse(mpg$total >=30,"A",
                   ifelse(mpg$total>=20,"B","C"))

#예제1
midwest = as.data.frame(ggplot2::midwest)

##1번
head(midwest)
tail(midwest)
View(midwest)
dim(midwest)
str(midwest)

#2번
total = midwest$poptotal
asian = midwest$popasian

#3번
midwest$totasian = asian/total*100
hist(midwest$totasian)

#4번
midwest$mean_totasian= mean(midwest$totasian)
midwest$totasian1=ifelse(midwest$totasian > midwest$mean_totasian, "large", "small")

#5번
table(midwest$totasian1)
qplot(midwest$totasian1)


#예제2
# mpg 데이터를 이용해서 분석 문제를 해결
#1번
displ4=mpg %>% filter(displ<=4)
mean(displ4$hwy)
displ5=mpg %>% filter(displ>=5)
mean(displ5$hwy)
#4이하인 자동차가 고속도로 연비 평균적으로 더 높음

#2번
man1=mpg %>% filter(manufacturer=="audi")
man2=mpg %>% filter(manufacturer=="toyota")
mean(man1$cty)
mean(man2$cty)
#도요타의 평균연비가 더높음

#3번
man3=mpg %>% filter(manufacturer%in%c("chevrolet","ford","honda"))
mean(man3$hwy)
# 쉐보레 포드 혼다 세 회사의 고속도로 연비(hwy) 의 합산평균은
#  22.50943

