
thing <- "https://www.hockey-reference.com/team"

nhlurlcreator <- function(thing){
  
  allteams <- list()
  
  nhlteams <- list("TBL", "BOS", "TOR", "FLA", "DET", "MTL", "OTT", "BUF", "WSH", "PIT", "CBJ", "PHI", "NJD", "CAR", "NYI", "NYR", "NSH", "WPG", "MIN", "COL", "STL", "DAL", "CHI", "VEG", "ANA", "SJS", "LAK", "CGY", "EDM", "VAN", "PHX")

  for(i in 1:length(nhlteams)){
    team <- nhlteams[i]
    print(100*(i/length(nhlteams)))
    for(x in c(1980:2017)){
      
      urltry <- paste(thing,"/",  team , "/",  x, ".html", sep = '')
      link <- try(readLines(urltry))
      if(class(link) == "try-error"){
      }
      else{
        allteams <- append(urltry, allteams)
      }
      
    }
  }
  return(allteams)
}


