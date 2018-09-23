set <- c("https://www.basketball-reference.com/teams/GSW/1974.html")








linkcreator <- function(link){
  

  
link <- gsub("//", "!", link)
link <- gsub("/", "!", link)
link <- strsplit(link, "!")

year <- link[[1]][length(link[[1]])]
year <- strsplit(year, ".html")
year <- as.numeric(year[[1]][1])


data <- data.frame(urls = c(0))
for(i in c(1974:2017)){
  newyear <- paste(i, ".html", sep = "")
  link[[1]][length(link[[1]])] <- newyear
  newurl <- paste(link[[1]], collapse = '')
  data[i-1973, "urls"] <- newurl
}


urllist <- list()
for(i in 1:nrow(data)){
url <- data[i, "urls"]
url <- gsub(":", "://", url)
url <- gsub(".com", ".com/", url)
url <- gsub("teams", "teams/", url)
urlsplit <- strsplit(url, "/")
spot <- urlsplit[[1]][5]
eachchar <- strsplit(spot, "")
team <- paste(eachchar[[1]][1:3], collapse = "")
teamslash <- paste(team, "/", sep = "")
idk <- paste(eachchar[[1]][4:length(eachchar[[1]])], "", collapse = "")
yearandhtml <- paste(teamslash, idk, sep = "")
yearandhtml <- gsub(" ", "", yearandhtml)

urlsplit[[1]][1] <- paste(urlsplit[[1]][1], "/", sep = "")
urlsplit[[1]][2] <- paste(urlsplit[[1]][2], "/", sep = "")
urlsplit[[1]][3] <- paste(urlsplit[[1]][3], "/", sep = "")
urlsplit[[1]][4] <- paste(urlsplit[[1]][4], "/", sep = "")
firsthalfurl <- paste(urlsplit[[1]][1], urlsplit[[1]][2], urlsplit[[1]][3], urlsplit[[1]][4])
totalurl <- paste(firsthalfurl, yearandhtml, collapse = "")
totalurl <- gsub(" ", "", totalurl)

urllist <- append(totalurl, urllist)
}
return(urllist)
}
linkcreator(set)