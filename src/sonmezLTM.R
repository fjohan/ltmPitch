
# run as:
# Rscript sonmezLTM.R low_pitch high_pitch analyze_pitch wavfile.wav
# e.g.
# Rscript sonmezLTM.R 60 750 1 wavfile.wav

# You may need to change this!
#praatexec<-paste("\"","C:/Program Files/Praat/praat","\"",sep='')
praatexec<-"praat"

options(warn=-1)

source("getF0.R")
source("robust.R")
source("bestLTMparams.R")
source("getGuess.R")

logOf2<-log(2)

f0<-getF0()
d<-density(f0); dx<-d$x; dy<-d$y
ld<-density(log(f0)); ldx<-ld$x; ldy<-ld$y
lloc<-mest(log(f0))
lsca<-bivar(log(f0))^.5
gg<-getGuess(ldx, ldy)
LTM<-bestLTMparams(dx, dy, lloc, lsca, gg)
if (is.null(LTM$LTM)) {
    print("No model")
    q()
}
sLTM<-summary(LTM$LTM)
a<-sLTM$coefficients['a', 'Estimate']
b<-sLTM$coefficients['b', 'Estimate']
m1<-sLTM$coefficients['m1', 'Estimate']
s1<-sLTM$coefficients['s1', 'Estimate']

truncAt<-rbind(c(floor(0.75*qlnorm(0.25, m1, s1)), ceiling(1.5*qlnorm(0.75, m1, s1))), c(floor(0.75*qlnorm(0.25, lloc, lsca)), ceiling(1.5*qlnorm(0.75, lloc, lsca))), c(floor(0.75*quantile(f0, 0.25)), ceiling(1.5*quantile(f0, 0.75))))
locSca<-sprintf("Fit: %.f (%.f - %.f)  Rob: %.f (%.f - %.f) Trunc: %.f %.f", exp(m1), exp(m1-s1), exp(m1+s1), exp(lloc), exp(lloc-lsca), exp(lloc+lsca), truncAt[1,1], truncAt[1,2])

xr<-c(minPitch, maxPitch)
yr<-range(dy)

inFileWoExt<-sub("(.+)[.][^.]+$", "\\1", inFile)
newName<-paste(inFileWoExt, ".png", sep="")

#png(newName, width=3, height=3, units="in", pointsize=8, res=300)
png(newName, 720)

rmat<-cbind(dy, predict(LTM$LTM), dnorm(dx, mest(f0), bivar(f0)^.5), dlnorm(dx, lloc, lsca), dnorm(dx, mean(f0), sd(f0)), dlnorm(dx, mean(log(f0)), sd(log(f0))))
colSeq=c("black", "red", "light green", "green", "light grey", "grey")
matplot(dx, rmat, type="l", col=colSeq, lty=c(1,1,2,3,2,3), lwd=c(2,2,1,1,1,1), xlim=xr, ylim=yr, main=locSca, sub=inFileWoExt, ylab="dy", xlab="Hz")
legend("topright", c("dy", "Fit", "Rob", "lRob", "Ari", "lAri"), col=colSeq, lty=c(1,1,2,3,2,3), lwd=c(2,2,1,1,1,1), inset=.02)

abline(v=truncAt, lty=1:3, col=c("red", "green", "grey"))

invisible(dev.off())

values<-as.vector(t(truncAt))
cat(inFileWoExt, as.vector(t(truncAt)), "\n", file=paste(inFileWoExt, ".txt", sep=""), append=T)

