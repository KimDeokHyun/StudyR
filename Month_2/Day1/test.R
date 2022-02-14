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

exam <- read.csv("./Data/csv_exam.csv")
