# 參考文章
# https://blog.alantsai.net/posts/2018/01/data-science-series-16-r-hello-world-with-stock-analysis-using-quantmod
library("quantmod")

mySymbols<-c("ASML","VOO","VWO","TSM","NFLX","VEA")
getSymbols(mySymbols)
dataset<- xts() # Only run once
startDate <- "2020-03-01"
expDate <- format(Sys.Date(),"%Y-%m-%d")
# https://stackoverflow.com/questions/34407583/looping-with-quantmod
for (symbolName in mySymbols) {
  
  data1 <- tryCatch( getSymbols( Symbols= symbolName))
  # 要用 get 把 xts 物件存下來
  if (is.null(data1)) next()
  data<-get(data1)
  price<-get(data1)[,4]
  ma20<-runMean(price,n=20)
  ma60<-runMean(price,n=60)
  timeSpan<-paste0(startDate,"::",expDate)
  chartSeries(data[,4][timeSpan], name=symbolName, theme="white")
  # Use print to print it out. No print, no line.
  print(addTA(ma20,on=1,col="blue"))
  print(addTA(ma60,on=1,col="red"))
  fileName<-paste(c(symbolName,expDate),collapse="-")
  saveChart("pdf",file=paste0("./export/",fileName,".pdf"))
}
# 計算 20日和60日均線
#ma20_ASML<-runMean(ASML[,4],n=20)
#ma60_ASML<-runMean(ASML[,4],n=60)
#ma20_VOO<-runMean(VOO[,4],n=20)
#ma60_VOO<-runMean(VOO[,4],n=60)
#ma20_VWO<-runMean(VWO[,4],n=20)
#ma60_VWO<-runMean(VWO[,4],n=60)
# head(ma20, 25)

# 畫上線
#chartSeries(ASML["2017-01-03::2021-01-30",], theme = "white")
#addTA(ma20_ASML,on=1,col="blue")
#addTA(ma60_ASML,on=1,col="red")

#fileName<-paste(c("ASML", expDate),collapse="-")
#saveChart("pdf",file=paste0("export/",fileName,".pdf"))
#chartSeries(VOO["2017-01-03::2021-01-30",], theme = "white")
#addTA(ma20_VOO,on=1,col="blue")
#addTA(ma60_VOO,on=1,col="red")
#fileName<-paste(c("VOO", expDate),collapse="-")
#saveChart("pdf",file=paste0("export/",fileName,".pdf"))
#chartSeries(VWO["2017-01-03::2021-01-30",], theme = "white")
#addTA(ma20_VWO,on=1,col="blue")
#addTA(ma60_VWO,on=1,col="red")
#fileName<-paste(c("VWO", expDate),collapse="-")
#saveChart("pdf",file=paste0("export/",fileName,".pdf"))
