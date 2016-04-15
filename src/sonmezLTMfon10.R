
# this file is for replicating the study in the fon paper
# it needs data which is not part of the distribution,
# therefore everything is commented out

# ########################################
# qqcor<-function(data)cor(data, qqnorm(data, plot.it=F)$x)
# ########################################

# options(warn=-1)

# source("getF0.R")
# source("robust.R")
# source("bestLTMparams.R")
# source("getGuess.R")

# logOf2<-log(2)

# f0<-getF0()
# d<-density(f0); dx<-d$x; dy<-d$y
# ld<-density(log(f0)); ldx<-ld$x; ldy<-ld$y
# lloc<-mest(log(f0))
# lsca<-bivar(log(f0))^.5
# gg<-getGuess(ldx, ldy)
# LTM<-bestLTMparams(dx, dy, lloc, lsca, gg)
# #LTM<-bestLTM(dx, dy, lloc, lsca)
# if (is.null(LTM$LTM)) {
    # print("No model")
    # q()
# }
# #LTM<-nls(dy~a*dlnorm(dx,m1,s1)+b*dlnorm(dx,m1-logOf2,s1)+(1-a-b)*dlnorm(dx,m1+logOf2,s1), start=list(a=1, b=1, m1=lloc, s1=lsca), control=list(maxiter=100,warnOnly=T))
# sLTM<-summary(LTM$LTM)
# a<-sLTM$coefficients['a', 'Estimate']
# b<-sLTM$coefficients['b', 'Estimate']
# m1<-sLTM$coefficients['m1', 'Estimate']
# s1<-sLTM$coefficients['s1', 'Estimate']

# #LTMlsg<-nls(dy~a*lsg(dx, m1, s1, s2, max(dy))+b*lsg(dx, m1-logOf2, s1, s2, max(dy))+(1-a-b)*lsg(dx, m1+logOf2, s1, s2, max(dy)), start=list(a=1, b=1, m1=lloc, s1=lsca/2, s2=lsca/2))
# #sLTMlsg<-summary(LTMlsg)
# #la<-sLTMlsg$coefficients['a', 'Estimate']
# #lb<-sLTMlsg$coefficients['b', 'Estimate']
# #lm1<-sLTMlsg$coefficients['m1', 'Estimate']
# #ls1<-sLTMlsg$coefficients['s1', 'Estimate']
# #ls2<-sLTMlsg$coefficients['s2', 'Estimate']

# #truncAt<-c(floor(0.75*qlnorm(0.25, m1, s1)), ceiling(1.5*qlnorm(0.75, m1, s1)))
# truncAt<-rbind(c(floor(0.75*qlnorm(0.25, m1, s1)), ceiling(1.5*qlnorm(0.75, m1, s1))), c(floor(0.75*qlnorm(0.25, lloc, lsca)), ceiling(1.5*qlnorm(0.75, lloc, lsca))), c(floor(0.75*quantile(f0, 0.25)), ceiling(1.5*quantile(f0, 0.75))))
# locSca<-sprintf("Fit: %.f (%.f - %.f)  Rob: %.f (%.f - %.f) Trunc: %.f %.f", exp(m1), exp(m1-s1), exp(m1+s1), exp(lloc), exp(lloc-lsca), exp(lloc+lsca), truncAt[1,1], truncAt[1,2])
# #print(locSca)
# #print(paste(exp(gg$g1$maxx), exp(gg$g2$maxx)))
# #print(paste(floor(0.75*qlnorm(0.25, lloc, lsca)), ceiling(1.5*qlnorm(0.75, lloc, lsca))))

# xr<-c(minPitch, maxPitch)
# yr<-range(dy)

# inFileBasename<-basename(inFile)

# inFileBasenameWoExt<-sub("(.+)[.][^.]+$", "\\1", inFileBasename)
# newName<-paste("/media/LACIE/databases/swedia/public/png/", inFileBasenameWoExt, ".png", sep="")
# #newName<-paste("/media/LACIE/databases/timit_by_speaker/png/", inFileBasenameWoExt, ".png", sep="")
# #print(newName)

# newName<-'here.png'
# png(newName, width=3, height=3, units="in", pointsize=8, res=300)

# rmat<-cbind(dy, predict(LTM$LTM), dlnorm(dx, lloc, lsca), dlnorm(dx, mean(log(f0)), sd(log(f0))))
# colSeq=c("black")
# colSeq=1:4
# matplot(dx, rmat, type="l", col=colSeq, lty=1:4, lwd=2, xlim=xr, ylim=yr, main="", ylab="dy", xlab="Hz")
# legend("topright", c("dy", "DF", "lRob", "lAri"), col=colSeq, lty=1:4, lwd=2, inset=.02)

# #plot(d, xlim=xr, ylim=yr, main=locSca, sub=inFileBasenameWoExt); par(new=T)
# #plot(dx, predict(LTM$LTM), type="l", xlim=xr, ylim=yr, col="red", ylab=""); par(new=T)
# #plot(function(x)a*dlnorm(x, m1, s1)+b*dlnorm(x, m1-logOf2, s1)+(1-a-b)*dlnorm(x, m1+logOf2, s1),xlim=xr, ylim=yr, col="red", ylab=""); par(new=T)
# #plot(function(x)dnorm(x, mest(f0), bivar(f0)^.5), xlim=xr, ylim=yr, col="light green", ylab=""); par(new=T)
# #plot(function(x)dlnorm(x, lloc, lsca), xlim=xr, ylim=yr, col="green", ylab=""); par(new=T)
# #plot(function(x)dnorm(x, mean(f0), sd(f0)), xlim=xr, ylim=yr, col="grey", ylab=""); par(new=T)
# #plot(function(x)dlnorm(x, mean(log(f0)), sd(log(f0))), xlim=xr, ylim=yr, col="grey", ylab=""); par(new=T)
# abline(v=truncAt, lty=2:4, col=2:4)
# #plot(function(x)la*lsg(x, lm1, ls1, ls2, max(dy))+lb*lsg(x, lm1-logOf2, ls1, ls2, max(dy))+(1-la-lb)*lsg(x, lm1+logOf2, ls1, ls2, max(dy)), xlim=xr, ylim=yr, col="blue")

# dev.off()

# f0.df<-log(f0[f0>=truncAt[1,1] & f0<=truncAt[1,2]])
# f0.ro<-log(f0[f0>=truncAt[2,1] & f0<=truncAt[2,2]])
# f0.ar<-log(f0[f0>=truncAt[3,1] & f0<=truncAt[3,2]])

# qq<-cbind(qqcor(f0.df),qqcor(f0.ro),qqcor(f0.ar))

# values<-c(as.vector(t(truncAt)), qq)
# #cat(inFileBasenameWoExt, values, "\n", file="truncAt-swedia.txt", append=T)
# cat(inFileBasenameWoExt, values, "\n", file="truncAt-timit.txt", append=T)

