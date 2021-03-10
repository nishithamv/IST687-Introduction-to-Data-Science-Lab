###############
#IST 687, Descriptive Stats and Functions
#
#Student name: Nishitha Maniganahalli Venkatesh
#Homework number: 03
#Date due: 09/16/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Homework") #set working directory

readStates <- function()
{
#getting the data
  dfStates <- read.csv(url("https://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv"), stringsAsFactors=FALSE) #reading the csv file from web and storing it in dfStates dataframe

#removing unwanted rows
  dfStates <- dfStates[-c(1:8, 60:66),]

#removing unwanted columns
  dfStates <- dfStates[,-(6:10)]
  
#adding metadata
  colnames(dfStates) <- c("stateName", "Census", "Estimated", "Pop2010", "Pop2011") #renaming the columns in dfStates dataframe

#more cleansing
#removing commas from each column of numeric data
  dfStates$Census <- gsub(",", "", dfStates$Census)
  dfStates$Estimated <- gsub(",", "", dfStates$Estimated)
  dfStates$Pop2010 <- gsub(",", "", dfStates$Pop2010)
  dfStates$Pop2011 <- gsub(",", "", dfStates$Pop2011)

#converting each of the numeric data columns into numbers
  dfStates$Census <- as.numeric(dfStates$Census)
  dfStates$Estimated <- as.numeric(dfStates$Estimated)
  dfStates$Pop2010 <- as.numeric(dfStates$Pop2010)
  dfStates$Pop2011 <- as.numeric(dfStates$Pop2011)

#resettiing the row index
  row.names(dfStates) <- NULL
  
#returning dfStates dataframe
  return(dfStates)
}

#creating a new dataframe dfStates using the readStates function
dfStates <- readStates()
View(dfStates) #viewing the newly created dataframe

#calculating min, mean and max population of the states based on 2011 population
minPop2011 <- min(dfStates$Pop2011) #minimum population in 2011
minPop2011
meanPop2011 <- mean(dfStates$Pop2011) #mean population in 2011
meanPop2011
maxPop2011 <- max(dfStates$Pop2011) #maximum population in 2011
maxPop2011

maxPopState <- dfStates[which.max(dfStates$Pop2011),] #determining row with maximum population in 2011
maxPopState
maxPopState[1] #state with maximum populatin in 2011

minPopState <- dfStates[which.min(dfStates$Pop2011),] #determining row with minimum population in 2011
minPopState
minPopState[1] #state with minimum population in 2011

#sorting the dfStates dataframe by 2011 population
dfStatesOrdered <- dfStates[order(dfStates$Pop2011, decreasing = FALSE),] #storing the sorted dataframe in dfStatesOrdered dataframe
row.names(dfStatesOrdered) <- NULL #resettiing the row index
View(dfStatesOrdered) #viewing the new sorted dataframe

#creating a histogram for US population in 2011
USpopulation2011 <- dfStates$Pop2011
hist(USpopulation2011) 

#Y-axis indicates how frequently the data occours; each unit is equal to 5
#X-axis indicates the US population in 2011: each unit is equal to 10 million