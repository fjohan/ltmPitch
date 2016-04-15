
maxx<-function(x, y)x[max.col(t(y))]
maxy<-function(x, y)max(y)
hwhm<-function(x, y) {
    halfmax<-max(y)/2
    xatmaxy<-max.col(t(y))
    # rather non-robust way of finding hwhm
    i<-xatmaxy
    while (y[i]>=halfmax && i>=0) {i<-i-1}
    lb<-x[i+1]
    i<-xatmaxy
    while (y[i]>=halfmax && i<=512) {i<-i+1}
    rb<-x[i-1]
    (rb-lb)/2
}
guess<-function(x, y)list(maxx=maxx(x, y), maxy=maxy(x, y), hwhm=hwhm(x, y))
