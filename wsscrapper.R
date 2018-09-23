
setwd("C:/Users/tedhe/Onedrive/Documents/analytics")

set <- c("https://www.basketball-reference.com/teams/PHW/1947.html")

wsscraper <- function(url){


url <- readLines(url)

wsstart <- grep('data-stat="ws"', url)

wsendold <- grep('<div id="all_playoffs_totals"', url)

wsendnew <- grep('<div id="all_shooting"', url)


if(length(wsendold) != 0){
ws <- url[wsstart[1]:wsendold[1]]
players <- grep('data-stat="ws" >', ws)

ws <- ws[players[1]:players[length(players)]]
ws <- strsplit(ws, 'data-stat="ws" >')
ws
for(i in c(1:length(ws))){
  print(i)
  
}

}

#if(length(wsendnew) != 0){
#ws <- url[wsstart[1]:wsendold[1]]
#players <- grep('data-stat="ws" >', ws)
#}


}
wsscraper(set)