
bestLTM<-function(dx, dy, lloc, lsca) {
    sdy<-1
    LTM.def<-NULL

    LTM.pli<-NULL
    try(LTM.pli<-nls(dy~a*dlnorm(dx,m1,s1)+b*dlnorm(dx,m1-logOf2,s1)+(sdy-a-b)*dlnorm(dx,m1+logOf2,s1), start=list(a=sdy, b=sdy, m1=lloc, s1=lsca), control=list(maxiter=100,warnOnly=T), algorithm="plinear"))

    LTM.port<-NULL
    try(LTM.port<-nls(dy~a*dlnorm(dx,m1,s1)+b*dlnorm(dx,m1-logOf2,s1)+(sdy-a-b)*dlnorm(dx,m1+logOf2,s1), start=list(a=sdy, b=sdy, m1=lloc, s1=lsca), control=list(maxiter=100,warnOnly=T), algorithm="port"))

    if (!is.null(LTM.def)) {RSS.def<-sum(residuals(LTM.def)^2)} else {RSS.def<-1}
    if (!is.null(LTM.pli)) {RSS.pli<-sum(residuals(LTM.pli)^2)} else {RSS.pli<-1}
    if (!is.null(LTM.port)) {RSS.port<-sum(residuals(LTM.port)^2)} else {RSS.port<-1}

    if (RSS.def == 1 && RSS.pli == 1 && RSS.port == 1) {
        return(list(LTM=NULL, algorithm="none", RSS=1))
    }
    if (RSS.def <= RSS.pli) {
        if (RSS.def <= RSS.port) {
            return(list(LTM=LTM.def, algorithm="def", RSS=RSS.def))
        } else {
            return(list(LTM=LTM.port, algorithm="port", RSS=RSS.port))
        }
    } else {
        if (RSS.pli <= RSS.port) {
            return(list(LTM=LTM.pli, algorithm="pli", RSS=RSS.pli))
        } else {
            return(list(LTM=LTM.port, algorithm="port", RSS=RSS.port))
        }
    }
}
