###############
#IST 687, Data Prep for Visualizations using Map Data
#
#Student name: Nishitha Maniganahalli Venkatesh
#Prep exercise number: 07
#Date due: 10/09/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Prep Exercise") #set working directory

#installing ggplot2 package
#install.packages("ggplot2")
library(ggplot2)

#installing zipcode package
#install.packages("zipcode")
library(zipcode)

#load and repair median income data
mydata <- read.csv("MedianZIP.csv") #reading the csv file into mydata dataframe
View(mydata) #viewing the dataframe

#cleaning up NAs
NAsMean <- length(mydata$Mean[is.na(mydata$Mean)]) #looking for NAs in Mean
NAsMean 
#no NAs in Mean

#viewing mydata dataframe
View(mydata) 
#zip: ZIP code of an area
#Median: median income in the area
#Mean: mean income in the area
#Pop: population in the area

#viewing the first 2391 0bservations of mydata dataframe
mydata[1:2391,]
#the first 2391 observations look weird as they have a 4-digit zip

#merging the median income data with the detailed zipcode data

mydata$zip <- clean.zipcodes(mydata$zip) #cleaning up zip codes by prefixing 0 to zip where zip is not 5-digit 
data(zipcode) #loading the zipcode dataframe 
dfNew <- merge(mydata, zipcode, by = "zip") 
#merging mydata and zipcode dataframes by zip into a new dataframe dfNew
View(dfNew) #viewing the new dataframe

#merging the new dataset with stateNameDF data

stateNameDF <- data.frame(state = state.abb, stateName = state.name, center = state.center)
#creating a new dataframe stateNameDF for 50 US states with 
#state attribute as 2-letter abbreviation of state name
#stateName attribute as full state name
#and center attribute as negative longitude(x) and latitude(y) of geographic center for each state 
stateNameDF$stateName <- tolower(stateNameDF$stateName) # converting stateName observations to lower case
View(stateNameDF) #viewing the new dataframe

df <- merge(stateNameDF, dfNew, by = "state") 
#merging stateNameDF and dfNew dataframes by state into a new dataframe df
View(df) #viewing the new dataframe
