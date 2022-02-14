#라이브러리 실행
library(dplyr)
library(readxl)

#변수 불러오기
exam <- read_excel("C:/Sources/StudyR/Recture/Busan_202202_R/1Day/Data/excel_exam.xlsx")

#math를 기준으로 오름차순 정렬
exam %>% arrange(math)

#내림차순 정렬
exam %>% arrange(desc(math))

#정렬 기준 변수 여러개 지정
exam %>% arrange(class,math)

#[예제 1] ----------------------------------------------------

#1. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 높은지 알아보려고 한다.
#   "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 자동차의 데이터를 출력하라

mpg <- as.data.frame(ggplot2::mpg) # mpg 불러오기

mpg %>% filter(manufacturer == "audi") %>%  # audi 추출
  arrange(desc(hwy)) %>%                    # hwy 내림차순 정렬    
  head(audi)                                # 5행까지 출력

#--------------------------------------------------------


#파생변수 추가하기 mutate (열 추가 후 조회만!)

exam %>% 
  mutate(total = math + english + science) %>%   #총합 변수 추가
  head

#두 개 이상의 파생변수 추가하기

exam %>% 
  mutate(total = math + english + science,          #총합 변수 추가
         mean = (math + english + science)/3) %>%   #총 평균 변수 추가
  head

# 함수 미사용ver
 #>>exam$total= exam$english + exam$science + exam$math

#mutate()에 ifelse() 적용하기
exam %>% 
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>% 
  head


#[예제 2]-----------------------------------------------

 #Q1 mpg 데이터 복사본을만들고, cty와 hwy를 더한 합산 연비 변수를 추가
  df=mpg
  df$"합산 연비 변수" = df$cty+df$hwy

 #Q2 합산 연비 변수를 2로 나눠 "평균 연비 변수"를 추가
  df$"평균 연비 변수" = df$"합산 연비 변수"/2

 #Q3 "평균 연비 변수"가 가장 높은 자동차 3종의 데이터를 출력하세요
  df %>% arrange(desc("평균 연비 변수")) %>% 
    head(3)

 #Q4 1~3번 문제를 해결할 수 있는 하나로 연결된 dplyr 구문을 만들어 출력
 #mpg 원본 이용
  mpg %>% mutate(sum = cty + hwy, mean = (cty + hwy) / 2 ) %>%
    arrange(desc(mean)) %>% 
    head(3)

#--------------------------------------------------------
  
#집단별로 요약하기
exam %>% summarise(mean_math = mean(math)) #math 평균 산출

exam %>% 
  group_by(class) %>%                 #class 별 묶음
  summarise(mean_math = mean(math))   #math 평균 산출


#여러 요약통계량 한 번에 산출하기
exam %>% 
  group_by(class) %>%                   #class 별 묶음
  summarise(mean_math = mean(math),     #평균
            sum_math = sum(math),       #합계
            median_math = median(math), #중간값
            n = n())                    #학생 수


#각 집단별로 다시 집단 나누기
mpg %>% group_by(manufacturer, drv) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  head(10)

#[예제 3]--------------------------------------------------------

# 회사별로 "suv"자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순 정렬하고 1~5위까지 출력
mpg %>% 
  group_by(manufacturer) %>% 
  filter(class=="suv") %>% 
  summarize (total=(mean(cty)+mean(hwy))/2) %>% 
  arrange(desc(total)) %>%
  head(5)


#[예제 4]--------------------------------------------------------

 #Q1.mpg 데이터의 class는 "suv", "compact"등 자동차를 특징에 따라 일곱 종류로 분류한 변수이다
 #어떤 차종의 연비가 높은지 비교해보자 한다. class 별 cty 평균을 구해라.
mpg %>% 
  group_by(class) %>% 
  summarize(mean(cty))

 #Q2. 앞 문제의 출력 결과는 class 값 알파벳 순으로 정렬되어 있습니다. 어떤 차종의 도시 연비가 높은지 쉽게 알아볼 수 있도록
 #cty평균이 높은 순으로 정렬해 출력하세요.
mpg %>% 
  group_by(class) %>% 
  summarize(mean_cty=mean(cty)) %>% 
  arrange(desc(mean_cty))

 #Q3. 어떤 회사 자동차의 hwy가 가장 높은지 알아보려고 합니다. hwy평균이 가장 높은 회사 세곳을 출력하시오
mpg %>% 
  group_by(manufacturer) %>% 
  summarize(mean_hwy=mean(hwy)) %>% 
  arrange(desc(mean_hwy)) %>% 
  head(3)

 #Q4. 어떤 회사에서 "compact"차종을 가장 많이 생산하는지 알아보려고 한다. 각 회사별 "compact"차종 수를 내림차순으로 정렬해 출력
mpg %>% 
  filter(class=="compact") %>% 
  group_by(manufacturer) %>% 
  summarize(count = n()) %>% 
  arrange(desc(count))

mpg %>%
  filter(class=="compact") %>% 
  count(manufacturer,sort=TRUE)

#------------------------------------------------

#가로로 합치기
 #중간고사 데이터 생성
test1 = data.frame(id = c(1,2,3,4,5),
                   midterm = c(60,80,70,90,85))
test1

 #기말고사 데이터 생성
test2 = data.frame(id = c(1,2,3,4,5),
                   final = c(70,83,65,95,80))
test2

 #id기준으로 합치기
 total <- left_join(test1, test2, by = "id")  #id 기준으로 합쳐 total에 할당
 total
 
#다른 데이터 활용해 변수 추가하기
 #명단생성
name = data.frame(class=c(1,2,3,4,5),
                  teacher = c("kim", "lee", "park", "choi", "jung"))
name
 
 #class기준 합치기
exam_new = left_join(exam, name, by = "class")
exam_new

#세로로 합치기
 #데이터 생성
group_a = data.frame(id = c(1,2,3,4,5),
                     test = c(60,80,70,90,85))
group_b = data.frame(id = c(6,7,8,9,10),
                     test = c(70,83,65,95,80))

group_all = bind_rows(group_a,group_b)
group_all

#[예제 5]--------------------------------------------------------
#mpg 데이터의 f1변수는 자동차에 사용하는 연료를 의미.
fuel = data.frame(fl = c("c", "d", "e", "p", "r"),
                  price_fl = c(2.35,2.38,2.11,2.76,2.22),
                  stringsAsFactors = F)

#Q1. mpg데이터에는 연료 종류를 나타내는 f1변수는 있으나, 연료 가격을 나타내는 변수는 없다.
#위의 데이터를 이용하여 price_f1 변수를 추가하라.

mpg2 = left_join(mpg, fuel, by = "fl")
mpg2  

#Q2. 연료가격 변수가 잘 추가되었는지 확인하기 위해 model, f1,price_f1변수를 추출해 앞부분 5행 출력하라

mpg2 %>% 
select(model,fl,price_fl) %>% 
head(5)

#-------------------------------------------------------
#결측치 만들기 (NA)
df = data.frame(sex = c("M", "F", NA, "M", "F"),
                score = c(5,4,3,4,NA))

#결측치 확인
is.na(df)

#결측치 빈도 출력
table(is.na(df))

#결측치 포함된 상태로 분석
mean(df$score) #평균산출

sum(df$score) #합계산출

#결측치 존재하는 행 제거
df %>% filter(is.na(score)) #score 가 NA인 데이터만 출력
df %>% filter(!is.na(score)) #socre 결측치 제거

#결측치 제외한 데이터로 분석
df_nomiss = df %>% filter(!is.na(score)) #score 결측치 제거
mean(df_nomiss$score)
sum(df_nomiss$score)    

#여러 변수 동시에 결측치 없는 데이터 추출
df_nomiss = df %>% filter(!is.na(score) & !is.na(sex)) #score 결측치 제거

#결측치가 하나라도 잇으면 제거하기
df_nomiss2 = na.omit(df)
df_nomiss2

#함수의 결측치 제외 기능 이용하기
mean(df$score, na.rm = T) #결측치 제외하고 평균 산출

#결측치 생성
 exam = read.csv("C:/Sources/StudyR/Recture/Busan_202202_R/1Day/Data/csv_exam.csv")

exam[c(3,8,15), "math"] = NA     #3, 8, 15행의 math에 NA 할당
 
#평균 구하기
exam %>% summarise(mean_math = mean(math))  #평균산출

exam %>% summarise(mean_math = mean(math, na.rm = T))  #결측치 제외하고 평균산출

#평균값으로 결측치 대체하기
exam$math = ifelse(is.na(exam$math), 55, exam$math)    #math가 NA면 55로 대체
table(is.na(exam$math))

#[예제 6]--------------------------------------------------------
mpg = as.data.frame(ggplot2::mpg)       #mpg데이터불러오기
mpg[c(65,124,131,153,212),"hwy"] = NA   #NA 할당

#Q1. drv별로 hwy평균이 어떻게 다른지 알아보고자 한다. drv변수와 hwy변수 결측치가 몇개 있는가?
table(is.na(mpg$drv))
table(is.na(mpg$hwy))

#Q2. filter()를 이용해 hwy변수의 결측치를 제외하고, 어떤drv의 hwy 평균이 높은가? 하나의 구문으로 만들어라.
mpg %>% 
  filter(!is.na(hwy)) %>%           #결측치 제외
  group_by(drv) %>%                 #drv별 분리
  summarise(mean_hwy = mean(hwy))   #평균 구하기

#----------------------------------------------------------------
##이상치 제거하기

#이상치 포함된 데이터 생성
outlier = data.frame(sex=c(1,2,1,3,2,1),
                     score = c(5,4,3,4,2,6))
outlier

#결측 처리하기
outlier$sex = ifelse(outlier$sex ==3, NA, outlier$sex)
outlier

outlier$score = ifelse(outlier$score >5, NA, outlier$score)
outlier

#결측치 제외하고 분석
outlier %>% 
  filter(!is.na(sex) & !is.na(score)) %>% 
  group_by(sex) %>% 
  summarise(mean_score = mean(score))

mpg <- as.data.frame(ggplot2::mpg) # mpg 불러오기

mpg = as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)

#상자그림 통계치 출력
boxplot(mpg$hwy)$status

#결측 처리하기
  #12~37벗어나면 NA할당
mpg$hwy = ifelse(mpg$hwy <12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))
                 
#결측치 제외하고 분석하기
mpg %>%
group_by(drv) %>%
summarise(mean_hwy = mean(hwy, na.rm = T))

#[예제 7]--------------------------------------------------------
mpg <- as.data.frame(ggplot2::mpg)                  # mpg 데이터 불러오기
mpg[c(10, 14, 58, 93), "drv"] <- "k"                # drv 이상치 할당
mpg[c(29, 43, 129, 203), "cty"] <- c(3, 4, 39, 42)  # cty 이상치 할당

#Q1.drv에 이상치가 있는지 확인. 결측처리하라. (%in%사용)
table(mpg$drv)
mpg$drv = ifelse(mpg$drv == "k", NA, mpg$drv)
                   #또는
mpg$drv = ifelse(mpg$drv %in% c("4", "f", "r"), mpg$drv, NA)

#Q2.boxplot사용하여 cty 이상치 확인 후 결측처리
boxplot(mpg$cty)$stats

mpg$cty = ifelse(mpg$cty < 9 | mpg$cty > 26, NA, mpg$cty)

#Q3.두 변수의 drv별로 cty의 평균이 어떻게 다른지 확인

mpg %>%
  filter(!is.na(drv) & !is.na(cty)) %>%  # 결측치 제외
  group_by(drv) %>%                      # drv별 분리
  summarise(mean_hwy = mean(cty))        # cty 평균 구하기

