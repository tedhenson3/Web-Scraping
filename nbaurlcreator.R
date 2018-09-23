
thing <- "https://www.basketball-reference.com/teams"

nbaurlcreator <- function(thing){
  
allteams <- list()

nba <- list("GSW", "TOR", "BOS", "PHI", "NYK", "NYN", "NJN", "BRK", "POR", "NOJ", "SEA", "OKC", "DEN", "MIN", "DNA", "CLE", "IND", "MIL", "DET", "CHI", "LAC", "BUF", "SDC", "LAL", "KCK", "KCO", "SAC", "PHO", "MIA", "WAS", "CAP", "WSB", "CHA", "CHO", "HOU", "ATL", "NOP", "NOH", "NOK", "SAS", "DAL", "MEM", "VAN")

    for(i in 1:length(nba)){
      team <- nba[i]
      print(100*(i/length(nba)))
    for(x in c(2000:2017)){
      
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


