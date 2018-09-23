
thing <- "https://www.sports-reference.com/cbb/schools"

cbburlcreator <- function(thing){
  
  allteams <- list()
  
  nba <- list("miami-fl")
  for(i in 1:length(nba)){
    team <- nba[i]
    print(100*(i/length(nba)))
    for(x in c(1996:2018)){
      
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


