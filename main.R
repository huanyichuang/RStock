# 參考文章
# https://blog.alantsai.net/posts/2018/01/data-science-series-16-r-hello-world-with-stock-analysis-using-quantmod
library("quantmod")

mySymbols<-c("ASML","VOO","VWO","TSM","NFLX","VEA")
getSymbols(mySymbols)
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