###############
#IST 687, Support Vector Machines (SVM)
#
#Student name: Nishitha Maniganahalli Venkatesh
#Homework number: 10
#Date due: 11/11/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Homework") #set working directory



#step 1: re-executing the code created in PE10


#1A: re-running the entire R code


#installing and librarying ggplot2 package
#install.packages("ggplot2")
library(ggplot2)

#installing and librarying kernlab package
#install.packages("kernlab")
library(kernlab)

#loading and verifying the diamonds dataset

df <- diamonds
#loading the diamonds dataset into df dataframe
View(df)
#viewing the df dataframe

#cleaning the data

goodDiamonds <- df[(df$cut == "Premium" | df$cut == "Ideal"),]
#obtaining only those diamonds data which has Premium and Ideal cut
View(goodDiamonds)
#viewing the subset dataframe

#changing clarity and color variables from ordered factors to numeric
goodDiamonds$clarity <- as.numeric(goodDiamonds$clarity)
goodDiamonds$color <- as.numeric(goodDiamonds$color)

#changing cut attribute to two levels
goodDiamonds$cut <- as.factor(as.character(goodDiamonds$cut))

#viewing the adjusted dataframe
View(goodDiamonds)

#the dataframe has 10 attributes
#carat: weight of diamond
#cut: quality of cut
#color: diamond color
#clarity: deterimes how clear the diamond is
#depth: total percentage depth
#table: width of top of diamond
#price: cost of diamond in USD
#x, y, z: length, width and depth in mm


#1B. identifying the total number of Premium and Ideal observations


#creating a contingency table for cut of diamonds
table(goodDiamonds$cut)
#21551 diamonds have Ideal cut and 13791 diamonds have Premium cut



#step 2: creating training and test datasets


#2A. generating random indices


#using sample function to obtain random indices of goodDiamonds dataframe
randIndices <- sample(1:dim(goodDiamonds)[1])


#2B. building training and test datasets


#2/3rd data - training dataset

#finding 2/3rd cut point
cutPoint2_3 <- round(2*dim(goodDiamonds)[1]/3)
#round returns the closest integer for the argument
cutPoint2_3

#creating training dataset
trainData <- goodDiamonds[randIndices[1:cutPoint2_3],]
#obtaining 2/3rd random observations in goodDiamonds as training dtaa

#1/3rd data - test data

#creating test data
testData <- goodDiamonds[randIndices[(cutPoint2_3 + 1):dim(goodDiamonds)[1]],]
#obtaining the remaining 1/3rd random observations in goodDiamonds as test data


#2C. demonstrating that the resulting training dataset and test data contain the appropriate number of cases


#dimensions of training dataset
dim(trainData)
#tratining data contains 23561 observations

#dimensions of test data
dim(testData)
#test data contains 11781 observations



#step 3: building a support vector model


#3A. creating a support vector model based on the training data


svmOutput <- ksvm(cut~., data = trainData, kernel = "rbfdot", kpar = "automatic", C = 5, cross = 3, prob.model = TRUE)
#ksvm generates a model based on the training dataset


#3B. explaining the parameters in the function above


#the first argument specifies that the model predicts cut based on all other variables in the data
#data is the dataframe to use for analysis, here it is trainData
#kerbel function is used in training and predicting, in this case it is set to rbdot which is Radial Basis kernel "Gaussian" which is a function of class kernel
#kapr lists the parameters to be used with the kernel function, here it is set to automatic whic uses heuristics
#C is cost of constraints, if C is small the classifier makes more mistakes, if it is high there are fewer mistakes
#cross is the cross validation model the algorithm uses, here 3-fold cross validation on training data is performed
#prob.model is set to TRUE for calculating probabilities assiciated with the cut of diamond


#3C. echoing the SVM


svmOutput
#it displays sigma value, number of support vectors, training error and cross validation error values



#step 4: predicting values in the test data


#4A. validating the model against test data


svmPred <- predict(svmOutput, testData)
#classifies the cut of diamonds in testData based on the SVM


#4B. viewing the values predicted by SVM on the testData


svmPred
#it displays the cut of diamonds which is either Premium or Ideal



#4C. reviewing the contents in svmPred


str(svmPred)
#the output of the classification is factors which has two levels, Ideal is 1 and Premium is 2

head(svmPred)
#displays the first few output of classification made by SVM



#step 5: creating a confusion matrix


#5A. creating a confusion matrix for second row of svmPred and cut in testData


confusionMatrix <- table(svmPred, testData$cut)
#creates a table for the classification made by SVM and the cut in testData, which is the confusion matrix
confusionMatrix


#5B. calculating error rate based on confusion matrix


totalCases <- sum(confusionMatrix[(1:2),])
#calculating the total number of classifications made by SVM
totalCases

errorCases <- confusionMatrix[1,2] + confusionMatrix[2,1]
#calculating the number of misclassifications made by SVM
errorCases

errorRate <- errorCases/totalCases
#calculating the error rate i.e., number of errors by total classifications
errorRate
  

#5C. how good is the model


#91.8% of the time the model correctly classifies the cut of diamonds as either Ideal or Premium
#in 8.2% cases the model misclassifies the cut of diamonds
#6.9% of the total Ideal diamonds in the test data are classified as Premium
#10.2% of the total Premium diamonds in test data are classified as Ideal



#step 6: uderstanding the reasoning behind the practice


#6A. why is it valuable to have a “test” dataset that is separate from a “training” dataset


#the training dataset enables the model to learn the data patterns
#the test dataset helps in understanding how the model will work in real world
#it is essential to have training data based on which the model can learn how to classify the data
#and test data on which the model can be run inorder to know how the model will classify the data