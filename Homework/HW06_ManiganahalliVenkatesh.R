###############
#IST 687, Data Viz: using ggplot
#
#Student name: Nishitha Maniganahalli Venkatesh
#Homework number: 06
#Date due: 10/07/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Homework") #set working directory



#step 1: exploring the merged data - understanding distributions


#1A. using the merged dataset created in PE06


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
View(states) #viewing states dataframe

arrests <- USArrests #copying the USArrests dataframe in R into arrests dataframe
arrests$stateName <- rownames(arrests) #creating a new column stateName in arrests dataframe that takes row names
View(arrests) #viewing arrests dataframe

mergeDF <- merge(states, arrests, by = "stateName") #merging states and arrests dataframes by stateName 
View(mergeDF) #viewing mergeDF dataframe


#1B. creating separate histogram for pop2011, murder rate, assault and rape

#creating a histogram for pop2011
pop2011Hist <- ggplot(mergeDF, aes(x = Pop2011)) 
#creating a ggplot object for mergeDF dataframe with x-axis as Pop2011
pop2011Hist <- pop2011Hist + geom_histogram(binwidth = 5000000, color = "white", fill = "black") 
#creating a histogram with 5000000 binwidth and desired color
pop2011Hist <- pop2011Hist + ggtitle("US states Population Distribution in 2011") #adding title to the plot
pop2011Hist #viewing the histogram

#creating a histogram for murder rate
murderHist <- ggplot(mergeDF, aes(x = Murder))
#creating a ggplot object for mergeDF dataframe with Murder values along x-axis
murderHist <- murderHist + geom_histogram(binwidth = 2, color ="black", fill = "grey")
#creating a histogram with binwidth as 2  and desired color
murderHist <- murderHist + ggtitle("Distribution of Murder Rate in US States") #adding title to the plot
murderHist #viewing the histogram

#creating a histogram for assault
assaultHist <- ggplot(mergeDF, aes(x = Assault))
#creating a ggplot object for mergeDF dataframe with Assault values along x-axis
assaultHist <- assaultHist + geom_histogram(binwidth = 25, color = "black", fill = "light blue")
#creating a histogram with binwidth as 25  and desired color
assaultHist <- assaultHist + ggtitle("Assault Rate Distribution in US States") #adding title to the plot
assaultHist #viewing the histogram

#creating a histogram for rape
rapeHist <- ggplot(mergeDF, aes(x = Rape))
#creating a ggplot object for mergeDF dataframe with Rape values along x-axis
rapeHist <- rapeHist + geom_histogram(binwidth = 5, color= "black", fill = "orange")
#creating a histogram with binwidth as 5  and desired color
rapeHist <- rapeHist + ggtitle("Rape Rate in US States") #adding title to the plot
rapeHist #viewing the histogram

#binwidth has to be adjusted inorder to make the histogram more legible
#and bin color can be changed to enhance visualization


#1C. creating separate boxplot for pop2011 and murder rate

#creating a boxplot for pop2011
pop2011Box <- ggplot(mergeDF, aes(y = Pop2011))
#creating a ggplot object for mergeDF dataframe with Pop2011 as y-axis
pop2011Box <- pop2011Box + geom_boxplot() #creating a boxplot
pop2011Box <- pop2011Box + ggtitle("Boxplot for 2011 Population in US") #adding title to the plot
pop2011Box #viewing the boxplot

#creating a boxplot for murder rate
murderBox <- ggplot(mergeDF, aes(y = Murder))
#creating a ggplot object for mergeDF dataframe with Murder values along y-axis
murderBox <- murderBox + geom_boxplot() #creating a boxplot
murderBox <- murderBox + ggtitle("Boxplot for Murder Rate in US States") #adding title to the plot
murderBox #viewing the boxplot


#1D. histogram or boxplot is more helpful

#determining if histogram or boxplot is more helpful in visualization depends upon the type of data and the analysis
#histogram is more helpful in knowing the distribution of observations and their frequencies
#as histogram provides the frequencies of a dataset
#boxplot is useful in situations when summarization of the observations is required
#as boxplot provides five important values about the data (i.e., min, max, median, 1st and 3rd quartile values)



#step 2: determining state that has the most murders - bar charts


#2A. cauculating number of murders per state

mergeDF$murderPerState <- (mergeDF$Murder*mergeDF$Pop2011)/100000
#calculating murder per state (dividing by 100000 as murder rate is per 100,000)and storing it in new column murderPerState
mergeDF$murderPerState <- round(mergeDF$murderPerState) 
#rounding off murderPerState value to the closest whole number
View(mergeDF) #viewing the updated dataframe


#2B. generating a bar chart for number of murders per state

murderBar1 <- ggplot(mergeDF, aes(x = stateName, y = murderPerState))
#creating a ggplot object for mergeDF dataframe with stateName along x-axis and murderPerState along y-axis
murderBar1 <- murderBar1 + geom_col() #creating a bar chart
murderBar1 <- murderBar1 + ggtitle("Murders per US State") #adding title to the chart
murderBar1 #viewing the bar chart


#2C. generating a bar chart for number of murders per state, by rotating label and adding title

murderBar2 <- ggplot(mergeDF, aes(x = stateName, y = murderPerState))
#creating a ggplot object for mergeDF dataframe with stateName along x-axis and murderPerState along y-axis
murderBar2 <- murderBar2 + geom_col() #creating a bar chart
murderBar2 <- murderBar2 + theme(axis.text.x = element_text(angle = 90, hjust = 1))
#rotating x-axis labels by 90 degree and justifying them right horizontally 
murderBar2 <- murderBar2 + ggtitle("Total Murders") #addng title to the plot
murderBar2 #viewing the bar chart


#2D. generating a bar chart for number of murders per state and sorting x-axis from low to high

murderBar3 <- ggplot(mergeDF, aes(x = reorder(stateName, murderPerState), y = murderPerState))
#creating a ggplot object for mergeDF dataframe with stateName along x-axis and murderPerState along y-axis;
#arranging bars from lowest to highest value
murderBar3 <- murderBar3 + geom_col() #creating a bar chart
murderBar3 <- murderBar3 + theme(axis.text.x = element_text(angle = 90, hjust = 1))
#rotating x-axis labels by 90 degree and justifying them right horizontally 
murderBar3 <- murderBar3 + ggtitle("Total Murders") #adding title to the plot
murderBar3 #viewing the bar chart


#2E. generating a bar chart for number of murders per state and showing urbanpop as the color of the bar

murderBar4 <- ggplot(mergeDF, aes(x = reorder(stateName, murderPerState), y = murderPerState, fill = UrbanPop))
#creating a ggplot object for mergeDF dataframe with stateName along x-axis and murderPerState along y-axis;
#arranging bars from lowest to highest value and determining color of bars by UrbanPop
murderBar4 <- murderBar4 + geom_col() #creating a bar chart
murderBar4 <- murderBar4 + theme(axis.text.x = element_text(angle = 90, hjust = 1))
#rotating x-axis labels by 90 degree and justifying them right horizontally 
murderBar4 <- murderBar4 + ggtitle("Total Murders") #adding title to the plot
murderBar4 #viewing the bar chart



#step 3: exploring murders - scatter chart


#3A. generating a scatter plot with pop2011 on x-axis,urbanpop on y-axis, size and color as number of murders

pop2011Scat <- ggplot(mergeDF, aes(x = Pop2011, y = UrbanPop))
#creating a ggplot object for mergeDF dataframe with Pop2011 along x-axis and UrbanPop along y-axis
pop2011Scat <- pop2011Scat + geom_point(aes(size = murderPerState, color = murderPerState))
#creating a scatter plot with size and color of data points as murderPerState
pop2011Scat <- pop2011Scat + ggtitle("Scatter Plot") #adding title to the plot
pop2011Scat #viewing the scatter plot
