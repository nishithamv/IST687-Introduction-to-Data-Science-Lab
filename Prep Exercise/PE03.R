###############
#IST 687, Data Cleansing and Munging
#
#Student name: Nishitha Maniganahalli Venkatesh
#Prep exercise number: 03
#Date due: 09/11/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Prep Exercise") #set working directory

#getting the data
dfStates <- read.csv(url("https://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv"), stringsAsFactors=FALSE) #reading the csv file from web and storing it in dfStates dataframe

#cleaning up the dataframe
View(dfStates) #viewing dfStates dataframe
head(dfStates) #obtaininging first few rows of dfStates dataframe
tail(dfStates) #obtaining last few rows of dfStates dataframe

#removing unwanted rows
dfStates <- dfStates[-c(1:8, 60:66),]
dim(dfStates) #obtaining dimension of dfStates dataframe after removing rows

#removing unwanted columns
dfStates <- dfStates[,-(6:10)]
dim(dfStates) #obtaining dimensions of dfStates dataframe after removing columns

#adding metadata
colnames(dfStates) <- c("stateName", "Census", "Estimated", "Pop2010", "Pop2011") #renaming the columns in dfStates dataframe
View(dfStates) #viewing the metadata

#more cleansing
#removing commas from each column of numeric data
dfStates$Census <- gsub(",", "", dfStates$Census)
dfStates$Estimated <- gsub(",", "", dfStates$Estimated)
dfStates$Pop2010 <- gsub(",", "", dfStates$Pop2010)
dfStates$Pop2011 <- gsub(",", "", dfStates$Pop2011)
row.names(dfStates) <- NULL #resettiing the row index
View(dfStates) #viewing the cleansed dfStates dataframe

#converting each of the numeric data columns into numbers
dfStates$Census <- as.numeric(dfStates$Census)
dfStates$Estimated <- as.numeric(dfStates$Estimated)
dfStates$Pop2010 <- as.numeric(dfStates$Pop2010)
dfStates$Pop2011 <- as.numeric(dfStates$Pop2011)
str(dfStates) #obtaining the data types of columns in dfStates dataframe

#calculating mean of each numeric data attribute
meanCensus <- mean(dfStates$Census) #mean of census
meanCensus
meanEstimated <- mean(dfStates$Estimated) #mean of estimated
meanEstimated
meanPop2010 <- mean(dfStates$Pop2010) #mean of 2010 population
meanPop2010
meanPop2011 <- mean(dfStates$Pop2011) #mean of 2011 population
meanPop2011