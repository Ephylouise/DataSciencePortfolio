# Business questions:
# “What variables effectively contribute to predicting active cardholders’ credit card balances?”
# “What credit card balance might a new active cardholder hold depending on certain variables?” 

# load libraries
library(tidyverse)
library(olsrr)
library(lm.beta)
library(car)

# read dataset into R
creditdf <- read.csv("credit.csv")
head(creditdf)

# Convert categorical variables to factors with levels and labels
creditdf$Student<-factor(creditdf$Student,levels = c(0,1),labels = c("No","Yes"))
creditdf$Gender<-factor(creditdf$Gender,levels = c(0,1),labels = c("Male","Female"))
creditdf$Married<-factor(creditdf$Married,levels = c(0,1),labels = c("No","Yes"))

# check for missing data
sum(is.na(creditdf))

# generate summary statistics for all variables in dataframe
summary(creditdf)


# partition the data into a training set and a validation set
# set seed so the random sample is reproducible
set.seed(42)
sample <- sample(c(TRUE, FALSE), nrow(creditdf), replace=TRUE, prob=c(0.5,0.5))
traincredit  <- creditdf[sample, ]
valcredit <- creditdf[!sample, ]


# turn off scientific notation for all variables
options(scipen=999) 

# create a correlation matric with quantitative variables
cor(traincredit[c(1, 2, 3, 4, 5, 9)])

# Perform a multiple regression with all quantitative variables
credit_MR <- lm(Balance ~ Income + Limit + Rating + Age + Education + Student + Gender + Married, data = traincredit)
summary(credit_MR)

# calculate Variance Inflation Factor for each variable to assess 
# multicollinearity
vif(credit_MR)

# Perform multiple regression excluding Limit
credit_MR2 <- lm(Balance ~ Income + Rating + Age + Education + Student + Gender + Married, data = traincredit)

# View summary of new regression controlled for multicollinearity
summary(credit_MR2)

# Create a vector of predicted values generated from the multiple 
# regression above
credit_pred = predict(credit_MR2)

# Create a vector of residuals generated from the multiple regression above
credit_res = resid(credit_MR2)

# Create a data frame of the predicted values and the residuals
pred_res_df <- data.frame(credit_pred, credit_res)

# create a scatterplot of the residuals versus the predicted values
ggplot(data = pred_res_df, mapping = aes(x = credit_pred, y = credit_res)) +
  geom_point() +
  labs(title = "Plot of residuals vs. predicted values", x = "Predicted values",
       y = "Residuals")

# Steps to create a Normal Probability Plot 

# create a vector of standardized residuals generated from the multiple
# regression above
credit_std.res = rstandard(credit_MR2)

# produce normal scores for the standardized residuals and create
# normal probability plot
qqnorm(credit_std.res, ylab = "Standardized residuals", xlab = "Normal scores")

# Create new DF with only the statistically significant variable from the previous multiple regression model
credit_MR3 <- lm(Balance ~ Income + Rating + Age + Student, data = traincredit)

# View summary of new df
summary(credit_MR3)

# Extract standardized regression coefficients
lm.beta(credit_MR3)

# Perform another multiple regression on validation dataframe
credit_MR_val <- lm(Balance ~ Income + Rating + Age + Student, data = valcredit)

# View summary of new regression controlled for multicollinearity
summary(credit_MR_val)

# read new cardholder dataset into R
nchdf <- read.csv("credit_card_prediction.csv")
head(nchdf)

# Convert categorical variables to factors with levels and labels
nchdf$Student<-factor(nchdf$Student,levels = c(0,1),labels = c("No","Yes"))

# estimate predicted y values and prediction intervals for the new card holders
predict(credit_MR_val, nchdf, interval = "prediction", level = 0.95)

