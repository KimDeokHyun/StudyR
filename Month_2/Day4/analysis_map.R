library(dplyr)
library(ggplot2)

###미국 주별 강력 범죄율 단계 구분도 만들기-----------------------
#데이터 준비
#install.packages("ggiraphExtra")
library(ggiraphExtra)

str(USArrests)

head(USArrests)   #지역명이 인덱스로 잡혀있음.

library(tibble)
crime <- rownames_to_column(USArrests, var = "state")
crime$state <- tolower(crime$state)
str(crime)

#미국 주 지도 데이터
states_map <- map_data("state")
str(states_map)

#단계 구분도 만들기
ggChoropleth(data = crime,         # 지도에 표현할 데이터
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map)     # 지도 데이터

#인터렉티브 단계 구분도 만들기
ggChoropleth(data = crime,         # 지도에 표현할 데이터
             
             aes(fill = Murder,    # 색깔로 표현할 변수
                 map_id = state),  # 지역 기준 변수
             map = states_map,     # 지도 데이터
             interactive = T)      # 인터랙티브


###대한민국 시도별 인구 단계 구분도 만들기---------------------------
#1.패키지 준비

#install.packages("stringi")
#install.packages("devtools")
#devtools::install_github("cardiomoon/kormaps2014")
library(DT)
library(kormaps2014)
library(dplyr)

#2.대한민국 시도별 인구 데이터 준비하기
str(changeCode(korpop1))

#3. 변수명 영어로 (깨짐방지)

korpop1 <- rename(korpop1,
                  pop = 총인구_명,
                  name = 행정구역별_읍면동)
str(korpop1$name)

#4. 대한민국 시도 지도 데이터 준비하기
str(changeCode(kormap1))

#5. 단계 구분도 만들기
korpop1$name <- iconv(korpop1$name, "UTF-8","CP949")

ggChoropleth(data = korpop1,      # 지도에 표현할 데이터
             aes(fill = pop,      # 색깔로 표현할 변수
                 map_id = code,   # 지역 기준 변수
                 tooltip = name), # 지도 위에 표시할 지역명
             map = kormap1,       # 지도 데이터
             interactive = T)     # 인터랙티브
#대한민국 시도별 결핵 환자 수 단계 구분도 만들기
str(changeCode(tbc))
tbc$name1 <- iconv(tbc$name1, "UTF-8", "CP949")

ggChoropleth(data = tbc,          # 지도에 표현할 데이터
             aes(fill = NewPts,   # 색깔로 표현할 변수
                 map_id = code,   # 지역 기준 변수
                 tooltip = name1), # 지도 위에 표시할 지역명
             map = kormap1,       # 지도 데이터
             interactive = T)     # 인터랙티브

#--------------------------------------------------
#changeCode() UTF-8 ->CP949 (깨짐방지)
#변수
str(changeCode(korpop1)) #시도별 데이터

#지도데이터
str(changeCode(kormap1)) #시도별 지도

str(changeCode(tbc)) #결핵

#예제1.대한민국 시도별 외국인 거주 수 단계 구분도 만들기
str(changeCode(korpop1))

korpop1 = rename(korpop1,
                 f_total = 외국인_계_명,
                 f_m = 외국인_남자_명,
                 f_w = 외국인_여자_명)

korpop1$f_total <- iconv(korpop1$f_total,"UTF-8", "CP949")
ggChoropleth(data = korpop1,       # 지도에 표현할 데이터
             aes(fill = f_total ,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도 데이터
             interactive = T)        # 인터랙티브

#예제2. 대한민국 시도별 아파트 호수 단계 구분도

korpop1 = rename(korpop1,
                 apt = 아파트_호)
  
korpop1$apt <- iconv(korpop1$apt,"UTF-8", "CP949")
ggChoropleth(data = korpop1,       # 지도에 표현할 데이터
             aes(fill = apt,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도 데이터
             interactive = T)        # 인터랙티브

#예제3. 대한민국 가구당 평균 인원 수
korpop1 = rename(korpop1,
                 gagu = 가구_계_가구)
korpop1$gagu_mean=(korpop1$pop/korpop1$gagu)

korpop1$gagu_mean

korpop1$gagu_mean <- iconv(korpop1$gagu_mean,"UTF-8", "CP949")
ggChoropleth(data = korpop1,       # 지도에 표현할 데이터
             aes(fill = gagu_mean,       # 색깔로 표현할 변수
                 map_id = code,    # 지역 기준 변수
                 tooltip = name),  # 지도 위에 표시할 지역명
             map = kormap1,        # 지도 데이터
             interactive = T)        # 인터랙티브

#예제4.시간변화에 따른 결핵환자 감소 수 ing
str(changeCode(korpop1))


tbc %>% 
  filter(!is.na(NewPts)) %>% 
  group_by(na) %>% 
  summarise(n=n()) %>% 
  head(10)


#NA없애기  ########################################################

str(changeCode(korpop1))#name이 na가 뜬다.
str(changeCode(kormap1)) #name 값이 있다.
#left join으로 kormap1의 name을 korpop1의 name으로 덮기. join:code

df=data.frame(kormap1$code,kormap1$name) #kormap1의 code, name 추출

str(changeCode(df)) #조회. 

df1 <- rename(df, code = kormap1.code)
df2 <- rename(df1, name1 = kormap1.name)
str(changeCode(df2)) #조회.

korpop10 <- left_join(df2,korpop1, by = "code") #left join

str(changeCode(korpop10)) #조회.

###########################################################

#미니프로젝트때 제출
#사용 데이터 : korpop1,tbc
#결과물 : 소주제 4개 이상
#결과물 파일명 : 01_R_이름.R
#별도 [산출물]폴더 만들어서 개인적으로 관리.

