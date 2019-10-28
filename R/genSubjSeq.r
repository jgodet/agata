# genSubjSeq.r
# written by JuG
# August 05 2019


#' generate simulated data for SubjSeq
#' @author JuG
#' @description 
#' @param lambda 
#' @param sdLambda
#' @param N total number of measures
#' @details 
#' @examples 
#' lambda <- data.frame(Base = 10, A = 30, B = 20)
#' sdlambda <- data.frame(Base = 3, A = 5, B = 5)
#' N = 50 #nb repet
#' genSubjSeq(lambda = lambda, sdLambda = sdLambda ,N = 50)
#'
#' @return 
#' @export


genSubjSeq <- function(lambda, sdLambda, N){
  #choix une sequence
  if(!require(stringi)){install.packages('stringi')}
  listSeq <- sort(unique(replicate(1000, stringi::stri_rand_shuffle("ABAB"))))
  choixSeq <- sample(x = listSeq, size = 1)
  
  
  
  #plan individuel
  baseSeq <- rep("Base",sample(size = 1,3:18))
  nPhaseBase <- length(baseSeq)
  nleft <- N - nPhaseBase
  baseval <- rnorm(nPhaseBase,mean = lambda["Base"][[1]], sd = sdlambda["Base"][[1]] ) 
  #baseval <- rnorm(n = 1, mean  = lambda["Base"][[1]], sd = sdlambda["Base"][[1]]) + c(arima.sim(model=list(ar=ar.val), n=nPhaseBase))
  
  labelPhase1 <- substr(x = choixSeq,start = 1,stop = 1)
  phase1Seq <- rep(labelPhase1,sample(size = 1,3:18))
  nPhase1 <- length(phase1Seq)
  phase1val <- rnorm(nPhase1,mean = lambda[labelPhase1][[1]], sd = sdlambda[labelPhase1][[1]] ) 
  #phase1val <- rnorm(1,mean = lambda[labelPhase1][[1]], sd = sdlambda[labelPhase1][[1]] ) + c(arima.sim(model=list(ar=ar.val), n=nPhase1))
  nleft <- nleft - nPhase1
  
  
  #est-ce que les temps totaux A et B doivent être les mêmes
  labelPhase2 <- substr(x = choixSeq,start = 2,stop = 2)
  phase2Seq <- rep(labelPhase2,sample(size = 1,3:18))
  nPhase2 <- length(phase2Seq)
  phase2val <- rnorm(nPhase2,mean = lambda[labelPhase2][[1]], sd = sdlambda[labelPhase2][[1]] ) 
  nleft <- nleft - nPhase2
  
  labelPhase3 <- substr(x = choixSeq,start = 3,stop = 3)
  phase3Seq <- rep(labelPhase3,sample(size = 1,3:18))
  nPhase3 <- length(phase3Seq)
  phase3val <- rnorm(nPhase3,mean = lambda[labelPhase3][[1]], sd = sdlambda[labelPhase3][[1]] ) 
  nleft <- nleft - nPhase3  
  
  labelPhase4 <- substr(x = choixSeq,start = 4,stop = 4)
  phase4Seq <- rep(labelPhase4,nleft)
  nPhase4 <- length(phase4Seq)
  phase4val <- rnorm(nPhase4,mean = lambda[labelPhase4][[1]], sd = sdlambda[labelPhase4][[1]] ) 
  nleft <- nleft  - length(phase4Seq)
  
  
  compSeq <- c(baseSeq,phase1Seq,phase2Seq,phase3Seq,phase4Seq )
  numSeq <- c(rep(0:4, c(length(baseSeq),length(phase1Seq),length(phase2Seq),length(phase3Seq),length(phase4Seq))))
  valSeq <- c(baseval,phase1val,phase2val,phase3val,phase4val )
  
  return(list(compSeq, numSeq, valSeq))
}
