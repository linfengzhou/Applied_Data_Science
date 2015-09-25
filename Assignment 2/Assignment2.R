library(foreign)
library(quantmod)
library(ggplot2)
library(plyr)
library(stargazer)
setwd("~luke/Dropbox/Applied_Data_Science/Assignment 2")

set.seed(1335)

## generate samples
x <- sample(c(0:9), 1000,replace = TRUE) 
y <- sample(c(0:9), 1000,replace = TRUE) 

## formula a linear model
fit1 <- lm(y ~ x)
summary(fit1)

## import data 
data <- read.dta("train.dta")

### summary data
summary(data)
### fit model
fit2 <- lm(d ~ x1,data)
summary(fit2)

### predict 
data[1001:1002,2] <- c(0.61,1.01)
pred1 <- predict(fit2,data)
pred1[1001:1002] > 1


## CAPM
NIKE_INDEX<-getSymbols("NKE",from="2010-09-20", to='2015-09-20',src="yahoo") 
NASQ_INDEX<-getSymbols("^IXIC",from="2010-09-20", to='2015-09-20',src="yahoo")
NIKE_return=log(NKE$NKE.Adjusted/lag(NKE$NKE.Adjusted))
NASQ_return=log(IXIC$IXIC.Adjusted/lag(IXIC$IXIC.Adjusted))

alldata <- cbind(NIKE_return[,1], NASQ_return[,1])

### eliminate format
write.csv(alldata,"allclean.csv",row.names=FALSE)
d<-read.csv("allclean.csv",header=TRUE)

### plot histogram
NIKE_f = cbind(d$NKE.Adjusted[-1],0)
NASQ_f = cbind(d$IXIC.Adjusted[-1],1)
alldata <- rbind(NIKE_f,NASQ_f)
alldata <- data.frame(alldata)
colnames(alldata) <- c("return","stock")
alldata$stock<-as.factor(alldata$stock)
levels(alldata$stock)
alldata$stock<-revalue(alldata$stock,c("0"="NIKE","1"="NASDAQ"))
ggplot(alldata,aes(x=return)) + 
  geom_histogram(binwidth=0.003,fill="white",colour="black")+ 
  facet_grid(stock~., scales="free")+
  ggtitle("Histogram of Stock Return")+
  theme_bw()
ggplot(alldata,aes(x=return,fill=stock)) + 
  geom_histogram(binwidth=0.003,position='identity', alpha=0.4)+
  ggtitle("Histogram of Stock Return")+
  theme_bw()


### plot scatter plot 
alldata1<-cbind(NASQ_f[,1],NIKE_f[,1])
alldata1<-data.frame(alldata1)
colnames(alldata1)<-c("NIKE","NASDAQ")
ggplot(alldata1,aes(x=NASDAQ,y=NIKE)) + geom_point()+
  theme_bw()+ggtitle("CAPM Data")

### fit linear model 
fit3 <- lm(NIKE~NASDAQ,alldata1)
summary(fit3)

### alpha beta f test 
residuals1 <- fit3$residuals
residuals2 <- NASQ_f[,1] - NIKE_f[,1] 
var.test(residuals1,residuals2)

##Question 4 
x4 <- rnorm(1000, mean=0, sd=1)
e4 <- rnorm(1000, mean=0, sd=1)
y4 <- 1 + 2 * x4 + e4 
fit4 <- lm(y4~x4)
summary(fit4)





##Question 5
## generate norm
q5 <- function(reptime){
   d5 <- c()
   f5 <- c()
   for (i in 1:reptime){
      e5 <- rnorm(1000, mean=0, sd=1)
      x5 <- rnorm(1000, mean=0, sd=1)
      y5 <- 1 + 2 * x5 + e5 
      fit5 <- lm(y5~x5)
      f5 <- rbind(f5,fit5[1]$coefficients)   
     }
   return(f5)
}
a5<-q5(5)

# Question 6 
a6<-q5(1000)
x6<-data.frame(a6[,2])
colnames(x6)<-"x6"
ggplot(x6,aes(x=x6)) + 
  geom_histogram(binwidth=0.003,fill="white",colour="black")+ 
  ggtitle("Histogram of beta1")+
  theme_bw()

# Question 7 

