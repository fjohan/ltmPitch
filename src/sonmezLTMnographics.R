
# You may need to change this!
praatexec<-paste("\"","C:/Program Files/Praat/praat","\"",sep='')

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
    cat(cbind(basename(inFile), NA, NA, NA, NA, LTM$RSS, LTM$params, LTM$algorithm), "\n")
    q()
}
sLTM<-summary(LTM$LTM)
a<-sLTM$coefficients['a', 'Estimate']
b<-sLTM$coefficients['b', 'Estimate']
m1<-sLTM$coefficients['m1', 'Estimate']
s1<-sLTM$coefficients['s1', 'Estimate']

cat(floor(0.75*qlnorm(0.25, m1, s1)), ceiling(1.5*qlnorm(0.75, m1, s1)), file="_tmp_ltmFloorCeiling.txt")

# with this format we may read it in thusly:
# a<-read.table(fileName, row.names=1)

# the next step is to perform a pitch re-analysis and get intensity deltas and get it frame synchronised 

