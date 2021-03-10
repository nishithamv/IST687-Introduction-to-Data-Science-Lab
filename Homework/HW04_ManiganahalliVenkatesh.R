###############
#IST 687, Sampling and Decisions
#
#Student name: Nishitha Maniganahalli Venkatesh
#Homework number: 04
#Date due: 09/23/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Homework") #set working directory

#copying the airquality dataframe into myAQdata dataframe
myAQdata <- airquality
View(myAQdata) #viewing the newly created dataframe

#cleaning NAs from myAQdata dataframe
myAQdata$Ozone[is.na(myAQdata$Ozone)] #obtaining those instances of Ozone in myAQdata dataframe which are NA
is.na(myAQdata$Ozone) #determining if Ozone values in myAQdata dataframe are NA (TRUE- NA, FALSE- otherwise)

#updating the remaining columns in myAQdata dataframe that contains NA
updateNA <- function(col) 
{
  col[is.na(col)] #obtaining those instances of column which are NA
  col[is.na(col)] <- mean(col, na.rm = TRUE) #replacing NA values with column mean
  return(col) #returning the updates column
}

myAQdata$Ozone <- updateNA(myAQdata$Ozone) #updating NAs in Solar.R
myAQdata$Solar.R <- updateNA(myAQdata$Solar.R) #updating NAs in Solar.R
myAQdata$Wind <- updateNA(myAQdata$Wind) #updating NAs in Wind
myAQdata$Temp <- updateNA(myAQdata$Temp) #updating NAs in Temp
View(myAQdata) #viewing the updated myAQdata dataframe

#installing imputeTS package
#install.packages("imputeTS")
library(imputeTS)

#copying the airquality dataframe into myAQdata1 dataframe
myAQdata1 <- airquality
View(myAQdata1) #viewing the newly created dataframe

#interpolating Na values in each column of myAQdata1 dataframe
myAQdata1$Ozone <- na_interpolation(myAQdata1$Ozone)
myAQdata1$Solar.R <- na_interpolation(myAQdata1$Solar.R)
myAQdata1$Wind <- na_interpolation(myAQdata1$Wind)
myAQdata1$Temp <- na_interpolation(myAQdata1$Temp)
View(myAQdata1) #viewig myAQdata1 dataframe

#viewing first 5 rows of myAQdata dataframe
head(myAQdata, 5)
#viewing first 5 rows of myAQdata1 dataframe
head(myAQdata1, 5)

#the NAs in myAQdata are replaced by the mean of the corresponding column
#the NAs in myAQdata1 are replaced by the interpolated value
#interpolated value and mean are not the same

#printing vector information
printVecInfo <- function(numVector)
{
  cat("sampledVector: ",numVector) #outputing the numeric vector numVector
  cat("\nMean: ",mean(numVector)) #outputing mean of numVector
  cat("\nMedian: ",median(numVector)) #outputing median of numVector
  cat("\nMin: ",min(numVector)) #outputing minimum of numVector
  cat("\nMax: ",max(numVector)) #outputing max of numVector
  cat("\nStandard Deviation: ",sd(numVector)) #outputing standard deviation of numVector
  cat("\n0.05 Quantile: ",quantile(numVector,0.05)) #outputing quantile corresponding to 0.05 of numVector
  cat("\n0.95 Quantile: ",quantile(numVector,0.95)) #outputing quantile corresponding to 0.95 of numVector
}

#sampling
sampledWind <- sample(myAQdata$Wind, size = 10, replace = TRUE) #sampling 10 observations from Wind in myAQdata dataframe
printVecInfo(sampledWind) #viewing the information of sampled data
hist(sampledWind) #creating histogram for the sampled data

#replace=TRUE; there can be duplicates in the sampled data
#replace=FALSE; there are not duplicates in the sampled data

#repeating sampling on Wind in myAQdata dataframe
#1
sampledWind1 <- sample(myAQdata$Wind, size = 10, replace = TRUE)
printVecInfo(sampledWind1)
hist(sampledWind1)

#2
sampledWind2 <- sample(myAQdata$Wind, size = 10, replace = TRUE)
printVecInfo(sampledWind2)
hist(sampledWind2)

#3
sampledWind3 <- sample(myAQdata$Wind, size = 10, replace = TRUE)
printVecInfo(sampledWind3)
hist(sampledWind3)

#each result is different as the sample is picked in random
#the elements in one sample are different from the elements in another
#hence the vector information and histogram is different for each of the sample

#replicating the sampling and mean calculations 200 times
replicatedWind <- replicate(200, mean(sample(myAQdata$Wind, size = 10, replace = TRUE)), simplify = TRUE)
hist(replicatedWind) #displaying the 200 means as a histogram

#repeating replication
#1
replicatedWind1 <- replicate(200, mean(sample(myAQdata$Wind, size = 10, replace = TRUE)), simplify = TRUE)
hist(replicatedWind1)

#2
replicatedWind2 <- replicate(200, mean(sample(myAQdata$Wind, size = 10, replace = TRUE)), simplify = TRUE)
hist(replicatedWind2)

#histograms generated in step1 are for the randomly drawn samples, it is a skewed graph
#histograms generated in step2 are for the means of 200 samples that are drawn at random, it follows normal distribution
