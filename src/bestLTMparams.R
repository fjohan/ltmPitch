
source("bestLTM.R")

bestLTMparams<-function(dx, dy, lloc, lsca, gg) {
    LTM.rob<-bestLTM(dx, dy, lloc, lsca)
    LTM.g1<-bestLTM(dx, dy, gg$g1$maxx, gg$g1$hwhm)
    LTM.g2<-bestLTM(dx, dy, gg$g2$maxx, gg$g2$hwhm)

    g0<-LTM.rob$RSS
    g1<-LTM.g1$RSS
    g2<-LTM.g2$RSS

    if (g1 != 1) {
        g1.m1<-exp(summary(LTM.g1$LTM)$coefficients['m1', 'Estimate'])
        if (g1.m1 < exp(lloc-0.9*lsca) || g1.m1 > exp(lloc+0.9*lsca)) g1<-1
        if (g1.m1 < 120 || g1.m1 > 375) g1<-1
    }

    if (g2 != 1) {
        g2.m1<-exp(summary(LTM.g2$LTM)$coefficients['m1', 'Estimate'])
        if (g2.m1 < exp(lloc-0.9*lsca) || g2.m1 > exp(lloc+0.9*lsca)) g2<-1
        if (g2.m1 < 120 || g2.m1 > 375) g2<-1
    }

    if (g0 == 1 && g1 == 1 && g2 == 1) {
        return(list(LTM=NULL, algorithm="none", params="none", RSS=1))
    }

    if (g0 <= g1) {
        if (g0 <= g2) {
            return(list(LTM=LTM.rob$LTM, algorithm=LTM.rob$algorithm, params="rob", RSS=g0))
        } else {
            return(list(LTM=LTM.g2$LTM, algorithm=LTM.g2$algorithm, params="g2", RSS=g2))
        }
    } else {
        if (g1 <= g2) {
            return(list(LTM=LTM.g1$LTM, algorithm=LTM.g1$algorithm, params="g1", RSS=g1))
        } else {
            return(list(LTM=LTM.g2$LTM, algorithm=LTM.g2$algorithm, params="g2", RSS=g2))
        }
    }
}
