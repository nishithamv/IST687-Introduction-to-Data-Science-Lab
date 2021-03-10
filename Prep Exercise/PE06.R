###############
#IST 687, Data Prep for Visualization using GGPlot
#
#Student name: Nishitha Maniganahalli Venkatesh
#Prep exercise number: 06
#Date due: 10/02/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Prep Exercise") #set working directory

#installing ggplot2 package
#install.packages("ggplot2")
library(ggplot2)

#creating a function readStates() that returns the cleaned dataframe
readStates <- function()
{
  #getting the data
  #reading the csv file from web and storing it in dfStates dataframe
  dfStates <- read.csv(url("https://www2.census.gov/programs-surveys/popest/tables/2010-2011/state/totals/nst-est2011-01.csv"), stringsAsFactors=FALSE)
  
  #removing unwanted rows
  dfStates <- dfStates[-c(1:8, 60:66),]
  
  #removing unwanted columns
  dfStates <- dfStates[,-(6:10)]
  
  #adding metadata
  #renaming the columns in dfStates dataframe
  colnames(dfStates) <- c("stateName", "Census", "Estimated", "Pop2010", "Pop2011")
  
  #more cleansing
  #removing commas from each column of numeric data
  dfStates$Census <- gsub(",", "", dfStates$Census)
  dfStates$Estimated <- gsub(",", "", dfStates$Estimated)
  dfStates$Pop2010 <- gsub(",", "", dfStates$Pop2010)
  dfStates$Pop2011 <- gsub(",", "", dfStates$Pop2011)
  #removing period from stateName column
  dfStates$stateName <- gsub("\\.", "", dfStates$stateName)
  
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

states <- readStates() #obtainind the cleaned census dataframe from readStates function
arrests <- USArrests #copying the USArrests dataframe in R into arrests dataframe
arrests$stateName <- rownames(arrests) #creating a new column stateName in arrests dataframe that takes row names
mergeDF <- merge(states, arrests, by = "stateName") #merging states and arrests dataframes by stateName

#generating a boxpot for Murder
ggplot(mergeDF) + #creating a ggplot object for mergeDF dataframe
  aes(y = Murder) + #setting y-axis to Murder for the ggplot object created
  geom_boxplot() + #creating a boxplot
  ggtitle("Boxplot for Murder Rate in US States") #adding title to the plot

#generating a histogram for Murder
myPlot <- ggplot(mergeDF, aes(x = Murder)) #initializing a ggplot object for mergeDF dataframe with Murder as x-axis
myPlot <- myPlot + geom_histogram(binwidth = 2, color = "black", fill = "white") #creating a histogram with binwidth as 2, color of bins as white and bin border as black
myPlot <- myPlot + ggtitle("Histogram for Murder Rate in US States") #ading title to the plot
myPlot #displaying the plot
