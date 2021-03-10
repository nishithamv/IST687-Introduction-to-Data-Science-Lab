###############
#IST 687, Functions
#
#Student name: Nishitha Maniganahalli Venkatesh
#Prep exercise number: 04
#Date due: 09/18/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Prep Exercise") #set working directory

#creating a function printVecInfo that takes one numeric vector as input argument
printVecInfo <- function(numVector)
{
  cat("numVector: ",numVector) #outputing the numeric vector numVector
  cat("\nMean: ",mean(numVector)) #outputing mean of numVector
  cat("\nMedian: ",median(numVector)) #outputing median of numVector
  cat("\nMin: ",min(numVector)) #outputing minimum of numVector
  cat("\nMax: ",max(numVector)) #outputing max of numVector
  cat("\nStandard Deviation: ",sd(numVector)) #outputing standard deviation of numVector
  cat("\n0.05 Quantile: ",quantile(numVector,0.05)) #outputing quantile corresponding to 0.05 of numVector
  cat("\n0.95 Quantile: ",quantile(numVector,0.95)) #outputing quantile corresponding to 0.95 of numVector
}

#testing the printVecInfo function
testVector <- (1:10) #creating a test vector
printVecInfo(testVector) #calling thr printVecInfo function