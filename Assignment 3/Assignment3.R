library(foreign)
setwd("~luke/Dropbox/Applied_Data_Science/Assignment 3")
data <- read.dta("SI Sales Old.dta")
str(data)
cor(data)

fit1<-lm(price~unit_size,data)
summary(fit1)

fit2<-lm(price ~ unit_size + land_size,data)
summary(fit2)

fit3<-lm(price ~ unit_size + land_size + age,data)
summary(fit3)

fit4<-lm(price ~ unit_size + land_size + age + todt,data)
summary(fit4)

data$priceper1000= data$price/1000
head(data)

fit5<-lm(priceper1000 ~ unit_size + land_size + age + todt,data)
summary(fit5)


data1<-log(data)
fit6<-lm(log(priceper1000)~log(unit_size)+
           log(land_size)+log(age+1)+todt,data)
summary(fit6)

data$year <- data$sales_year-2002 
head(data)

fit7<-lm(price ~ unit_size + land_size + age + todt + year,data)
summary(fit7)
confint(fit7,level=0.95)

data$unit_sizesf <- data$unit_size * 10.7639 
data$land_sizesf <- data$land_size * 10.7639

fit8<-lm(price~unit_sizesf + land_sizesf + age + todt + year,data)
summary(fit8)

set.seed(1335)

x1 <- rnorm(10000, mean=0, sd=1)
x2 <- rnorm(10000, mean=0, sd=1)
e1 <- rnorm(10000, mean=0, sd=1)
y1 <- 1 + x1 + x2 + e1 
cor(x1,x2)
fit9<-lm(y1~x1)
summary(fit9)

z1<-rnorm(10000, mean=0, sd=1)
q1<-rnorm(10000, mean=0, sd=1)
w1<-rnorm(10000, mean=0, sd=1) 

x2_1<- z1+q1 
x2_2<- -z1+w1 
y2 = 1 + x2_1 + x2_2 +e1
cor(x1,x2)
fit10<-lm(y2~x2_1)
summary(fit10)