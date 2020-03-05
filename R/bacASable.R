# install.packages('rjags')
# install.packages('runjags')
# install.packages('prettyR')
# require(rjags)
# require(runjags)
# require(prettyR)
# 
# setwd("/Users/jgodet/Documents/tempGit/agata/data")
# 
# Y <- as.matrix(read.csv2('baselineData.csv', header=F)) #Load data file
# Y <- Y[1:5,]
# I <- nrow(Y) #Number of tiers
# T <- ncol(Y)
# ymax <- max(Y, na.rm = T) #maxima of the input values, missing values removed #plot the data
# y1 <- as.numeric(Y[1,])
# y2 <- as.numeric(Y[2,])
# y3 <- as.numeric(Y[3,])
# y4 <- as.numeric(Y[4,])
# y5 <- as.numeric(Y[5,])
# 
# par(mfrow=c(5,1)) #Place graphs on the page in 3 rows and 1 column par(mar=c(2.5, 4.5, 2, 1)) #Change the margins of the actual graphs
# #plot the 1st tier
# plot(y1, type="o", bty="l", pch=16, ylim=c(0,ymax), ylab="", cex.lab=1.5) 
# abline(v=6.5, lty=3)
# mtext("Baseline", side=3, line=0, outer=F, adj=0, cex=0.9)
# mtext("TGC Intervention", side=3, line=0, outer=F, adj=0.33, cex=0.9)
# text(27, 8, "Deborah's Group")
# #Add the 2nd tier
# points(y2, type="o", bty="l", pch=16, ylim=c(0,ymax), ylab="with Problem Behavior",
#      cex.lab=1.2, col='blue') 
# abline(v=10.5, lty=3)
# text(27, 8, "Amy's Group")
# #Add the 3rd tier
# plot(y3, type="o", bty="l", pch=16, ylim=c(0,ymax), ylab="Intervals Scored", cex.lab=1.2) abline(v=15.5, lty=3)
# text(27, 50, "Barbara's Group")
# #Add the 4th tier
# plot(y4, type="o", bty="l", pch=16, ylim=c(0,ymax), ylab="Percent of 10-Second",
#      cex.lab=1.2) abline(v=19.5, lty=3)
# text(27, 50, "Natasha's Group")
# #Add the 5th tier
# plot(y5, type="o", bty="l", pch=16, ylim=c(0,ymax), ylab="", cex.lab=1.5) abline(v=19.5, lty=3)
# text(27, 50, "Candice's Group")
# #run the analysis
# runjags.object <- autorun.jags(model,
#                                monitor = c("slope1", "slope2", "int1", "int2", "dslope", "dint",
#                                            "knot", "rho", "sigma"),
#                                n.chains=4, startburnin = 2500, startsample = 4000, thin.sample = FALSE, thin = 1)
# 
# 
# 
# #mode for the change-point
# runjags.object #Output Summary 
# knot1.est <- as.mcmc.list(runjags.object,vars="knot[1]")
# knot1.est <- as.matrix(knot1.est)
# knot1.mode <- Mode(knot1.est)
# 
# 
# plot(runjags.object, type="trace", layout=c(8,3)) 
# plot(runjags.object, type="density", layout=c(8,3))
# 
# 
# 
# 
# 
# 
