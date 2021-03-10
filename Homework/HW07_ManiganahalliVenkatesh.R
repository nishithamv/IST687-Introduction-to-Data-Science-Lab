###############
#IST 687, Data Viz: using ggplot and ggmap
#
#Student name: Nishitha Maniganahalli Venkatesh
#Homework number: 07
#Date due: 10/14/2019
#
#I did this work by myself, with the help of the book and the professor

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Homework") #set working directory

#installing and librarying ggplot2 package
#install.packages("ggplot2")
library(ggplot2)

#installing and librarying zipcode package
#install.packages("zipcode")
library(zipcode)

#installing and librarying ggmap package
#install.packages("ggmap")
library(ggmap)

#installing and librarying maps package
#install.packages("maps")
library(maps)

#installing and librarying tidyverse package
#install.packages("mapproj")
library(mapproj)

#installing and librarying tidyverse package
#install.packages("tidyverse")
library(tidyverse)


#loading median income data
mydata <- read_csv("MedianZIP.csv") #reading the csv file into mydata dataframe
View(mydata) #viewing mydata dataframe
#zip: ZIP code of an area
#Median: median income in the area
#Mean: mean income in the area
#Pop: population in the area


#merging the median income data with the detailed zipcode data

mydata$zip <- clean.zipcodes(mydata$zip) 
#cleaning up zip codes by prefixing 0 to zip where zip is not 5-digit 
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

stateNameDF$stateName <- tolower(stateNameDF$stateName) #converting stateName observations to lower case
View(stateNameDF) #viewing the new dataframe

df <- merge(stateNameDF, dfNew, by = "state") 
#merging stateNameDF and dfNew dataframes by state into a new dataframe df
View(df) #viewing the new dataframe



#step 1: plotting points for each zipcode


#1A and 1B. creating a map with point at each zipcode and color represents mean


us <- map_data("state") #getting state coordinates data into us dataframe

dotmap <- ggplot(df, aes(map_id = stateName)) 
#initializing a ggplot object for df dataframe with stateName as map id
dotmap <- dotmap + geom_map(map = us) #creating a map with coordinates values in us dataframe
dotmap <- dotmap + geom_point(aes(x = longitude, y = latitude, color = Mean)) 
#creating a scatter plot with x as longitude and y as latitude of each zipcode and color as Mean
dotmap #viewing the plot


#1C. criticizing the resulting map


#the map generated is not good as it is distorted 
#since there is a data point for each zipcode the map is very crowded and it is not very informative
#also the data points in Alaska and Hawaii do not provide anyuseful information



#step 2: using tidyverse to create a dataframe of state-by-state income


#2A and 2B. creating a new dataframe


summaryDF <- df %>% #piping df dataframe
  group_by(stateName) %>% #grouping instances by stateName
  summarise(totalPop = sum(Pop), Income = sum(Mean*Pop)) 
#summarizing total population as sum of Pop for that state 
#and income as sum of product of Mean and Pop for that state

View(summaryDF) #viewing the dataframe
#the new dataframe has 50 rows, one for each US state
# the dataframe is created by grouping the entries by stateName so observations of each state are together
#then summarizing the data


#2C. finding average income for each state


summaryDF$meanIncome <- summaryDF$Income/summaryDF$totalPop #computing mean income per state
View(summaryDF) #viewing the updated dataframe



#step 3: creating a map of the US showing average income


#3A. creating a map visualization, where the color of each state represents the mean income for that state


map1 <- ggplot(summaryDF, aes(map_id = stateName))
#initializing a ggplot object for summaryDF dataframe with stateName as map id
map1 <- map1 + geom_map(map = us, aes(fill = meanIncome))
#creating a map with coordinates values in us dataframe and filling states with corresponding mean income
map1 <- map1 + expand_limits(x = us$long, y = us$lat)
#expanding the range of axes by setting x range to long and y range to lat in us dataframe 
map1 <- map1 + coord_map() + ggtitle("state average income")
#setting the aspect ratio and adding title to the map
map1 #viewing the map
  


#3C. why some states are in grey


#some states are in grey as Mean contains NAs
#this can be fixed by replacing NAs in df dataframe with Median value for that observation


#3D. fixing the above issue so that all states have an appropriate shade of blue


df$Mean[is.na(df$Mean)] <- df$Median[is.na(df$Mean)] 
#in df dataframe, replacing NAs in Mean with Median

summaryDF$Income <- sum(df$Mean*df$Pop) #computing total income for each state
summaryDF$meanIncome <- summaryDF$Income/summaryDF$totalPop #computing average income for each state

View(summaryDF) #viewing the updated dataframe
  
map2 <- ggplot(summaryDF, aes(map_id = stateName)) 
#initializing a ggplot object for summaryDF dataframe with stateName as map id
map2 <- map2 + geom_map(map = us, aes(fill = meanIncome))
#creating a map with coordinates values in us dataframe and filling states with corresponding mean income
map2 <- map2 + expand_limits(x = us$long, y = us$lat)
#expanding the range of axes by setting x range to long and y range to lat in us dataframe
map2 <- map2 + coord_map() + ggtitle("state average income")
#setting the aspect ratio and adding title to the map
map2 #viewing the map



#step 4: showing the population of each state on the map


#4A. merging stateName dataframe and summaryDF dataframe


newSummaryDF <- merge(summaryDF, stateNameDF, by = "stateName")
#merging summaryDF and stateNameDF dataframes by stateName into a new dataframe newSummaryDF
View(newSummaryDF) #viewing the new dataframe


#4B. creating a new map visualization 


map3 <- ggplot(newSummaryDF, aes(map_id = stateName))
#initializing a ggplot object for newSummaryDF dataframe with stateName as map id
map3 <- map3 + geom_map(map = us, aes(fill = meanIncome))
#creating a map with coordinates values in us dataframe and filling states with corresponding mean income
map3 <- map3 + expand_limits(x = us$long, y = us$lat)
#expanding the range of axes by setting x range to long and y range to lat in us dataframe
map3 <- map3 + geom_point(aes(x = center.x, y = center.y, size = totalPop))
#adding point at the center of each state and size of the point represents total population of that state
map3 <- map3 + coord_map() + ggtitle("state population and average income")
#setting the aspect ratio and adding title to the map
map3 #viewing the map
