###############
#IST 687, Exploring Dataframes
#
#Student name: Nishitha Maniganahalli Venkatesh
#Homework number: 05
#Date due: 09/30/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Homework") #set working directory

#installing RCurl and jsonlite packages
#install.packages("RCurl")
library(RCurl)
#install.packages("jsonlite")
library(jsonlite)

#installing tidyverse package
#install.packages("tidyverse")
library(tidyverse)

#reading JSON
dataset <- getURL("https://opendata.maryland.gov/resource/pdvh-tf2u.json") #retrieving the result of the webpage
df <- jsonlite::fromJSON(dataset) #converting JSON data into a dataframe

#exploring the dataframe
View(df) #viewing the dataframe
length(df$case_number) #number of accidents
length(unique(df$case_number)) #number of unique accidents
length(df$case_number[duplicated(df$case_number)]) #number of duplicate entires
str(df) #displaying the structure of df dataframe



#Question 1
#understand and documenting R code


#1A. convert vehicle count to numeric type

df$vehicle_count <- as.numeric(df$vehicle_count) #converting vehicle_count from character to numeric type
typeof(df$vehicle_count) #checking type of vehicle_count


#1B. using piping compute mean of number of vehicles that met with an accident on THURSDAY

value1 <- df %>%
  filter(str_trim(day_of_week)=="THURSDAY") %>% #removing whitespaces from day_of_week and getting those instances where it is "THURSDAY"
  pull(vehicle_count) %>% #obtaining vehicle_count for instances that satisfies the above condition
  mean(na.rm=TRUE) #calculating mean of vehicle_count by removing NAs
value1


#1C. compute mean of number of vehicles that met with an accident on THURSDAY 

#removing whitespances from day_of_week and computing the mean of vehicle_count by removing NAs for instances where day_of_week is "THURSDAY"
value2 <- mean(df$vehicle_count[str_trim(df$day_of_week)=="THURSDAY"], na.rm=TRUE)
value2



#Question 2
#investigating the dataframe


#2A. total number of accidents with injuries

NAsInjury <- length(df$injury[is.na(df$injury)]) #looking for NAs in injury
NAsInjury

totalInjury <- length(df$injury[df$injury=="YES"])#finding number of accidents where injury is "YES"
totalInjury


#2B. number of accidents on FRIDAY

NAsDay <- length(df$day_of_week[is.na(df$day_of_week)]) #looking for NAs in day_of_week
NAsDay

#removing whitespaces from day_of_week and finding number of accidents on FRIDAY
fridayAccident <- length(df$day_of_week[str_trim(df$day_of_week)=="FRIDAY"]) 
fridayAccident


#2C. total number of accidents on FRIDAY with injury="YES"

#counting number of accidents with day_of_week="FRIDAY" and injury="YES"
fridayInjury <- length(df$case_number[(str_trim(df$day_of_week)=="FRIDAY") & (df$injury=="YES")]==TRUE)
fridayInjury


#2D. number of accidents on FRIDAY with injury="NO"

#total number of accidents on FRIDAY minus number of accidents on FRIDAY with injury="YES"
fridayNoInjury <- fridayAccident - fridayInjury 
fridayNoInjury


#2E. finding number of injuries each day of the week

#determining number of injuries each day of the week using piping
injuriesEachDay <- df %>%
  group_by(day=str_trim(day_of_week)) %>% #removing whitespaces from day_of_week and grouping the instances by day_of_week
  filter(str_trim(injury)=="YES") %>% #obtaining thpse instances with injury
  summarise(injuries=length(day_of_week)) #summarizing number of accidents each day of the week
injuriesEachDay


#2F. creating a new dataframe that includes accidents only on FRIDAY

fridayAccidents <- df[str_trim(df$day_of_week)=="FRIDAY",] #copying those records in df where day_of_week is FRIDAY
row.names(fridayAccidents) <- NULL #resettiing row name
View(fridayAccidents) #viewing the newly created dataframe


#2G. mean number of vehicles involved in accidents on FRIDAY

NAsFriday <- length(fridayAccidents$vehicle_count[is.na(fridayAccidents$vehicle_count)]) #looking for NAs in vehicle_count
NAsFriday

#computing the mean of vehicle_count by ignoring NAs and rounding it off to the closest integer value
fridayNARound <- round(mean(fridayAccidents$vehicle_count, na.rm = TRUE))
fridayNARound

#replacing NAs in vehicle_count with the round off mean value of vehicle_count
fridayAccidents$vehicle_count[is.na(fridayAccidents$vehicle_count)] <- fridayNARound
View(fridayAccidents) #viewing the updated dataframe

meanVehiclesFriday <- mean(fridayAccidents$vehicle_count) #computing the mean of updated vehicle_count
meanVehiclesFriday


#2H. histogram for number of vehicles in accident on FRIDAY

hist(fridayAccidents$vehicle_count, breaks = 5) #creating a histogram for vehicle_count


#2I. distribution of number of vehicles on SUNDAY

#creating a new dataframe that includes accidents only on SUNDAY
sundayAccidents <- df[str_trim(df$day_of_week)=="SUNDAY",] #copying those records in df where day_of_week is SUNDAY
row.names(sundayAccidents) <- NULL #resetting row name
View(sundayAccidents) #viewing hte newly created dataframe

NAsSunday <- length(sundayAccidents$vehicle_count[is.na(sundayAccidents$vehicle_count)]) #looking for NAs in vehicle_count
NAsSunday

#computing the mean of vehicle_count by ignoring NAs and rounding it off to the closest integer value
sundayNARound <- round(mean(sundayAccidents$vehicle_count, na.rm = TRUE))
sundayNARound

#replacing NAs in vehicle_count with the round off mean value of vehicle_count
sundayAccidents$vehicle_count[is.na(sundayAccidents$vehicle_count)] <- sundayNARound
View(sundayAccidents) #viewing the updataded dataframe

#creating a histogram for vehicles in accident on SUNDAY
hist(sundayAccidents$vehicle_count, breaks = 4)

quantile(sundayAccidents$vehicle_count) #checking quantiles for number of vehicles
#75% of the accidents involved less than 2 vehicles


#2J. distribution on SUNDAY compared with the distribution of the number of vehicles in accidents on FRIDAY

# most of the accidents on Friday and Sunday involved less than 2 vehicles
#around 20 accidents on Friday involved less than 3 vehicles
#less than 10 aaccidents on Sunday involved 2 to 3 vehicles
#very few accidents on Friday and Sunday involved more than 3 vehicles
