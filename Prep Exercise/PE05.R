###############
#IST 687, JSON and Lists
#
#Student name: Nishitha Maniganahalli Venkatesh
#Prep exercise number: 05
#Date due: 09/25/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Prep Exercise") #set working directory

#installing RCurl and jsonlite packages
#install.packages("RCurl")
library(RCurl)
#install.packages("jsonlite")
library(jsonlite)

#reading JSON
dataset <- getURL("https://opendata.maryland.gov/resource/pdvh-tf2u.json") #retrieving the result of the webpage
df <- jsonlite::fromJSON(dataset) #converting JSON data into a dataframe

#exploring the dataframe
View(df) #viewing the dataframe
length(df$case_number) #number of accidents
length(unique(df$case_number)) #number of unique accidents
length(df$case_number[duplicated(df$case_number)]) #number of duplicate entires
str(df) #displaying the structure of df dataframe
