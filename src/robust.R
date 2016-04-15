## Function to calculate pooled variance
std.dev.pooled<-function(std.dev1, std.dev2, n1, n2){
    pooled.std.dev<-(((n1-1)*std.dev1^2+(n2-1)*std.dev2^2)/(n1+n2-2))^.5
}

## M-estimator function
mest<-function(x,bend=1.28){
#
#  Compute M-estimator of location using Huber's Psi.
#  The default bending constant is 1.28
#
if(mad(x)==0)stop("MAD=0. The M-estimator cannot be computed.")
y<-(x-median(x))/mad(x)  #mad in splus is madn in the book.
A<-sum(hpsi(y,bend))
B<-length(x[abs(y)<=bend])
mest<-median(x)+mad(x)*A/B
repeat{
y<-(x-mest)/mad(x)
A<-sum(hpsi(y,bend))
B<-length(x[abs(y)<=bend])
newmest<-mest+mad(x)*A/B
if(abs(newmest-mest) <.0001)break
mest<-newmest
}
mest
}

hpsi<-function(x,bend=1.28){
#
#   Evaluate Huber`s Psi function for each value in the vector x
#   The bending constant defaults to 1.28.
#
hpsi<-ifelse(abs(x)<=bend,x,bend*sign(x))
hpsi
}


## Biweight midvariance function
bivar<-function(x){
# compute biweight midvariance of x
m<-median(x)
u<-abs((x-m)/(9*qnorm(.75)*mad(x)))
top<-length(x)*sum((x[u<=1]-m)^2*(1-u[u<=1]^2)^4)
bot<-sum((1-u[u<=1]^2)*(1-5*u[u<=1]^2))
bi<-top/bot^2
bi
}
