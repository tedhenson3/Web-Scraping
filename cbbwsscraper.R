

setwd("C:/Users/tedhe/Onedrive/Documents/analytics")
thing <- c("https://www.sports-reference.com/cbb/schools/north-carolina/2016.html")



vorpscraper <- function(url){
  
  
  
  url <- readLines(url)

  recordline <- grep('Overall', url)
  record <- strsplit(url[recordline], '> ', fixed = TRUE)

  record <- record[[1]][2]
  record <- strsplit(record, '-', fixed = TRUE)
  record <- record[[1]][1:2]
  wins <- as.numeric(record[[1]][1])
  losses <- record[2]
  losses <- strsplit(losses, ' ', fixed =T)
  losses <- as.numeric(losses[[1]][1])
  winpct <- wins / (wins + losses)
  vorpstart <- grep('data-stat="ws"', url)
  
  vorpend<- grep('Conference Per Game', url)
  if(length(vorpend) != 0){
    
  vorpend <- vorpend[1]
}
  
  if(length(vorpend) == 0){
    
    vorpend <- vorpstart[length(vorpstart)]
  }
  
  

  
  
  vorp <- url[vorpstart[2]:vorpend]
  players <- grep('data-stat="ws" >', vorp)
  
  vorp <- vorp[players[1]:players[length(players)]]
  vorp <- strsplit(vorp, 'data-stat="ws" >')
  data <- data.frame(ws = c(0))
  for(i in c(1:length(vorp))){
    
    ws <- vorp[[i]][2]
    ws <- strsplit(ws, "<", fixed = TRUE)
    ws <- as.numeric(ws[[1]][1])
    data[i, "ws"] <- ws
    
  }
  TotalWS <- sum(data$ws)
  
  alldata <- data.frame(TotalWS = TotalWS, WinPct = winpct)
  return(alldata)
}
vorpscraper(thing)