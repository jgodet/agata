# plotNof1sequence.r
# written by JuG
# August 05 2019


#' Plot N-of-1 sequence for a given patient
#' @author JuG
#' @description 
#' @param 
#' @details 
#' @examples 
#'
#'
#' @return 
#' @export



plotNof1sequence <- function(time, value, sequence,numSeq, rectYpos = 0, rectHeight = 5,  ...){
  
  numSeqRle <- rle(numSeq)
  labelsSeq <- aggregate(sequence~ as.factor(numSeq), FUN = unique)[,2]
  startRect <- cumsum(x =   numSeqRle$lengths)
  startRect <- c(0, startRect)
  midsRect <- startRect[-length(startRect)] + (startRect[-1] - startRect[-length(startRect)]) / 2
  
  plot(time, value, type='b',...)
  for (i in 2:length(startRect)){
    rect(xleft = startRect[i-1] + .5, ybottom = 0 + rectYpos, xright = startRect[i]+.5, ytop = 0 + rectYpos + rectHeight,... )
  }
  abline(v = startRect +.5, lty=2)
  text(x = midsRect +.5,y= 0 + rectYpos + rectHeight/2 ,labelsSeq)
}
