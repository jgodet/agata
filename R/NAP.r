# NAP.r
# written by JuG
# March 04 2020


#' Compute NAP
#' @author JuG
#' @description 
#' @param data dataframe
#' @param phase phase to analyse
#' @param base_phase phase used as baseline
#' @param increase boolean 
#' @details 
#' @examples 
#' #zxzmple from PArker et al. 2009
#' A <- c(4, 3, 4, 3, 4, 7, 5, 2, 3, 2)
#' B <- c(5, 9, 7,9, 7, 5, 9, 11, 11, 10, 9)
#' dtf <- c(A,B)
#' phase <- c(rep("A", length(A)), rep("B", length(B)))
#' 
#' NAP(data=dtf, phase=phase, base_phase="A")
#' NAP(data=dtf, phase=phase, base_phase="A",boot=T,NbIter = 2000)
#' @return 
#' @export


NAP <- function(data, phase, base_phase, increase = TRUE, boot = FALSE, NbIter = 1000, ...) {
  daten <- data
  if (!increase) data <- -1 * data
  XY <- expand.grid(x = data[phase==base_phase], y = data[phase!=base_phase])
  if(!boot){
    return(100 * mean(with(XY, (y > x) + 0.5 * (y == x)), na.rm=T))
  }
  
  if(boot){
    library(boot)
    
    NAP.boot <- function(daten,x) {
      daten <- daten[x]
      phase <- phase[x]
      if (!increase) daten <- -1 * daten
      XY <- expand.grid(x = daten[phase==base_phase], y = daten[phase!=base_phase])
      return(100 * mean(with(XY, (y > x) + 0.5 * (y == x)), na.rm=T))
    }
    
    res <- boot(data=daten,NAP.boot,R = NbIter)
    #summary(res$t) 
    # verifier  la gestion des manquants
    res$t <- na.omit(res$t)
    res$R <- length(res$t)
    
    quantile(res$t,c(0.025,0.975), na.rm = TRUE)   # two-sided bootstrapped confidence interval of kappa
    boot.ci(res,type="bca")  
    return(list(NAP = 100 * mean(with(XY, (y > x) + 0.5 * (y == x)), na.rm=T),
                Quantile = quantile(res$t,c(0.025,0.975)),
                BCA =suppressWarnings(boot.ci(res,type="bca")$bca[1,4:5])
                )
    )
  }
  
}

