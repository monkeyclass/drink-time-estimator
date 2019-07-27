drink.time <- function(d, p, s){
  if(!(s==1)){
    d$par <-as.factor(rep(1:p, each =1, len=nrow(d)))
  }  else{
    d = d[-1,]
    d$par <-as.factor(rep(1:p, each =1, len=nrow(d)))

  }
  return(data.frame(d %>% 
    group_by(Paticipant=par) %>%
    summarise(Seconds=sum(duration))
  )
  )
}
