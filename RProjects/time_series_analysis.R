# Business questions:
# 1. “What is a reasonable forecast of 2019 average U.S.domestic airfare given the patterns in past data?"
# 2. “What is a reasonable forecast for Warner Music Group's 2022 Q1, Q2, Q3, and Q4 revenue given the patterns in past data?”
# 3. “What is a reasonable forecast for Amazon Web Services 2022 Q1, Q2, Q3, and Q4 revenue given the patterns in past data?

# load libraries
library(tidyverse)
library(TTR)
library(forecast)

## Part 1

# read dataset into R
afdf <- read.csv("airfare.csv")
head(afdf)

# create a time series plot showing the average airfare from 2004 to 2018
ggplot(data = afdf, mapping = aes(x = Year, y = Airfare)) +
  geom_line () +
  geom_point() +
  labs(title = "Average Airfare from 2004 to 2018", x = "Year", y = "Airfare")

# create a separate vector for the actual weekly sales
airfare_actuals<-afdf$Airfare

# use the simple moving average method to forecast 2019

sma2019<-SMA (airfare_actuals, n=3)
sma2019

# The last value in the vector is the forecast for 2019

# Adjust the vector of predicted values to align with the actual values vector
airfare_ma_pred<-c(NA, sma2019[-length(sma2019)]) 
airfare_ma_pred

# Create functions for the accuracy measures 
mae<-function(actual,pred){
  mae <- mean(abs(actual-pred), na.rm=TRUE)
  return (mae)
}

mse<-function(actual,pred){
  mse <- mean((actual-pred)^2, na.rm=TRUE)
  return (mse)
}

rmse<-function(actual,pred){
  rmse <- sqrt(mean((actual-pred)^2, na.rm=TRUE))
  return (rmse)
}  

mape<-function(actual,pred){
  mape <- mean(abs((actual - pred)/actual), na.rm=TRUE)*100
  return (mape)
}

# Calculate accuracy measures with vector of actual values and vector
# of predicted values as inputs
mae(airfare_actuals, airfare_ma_pred)
mse(airfare_actuals, airfare_ma_pred)
rmse(airfare_actuals, airfare_ma_pred)
mape(airfare_actuals, airfare_ma_pred)

# use the exponential smoothing method with alpha = 0.2 to forecast
exp2019 <- EMA (airfare_actuals, n=1, ratio = .2)
exp2019

# The last value in the vector is the forecast for 2019

# Adjust the vector of predicted values to align with the actual values vector
exp_pred <- c(NA, exp2019[-length(exp2019)])

# Calculate accuracy measures with vector of actual values and vector
# of predicted values as inputs
mae(airfare_actuals, exp_pred)
mse(airfare_actuals, exp_pred)
rmse(airfare_actuals, exp_pred)
mape(airfare_actuals, exp_pred)


# use the exponential smoothing method with alpha = 0.8 to forecast
exp2019_8 <- EMA (airfare_actuals, n=1, ratio = .8)
exp2019_8

# The last value in the vector is the forecast for 2019

# Adjust the vector of predicted values to align with the sales_actuals vector
exp_pred_8 <- c(NA, exp2019_8[-length(exp2019_8)])

# Calculate accuracy measures with vector of actual values and vector
# of predicted values as inputs
mae(airfare_actuals, exp_pred_8)
mse(airfare_actuals, exp_pred_8)
rmse(airfare_actuals, exp_pred_8)
mape(airfare_actuals, exp_pred_8)



## Part 2

# Modeling a linear time series trend using regression

# read dataset into R
wmdf <- read.csv("warner_music.csv")
head(wmdf)

# create a time series plot showing yearly net revenue in billions
ggplot(data = wmdf, mapping = aes(x = Quarter, y = Revenue)) +
  geom_line (group=1) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90)) +
  labs(title = "Warner Music Group's Net Revenue in Billions of Dollars, 
       2015 to 2021", x = "Quarter", y = "Revenue")

# Add a column of consecutive numbers corresponding with each year
wmdf$Time <- 1:nrow(wmdf) 

# Use simple linear regression analysis to create a regression equation for 
# forecasting
wmreg<-lm(Revenue ~ Time, data = wmdf)
summary(wmreg)


# Create a data frame with the time periods to use for the prediction
wmnew <- data.frame(Time = c(26, 27, 28))

predict(wmreg, newdata = wmnew)

# Create a vector of predicted values generated from the 
# regression above
wm_pred = predict(wmreg)


# Calculate accuracy measures with vector of actual values and vector
# of predicted values as inputs
mae(wmdf$Revenue, wm_pred)
mse(wmdf$Revenue, wm_pred)
rmse(wmdf$Revenue, wm_pred)
mape(wmdf$Revenue, wm_pred)


# Modeling seasonality and trent in a time series using regression

# Create dummy variables corresponding to each quarter 
wmdf$Q1 <- ifelse(grepl("Q1",wmdf$Quarter), 1, 0)
wmdf$Q2 <- ifelse(grepl("Q2",wmdf$Quarter), 1, 0)
wmdf$Q3 <- ifelse(grepl("Q3",wmdf$Quarter), 1, 0)
wmdf$Q4 <- ifelse(grepl("Q4",wmdf$Quarter), 1, 0)

# Use multiple regression with the time and quarters variables to generate 
# a regression equation for forecasting
wmreg2<-lm(Revenue ~ Time + Q2 + Q3 + Q4, data = wmdf)
summary(wmreg2)

# Create a vector of predicted values generated from the multiple 
# regression above
wm_pred2 = predict(wmreg2)

# calculate accuracy measures with vector of actual values and vector
# of predicted values as inputs
mae(wmdf$Revenue, wm_pred2)
mse(wmdf$Revenue, wm_pred2)
rmse(wmdf$Revenue, wm_pred2)
mape(wmdf$Revenue, wm_pred2)


# Predict Warner Music Group's Revenue for 2022 Q1, Q2, Q3, Q4

# Create an object with the time periods to use for the prediction
pred2022 <- data.frame(Time = c(26,27,28,29), Q2 = c(0,1,0,0), Q3 = c(0,0,1,0), 
                  Q4 = c(0,0,0,1)) 
predict(wmreg2, newdata = pred2022)



## Part 3

# read dataset into R
awdf <- read.csv("amazon_web_services.csv")
head(awdf)

# create a time series plot showing quarterly revenue
ggplot(data = awdf, mapping = aes(x = Quarter, y = Revenue)) +
  geom_line (group=1) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90))+
labs(title = "Amazon Web Services Quarterly Revenue from 2014 to 2021 in $ millions", 
     x = "Quarter", y = "Revenue")


# Add a column of consecutive numbers corresponding with each year
awdf$Time <- 1:nrow(awdf) 

# Use simple linear regression analysis to create a regression equation for 
# forecasting
awreg<-lm(Revenue ~ Time, data = awdf)
summary(awreg)


# Create a vector of predicted values generated from the 
# regression above
aw_pred = predict(awreg)


# Calculate accuracy measures with vector of actual values and vector
# of predicted values as inputs
mae(awdf$Revenue, aw_pred)
mse(awdf$Revenue, aw_pred)
rmse(awdf$Revenue, aw_pred)
mape(awdf$Revenue, aw_pred)


# Modeling a quadratic trend in a time series using polynomial regression

# Create a new variable that squares the Time variable
awdf$Time2 <- awdf$Time^2

# Use a quadratic regression model to create a regression equation for 
# forecasting
awregquad<-lm(Revenue ~ Time + Time2, data = awdf)
summary(awregquad)

# Create a vector of predicted values generated from the 
# regression above
aw_pred2 = predict(awregquad)

# calculate accuracy measures with vector of actual values and vector
# of predicted values as inputs
mae (awdf$Revenue, aw_pred2)
mse (awdf$Revenue, aw_pred2)
rmse (awdf$Revenue, aw_pred2)
mape (awdf$Revenue, aw_pred2)


# Predict Amazon Web Services Revenue for Q1, Q2, Q3, and Q4 of 2022

# Create an object with the time periods to use for the prediction
aw2022 <- data.frame(Time = c(33,34,35,36), Time2 = c(1089, 1156, 1225, 1296))

predict(awregquad, newdata = aw2022)

