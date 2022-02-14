#PATH = "${RTOOLS40_HOME}\usr\bin${PATH}"
install.packages("usethis")
usethis::edit_r_environ()
Sys.which("make")

install.packages("rJava")
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))


library(KONLP)
library(dplyr)

useNIADic()

txt = readLines("./Data/hiphop.txt", encoding="UTF-8")
txt

install.packages("stringr")
library(stringr)

#특수문제 제거
#txt = string