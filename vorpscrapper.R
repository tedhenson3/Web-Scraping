

idk <- c("https://www.basketball-reference.com/teams/GSW/2018.html")
setwd("C:/Users/tedhe/Onedrive/Documents/analytics")


vorpscraper <- function(url){



url <- readLines(url)

recordline <- grep('Record:</strong', url)
record <- strsplit(url[recordline], ',')
record <- record[[1]][1]
record <- strsplit(record, ' ')

record <- record[[1]][length(record[[1]])]
record <- strsplit(record, '-')
wins <- as.numeric(record[[1]][1])
losses <- as.numeric(record[[1]][2])
winpct <- wins / (wins + losses)



vorpstart <- grep('data-stat="vorp"', url)

vorpend<- grep('<div id="all_shooting"', url)

if(length(vorpend) == 0){
  
vorpend <- grep('<div id="all_playoffs_totals"', url)
}

if(length(vorpend) == 0){
  
  vorpend[1] <- vorpstart[length(vorpstart)]
}



vorp <- url[vorpstart[1]:vorpend[1]]
players <- grep('data-stat="vorp" >', vorp)

vorp <- vorp[players[1]:players[length(players)]]
vorp <- strsplit(vorp, 'data-stat="vorp" >')
data <- data.frame(WARTotal = c(0), BPMTotal = c(0), tedstat = c(0), PERTotal = c(0), ws = c(0))
for(i in c(1:length(vorp))){
  
  stats <- vorp[[i]][1]
  ws <- strsplit(stats, 'data-stat="ws" >')
  ws <- strsplit(ws[[1]][2], "<", fixed = TRUE)
  ws <- as.numeric(ws[[1]][1])
  bpm <- paste(stats[[1]][1], stats[[1]][2], "")
  bpm <- strsplit(bpm, 'data-stat="bpm" >')
  mp <- strsplit(bpm[[1]][1], '"mp\" >', fixed = TRUE)
  mpsplit <- strsplit(mp[[1]][2], '<')
  minutesplayed <- mpsplit[[1]][1]
  per <- paste(mpsplit[[1]][2], mpsplit[[1]][3:length(mpsplit[[1]])], collapse = '')
  per <- strsplit(per[1], 'per\" >')
  per <- per[[1]][2]
  per <- strsplit(per, '/td>')
  per <- per[[1]][1]
  if(per == ''){
    print('this one')
    per <- 0
  }
  tedstat <- as.numeric(per)*as.numeric(minutesplayed)
  bpm <- bpm[[1]][2]
  bpmsplit <- strsplit(bpm, '<')
  bpm <- bpmsplit[[1]][1]
  value <- vorp[[i]][2]
  value <- strsplit(value, "</td")
  value <- value[[1]][1]
  data[i, "ws"] <- ws
  data[i, "tedstat"] <- tedstat
  data[i, "WARTotal"] <- 2.7 * as.numeric(value)
  data[i, "BPMTotal"] <- as.numeric(bpm)
  data[i, "PERTotal"] <- as.numeric(per)

}
TotalWAR <- sum(data$WARTotal)
TotalBPM<- sum(data$BPMTotal)
totalted <- sum(data$tedstat)
totalper <- sum(data$PERTotal)
TotalWS <- sum(data$ws)

alldata <- data.frame(TotalWS = TotalWS, TeamWAR = TotalWAR, WinPct = winpct, TotalBPM = TotalBPM, TedStat = totalted, PERTotal = totalper)
return(alldata)
}
vorpscraper(set)