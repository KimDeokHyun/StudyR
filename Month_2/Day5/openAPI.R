# 웹사이트 URL 설정
api_url <- "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty"

# 승인 받은 KEY 등록
service_key <- "s%2FfdHc62kiGZqeJZAXK%2BIWpeTStxRVWDxsaIA48hEBdSDM3Ehbopz49DeASZk%2BSrsKJCezUXJkN4fOqHELedog%3D%3D"

# 요청변수 등록
numOfRows = "30"
sidoName = "경기"

sidoName = URLencode(iconv(sidoName, to = "UTF-8")) #한글은 웹 url코드화
sidoName

searchCondition = "DAILY"


open_api_url = paste0(api_url,"?serviceKey=",service_key,
                      "&numOFRows=",numOfRows,
                      "&sidoName=",sidoName,
                      "&searchCondition=",searchCondition)
open_api_url

#오픈 API 통하여 XML 형식으로 자료 가져오기
raw.data = xmlTreeParse(open_api_url,
                        useInternalNodes = TRUE,
                        encoding = "utf-8")
raw.data

#XML 형식의 자료를 데이터프레임으로 변경하기
#</item> 태그 별로 데이터 구분하기
air_pollution = xmlToDataFrame(getNodeSet(raw.data," //item"))
air_pollution

View(air_pollution)

#subset() : 데이터프레임 내에서 검색조건(select)에 맞는 항목만 가져오기
air_pollution = subset(air_pollution,
                       select = c(dataTime,
                                  stationName,
                                  so2Value,
                                  coValue,
                                  o3Value,
                                  no2Value,
                                  pm10Value))
View(air_pollution)

#OPEN API 자료 파일로 저장하기
write.csv(air_pollution,"./Day5/air_pollution.csv")

#해보기-----------------------------------------------------------

#1. 웹사이트 URL 설정
api_url <- "http://apis.data.go.kr/1160100/service/GetStocDiviInfoService/getDiviInfo"

#2. 승인 받은 KEY 등록
service_Key <- "s%2FfdHc62kiGZqeJZAXK%2BIWpeTStxRVWDxsaIA48hEBdSDM3Ehbopz49DeASZk%2BSrsKJCezUXJkN4fOqHELedog%3D%3D"

#3. 요청변수 등록
numOfRows = "30"
stckIssuCmpyNm = "동남합성"

stckIssuCmpyNm = URLencode(iconv(stckIssuCmpyNm, to = "UTF-8"))

searchCondition = "DAILY"

#4. URL 주소를 공백없이 모두 묶기
open_api_url = paste0(api_url,"?serviceKey=",service_Key,
                      "&numOfRows=",numOfRows,
                      "&stckIssuCmpyNm=",stckIssuCmpyNm,
                      "&searchCondition=",searchCondition)
open_api_url

#5. 오픈 API 통하여 XML 형식으로 자료 가져오기
raw.data = xmlTreeParse(open_api_url,
                        useInternalNodes = TRUE,
                        encoding = "utf-8")
raw.data

#6. XML 형식의 자료를 데이터 프레임으로 변경
stock = xmlToDataFrame(getNodeSet(raw.data,"//item")) #태그 별로 데이터 구분하기
stock

View(stock)

#7. subset() : 데이터프레임 내에세 검색 조건 (select)에 맞는 항목 (컬럼)들만 부르기
stock= subset(stock,
              select = c (basDt,
                          cashDvdnPayDt,
                          isinCdNm,
                          scrsItmsKcdNm,
                          stckDvdnRcdNm,
                          trsnmDptyDcdNm))

View(stock)

#8. 오픈 API 자료 파일로 저장하기
write.csv(stock, "./Day5/stock_new.csv")
