set <- c("https://www.hockey-reference.com/teams/BOS/2018.html")



nhlscraper <- function(url){
  
lines <- readLines(url)

gps <- grep('data-stat="gps" >', lines, fixed = T)
gps <- lines[gps[length(gps)]]
gps <- strsplit(gps[1], 'data-stat="gps" >' )
gps <- strsplit(gps[[1]][2], '</', fixed = TRUE)
gps <- as.numeric(gps[[1]][1])


skaterpointshares <- grep('data-stat="ps" >', lines, fixed = T)
skaterpointshares <- lines[skaterpointshares[1]:skaterpointshares[length(skaterpointshares)]]
skaterpointshares <- strsplit(skaterpointshares, 'data-stat="ps" >')
sps <- skaterpointshares[[length(skaterpointshares)]][2]
sps <- strsplit(sps, '<')
sps <- as.numeric(sps[[1]][1])

recordline <- grep("Record:", lines)
record <- lines[recordline]
record <- strsplit(record, "Record:</strong> ")
record <- record[[1]][2]
record <- strsplit(record, "(", fixed = T)
winpct <- record[[1]][1]
winpct <- strsplit(winpct, '-', fixed = T)
wins <- as.numeric(winpct[[1]][1])
losses <- as.numeric(winpct[[1]][2])
winpct <- wins / (wins + losses)

points <- strsplit(record[[1]][2], 'points')
points <- as.numeric(points[[1]][1])
# 
# 
# EPMlines <- grep('data-stat="expected_plsmns"', lines, fixed = T)
# 
# EPMlines <- lines[EPMlines[1]:EPMlines[length(EPMlines)]]
# 
# 
# 
# players <- grep('data-stat="expected_plsmns" >', EPMlines)
# EPM <- EPMlines[players[1]:players[length(players)]]
# EPM <- strsplit(EPM, 'data-stat="expected_plsmns" >')
# 
# data <- data.frame(EPM = c(0), Corsi = c(0))
# 
# for(i in c(1:length(EPM))){
#   value <- EPM[[i]][2]
#   corsi <- EPM[[i]][1]
#   corsi <- strsplit(corsi, 'data-stat="corsi_pct" >')
#   corsi <- corsi[[1]][2]
#   corsi <- strsplit(corsi, '<')
#   corsi <- as.numeric(corsi[[1]][1])
#   value <- strsplit(value, "</td")
#   value <- value[[1]][1]
#   EPMvalue <- as.numeric(value)
#   data[i, "EPM"] <- EPMvalue
#   data[i, "corsi"] <- corsi
# }
# 
# 
# 
# TotalEPM <- sum(data$EPM)
# Totalcorsi <- mean(data$corsi)


alldata <- data.frame(WinPCT = winpct, GPS = gps, Points = points, SPS = sps, TPS = (sps+gps))
return(alldata)
}

bet <- nhlscraper(set)

