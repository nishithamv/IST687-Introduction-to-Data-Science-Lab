###############
#IST 687, Support Vector Machines (SVM)
#
#Student name: Nishitha Maniganahalli Venkatesh
#Prep exercise number: 10
#Date due: 11/06/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Prep Exercise") #set working directory

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

