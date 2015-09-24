library(foreign)
library(quantmod)
library(ggplot2)
library(plyr)
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
GOOG_INDEX<-getSymbols("GOOG",from="2014-03-27", to='2015-09-20',src="yahoo") 
NASQ_INDEX<-getSymbols("^IXIC",from="2014-03-27", to='2015-09-20',src="yahoo")
GOOG_return=log(GOOG$GOOG.Adjusted/lag(GOOG$GOOG.Adjusted))
NASQ_return=log(IXIC$IXIC.Adjusted/lag(IXIC$IXIC.Adjusted))

alldata <- cbind(GOOG_return[,1], NASQ_return[,1])

### eliminate format
write.csv(alldata,"allclean.csv",row.names=FALSE)
d<-read.csv("allclean.csv",header=TRUE)

### plot histogram
GOOG_f = cbind(d$GOOG.Adjusted[-1],0)
NASQ_f = cbind(d$IXIC.Adjusted[-1],1)
alldata <- rbind(GOOG_f,NASQ_f)
alldata <- data.frame(alldata)
colnames(alldata) <- c("return","stock")
alldata$stock<-as.factor(alldata$stock)
levels(alldata$stock)
alldata$stock<-revalue(alldata$stock,c("0"="GOOGLE","1"="NASDAQ"))
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
alldata1<-cbind(NASQ_f[,1],GOOG_f[,1])
alldata1<-data.frame(alldata1)
colnames(alldata1)<-c("GOOGLE","NASDAQ")
ggplot(alldata1,aes(x=NASDAQ,y=GOOGLE)) + geom_point()+
  theme_bw()+ggtitle("CAPM Data")

### fit linear model 
fit3 <- lm(GOOGLE~NASDAQ,alldata1)
summary(fit3)

### alpha beta f test 

##