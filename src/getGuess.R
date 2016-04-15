
source("guess.R")

getGuess<-function(dx, dy) {
    g1<-guess(dx, dy)
    dy.res<-dy-dnorm(dx, g1$maxx, g1$hwhm)
    g2<-guess(dx, dy.res)
    list(g1=g1, g2=g2)
}
