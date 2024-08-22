# Business question:
# “What is the probability that a customer will make an auto insurance claim based on certain characteristics?”

# load libraries
library(tidyverse)
library(caret)
library(ROCR)
library(ROSE)

# read dataset into R
insdf <- read.csv("insurance.csv")
head(insdf)

# Convert categorical variables to factors with levels and labels
insdf$CLAIM <-factor(insdf$CLAIM,levels = c(0,1),labels = c("No","Yes"))
insdf$KIDSDRIV<-factor(insdf$KIDSDRIV,levels = c(0,1),labels = c("No","Yes"))
insdf$HOMEKIDS<-factor(insdf$HOMEKIDS,levels = c(0,1),labels = c("No","Yes"))
insdf$HOMEOWN<-factor(insdf$HOMEOWN,levels = c(0,1),labels = c("No","Yes"))
insdf$MSTATUS<-factor(insdf$MSTATUS,levels = c(0,1),labels = c("No","Yes"))
insdf$GENDER<-factor(insdf$GENDER,levels = c(0,1),labels = c("Male","Female"))
insdf$EDUCATION<-factor(insdf$EDUCATION,levels = c(0,1),labels = c("High School only","College or beyond"))
insdf$CAR_USE<-factor(insdf$CAR_USE,levels = c(0,1),labels = c("Private","Commercial"))
insdf$RED_CAR<-factor(insdf$RED_CAR,levels = c(0,1),labels = c("No","Yes"))
insdf$CLM_BEF<-factor(insdf$CLM_BEF,levels = c(0,1),labels = c("No","Yes"))
insdf$REVOKEDR<-factor(insdf$REVOKED,levels = c(0,1),labels = c("No","Yes"))
insdf$MVR_PTS<-factor(insdf$MVR_PTS,levels = c(0,1),labels = c("No","Yes"))
insdf$URBANICITY<-factor(insdf$URBANICITY,levels = c(0,1),labels = c("Rural","Urban"))


# check for missing data
sum(is.na(insdf))

# generate summary statistics for all variables in dataframe
summary(insdf)

# Use the group_by() and summarise() functions to calculate percentages
claims <- insdf %>%
  group_by(CLAIM) %>%
  summarise(Percentage = n() / nrow(.) * 100)
view(claims)

# set seed so the random sample is reproducible
set.seed(42)

# Partition the dataset into a training, validation and test set
Samples<-sample(seq(1,3),size=nrow(insdf),replace=TRUE,prob=c(0.6,0.2,0.2))
Train<- insdf[Samples==1,]
Validate<-insdf[Samples==2,]
Test<-insdf[Samples==3,]

# View descriptive statistics for each dataframe
summary(Train)
summary(Validate)
summary(Test)

count(Test)

# fit logistic regression model on the Claim outcome variable
# using specified input variables with the undersample dataframe

# Logistic regression is part of the general linear model family, so the R 
# function is glm.
options(scipen=999)
lrins <- glm(CLAIM ~ ., data = Train, 
               family = binomial(link = "logit"))

# model summary
summary(lrins)

# exponentiate the regression coefficients from the logistic regression model 
exp(coef(lrins))

# Steps to create a confusion matrix
# First using logistic regression model built on imbalanced data
# obtain probability of making a  claim for each observation in validation set
lrprobs <- predict(lrins, newdata = Validate, type = "response")

# Attach probability scores to Validate dataframe
Validate <- cbind(Validate, Probabilities=lrprobs)
view(Validate)

# obtain predicted class for each observation in validation set using threshold of 0.5
lrclass <- as.factor(ifelse(lrprobs > 0.5, "Yes","No"))

# Attach predicted class to Validate dataframe
Validate <- cbind(Validate, PredClass=lrclass)

# Create a confusion matrix using "Yes" as the positive class 
confusionMatrix(lrclass, Validate$CLAIM, positive = "Yes" )

# create a prediction object to use for the ROC Curve
pred <- prediction(lrprobs, Validate$CLAIM)

# create a performance object to use for the ROC Curve
perf <- performance(pred,"tpr", "fpr")

# plot the ROC Curve
plot(perf)
abline(a=0, b= 1)

# compute AUC 
performance(pred, measure="auc")@y.values[[1]]

# Address moderate class imbalance by using oversampling
# Create an oversampled training subset
set.seed(42)
oversample<-upSample(x=Train, y=Train$CLAIM, yname = "CLAIM")

table(oversample$CLAIM)
table(Train$CLAIM)

# fit logistic regression model on the CLAIM outcome variable
# using specified input variables with the oversample dataframe
lrOver <- glm(CLAIM ~ . , data = oversample, 
              family = binomial(link = "logit"))

# model summary
summary(lrOver)

exp(coef(lrOver))

# Steps to create a confusion matrix
# First using logistic regression model built on oversampled training subset
# obtain probability of defaulting for each observation in validation set
lrprobsO <- predict(lrOver, newdata = Validate, type = "response")

# obtain predicted class for each observation in validation set using threshold of 0.5
lrclassO <- as.factor(ifelse(lrprobsO > 0.5, "Yes","No"))

# Create a confusion matrix using "Yes" as the positive class 
confusionMatrix(lrclassO, Validate$CLAIM, positive = "Yes" )

# create a prediction object to use for the ROC Curve
predO <- prediction(lrprobsO, Validate$CLAIM)

# create a performance object to use for the ROC Curve
perfO <- performance(predO,"tpr", "fpr")

# plot the ROC Curve
plot(perfO)
abline(a=0, b= 1)

# compute AUC 
performance(predO, measure="auc")@y.values[[1]]

# Evaluate accuracy of the model built using the oversampled training set
# applied to the test set


# obtain probability of filing a claim for each observation in test set
lrprobstest <- predict(lrOver, newdata = Test, type = "response")

# obtain predicted class for each observation in test set using threshold of 0.5
lrclasstest <- as.factor(ifelse(lrprobstest > 0.5, "Yes","No"))

# Create a confusion matrix using "Yes" as the positive class 
confusionMatrix(lrclasstest, Test$CLAIM, positive = "Yes" )

# create a prediction object to use for the ROC Curve
predOtest <- prediction(lrprobstest, Test$CLAIM)

# create a performance object to use for the ROC Curve
perfOtest <- performance(predOtest,"tpr", "fpr")

# plot the ROC Curve
plot(perfOtest)
abline(a=0, b= 1)

# compute AUC 
performance(predOtest, measure="auc")@y.values[[1]]



# predict probability of claim for new customers

# read new dataset into R
new_customers <- read.csv("insurance_predictions.csv")
View(new_customers)

# Convert categorical variables to factors with levels and labels
new_customers$KIDSDRIV<-factor(new_customers$KIDSDRIV,levels = c(0,1),labels = c("No","Yes"))
new_customers$HOMEKIDS<-factor(new_customers$HOMEKIDS,levels = c(0,1),labels = c("No","Yes"))
new_customers$HOMEOWN<-factor(new_customers$HOMEOWN,levels = c(0,1),labels = c("No","Yes"))
new_customers$MSTATUS<-factor(new_customers$MSTATUS,levels = c(0,1),labels = c("No","Yes"))
new_customers$GENDER<-factor(new_customers$GENDER,levels = c(0,1),labels = c("Male","Female"))
new_customers$EDUCATION<-factor(new_customers$EDUCATION,levels = c(0,1),labels = c("High School only","College or beyond"))
new_customers$CAR_USE<-factor(new_customers$CAR_USE,levels = c(0,1),labels = c("Private","Commercial"))
new_customers$RED_CAR<-factor(new_customers$RED_CAR,levels = c(0,1),labels = c("No","Yes"))
new_customers$CLM_BEF<-factor(new_customers$CLM_BEF,levels = c(0,1),labels = c("No","Yes"))
new_customers$REVOKEDR<-factor(new_customers$REVOKED,levels = c(0,1),labels = c("No","Yes"))
new_customers$MVR_PTS<-factor(new_customers$MVR_PTS,levels = c(0,1),labels = c("No","Yes"))
new_customers$URBANICITY<-factor(new_customers$URBANICITY,levels = c(0,1),labels = c("Rural","Urban"))



# make predictions for new data (for which loan default is unknown)
lrprobsnew <- predict(lrOver, newdata = new_customers , type = "response")

# Attach probability scores to new_customers dataframe 
new_customers <- cbind(new_customers, Probabilities=lrprobsnew)
View(new_customers)

