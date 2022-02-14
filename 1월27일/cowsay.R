#cowsayÆÐÅ°Áö

install.packages('cowsay')
library(cowsay)
say('heoo', by='snowman')
say('Hello world!', by='cat')

byNameList=c('cat', 'ghost', 'ant')
for (byName in byNameList){
say('heoo', by=byName)}