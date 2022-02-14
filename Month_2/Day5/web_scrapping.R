

#웹 문서 가져오기
#install.packages("readxl")
library(readxl)

data = read.csv("./Day5/전라남도 목포시_장애인 복지시설_20210802.csv",header=T,fileEncoding="EUC-KR")

data

#웹 스크래핑
#install.packages("rvest")
#install.packages("stringr")
library(rvest)
library(stringr)

#1. 웹 스크래핑 대상 URL 할당
url= "https://www.bobaedream.co.kr/cyber/CyberCar.php?gubun=K&page=1"
url

#2. 웹 문서 가져오기
usedCar = read_html(url)
usedCar

#3. 특정 태그의 데이터 추출
#가져온 usedCar에서 css가 ".product-item"인 것을 찾음
carInfos = html_nodes(usedCar, css=".product-item")
head(carInfos)

# 차량 명칭 추출

title_tmp = html_nodes(carInfos, css=".tit.ellipsis")
title_tmp

title = html_text(title_tmp)
title

title = str_trim(title)  #공백제거
title
#title = str_replace(title, '\r', '') #문자열 변경 (\n을 스페이스로 변경)

#차량 연식 추출
year_tmp = html_node(carInfos, css=".mode-cell.year")
year_tmp

year = html_text(year_tmp)
year

year = str_trim(year)  #공백제거
year

#연료 구분
fuel_tmp = html_node(carInfos, css=".mode-cell.fuel")
fuel_tmp

fuel = html_text(fuel_tmp)
fuel

fuel = str_trim(fuel)  #공백제거
fuel

#주행거리 추출
km_tmp = html_node(carInfos, css=".mode-cell.km")
km_tmp

km = html_text(km_tmp)
km

km = str_trim(km)  #공백제거
km

#판매가격 추출
price_tmp = html_node(carInfos, css=".mode-cell.price")
price_tmp

price = html_text(price_tmp)
price

price = str_trim(price)  #공백제거
price

price = str_replace(price, '\n', '') #문자열 변경 (\n을 스페이스로 변경)
price

maker = c()
maker
title

for(i in 1 : length(title)){
  maker = c(maker, unlist(str_split(title[i],' '))[1])
}
maker

#4. 데이터 프레임 만들기
usedcars = data.frame(title, year, fuel, km, price, maker)
View(usedcars)

#5. 데이터 정제
#km 자료 숫자로 변경
usedcars$km

usedcars$km = gsub("만km", "0000", usedcars$km)
usedcars$km = gsub("천km", "000", usedcars$km)
usedcars$km = gsub("km", "", usedcars$km)
usedcars$km = gsub("미등록", "", usedcars$km)
usedcars$km = as.numeric(usedcars$km)

#price 자료 숫자로 변경
usedcars$price

usedcars$price = gsub("만원", "", usedcars$price)
usedcars$price = gsub("계약", "", usedcars$price)
usedcars$price = gsub("팔림", "", usedcars$price)
usedcars$price = gsub("금융리스", "", usedcars$price)
usedcars$price = gsub(",", "", usedcars$price)
usedcars$price = as.numeric(usedcars$price)

#웹 스크래핑 자료 파일로 저장하기
write.csv(usedcars,"./Day5/usedcars_new.csv")
