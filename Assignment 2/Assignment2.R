library(foreign)
library(quantmod)
library(ggplot2)
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

