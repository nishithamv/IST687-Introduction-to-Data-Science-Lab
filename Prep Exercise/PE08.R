###############
#IST 687, Lining Up Our Models (Linear Modeling)
#
#Student name: Nishitha Maniganahalli Venkatesh
#Prep exercise number: 08
#Date due: 10/16/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Prep Exercise") #set working directory

#installing and librarying readxl package
#install.packages("readxl")
library(readxl)


#reading data directly from URL

#storing the URL into a variable
url <- "http://college.cengage.com/mathematics/brase/understandable_statistics/7e/students/datasets/mlr/excel/mlr01.xls"

#dowlnoading the file from URL and storing it in a temporary  file PE08ExcelFile.xls
download.file(url, "PE08ExcelFile.xls") 

#reading the downloaded excel file into a new dataframe df
df <- read_excel("PE08ExcelFile.xls")
str(df) #viewing the internal structure of the new dataframe
View(df) #viewing the new dataframe

#X1: spring fawn count/100
#X2: size of adult antelope population/100
#X3: annual precipitation (inches)
#X4: winter severity index (1=mild, 5=severe)
#the data is for each year

#renaming the columns within the dataframe using two methods

#renaming the columns using combine
colnames(df) <- c("Spring Fawn", "Adult Antelope Population", "Anul Precipitation", "Winter Severity Index")
View(df) #viewing the updated dataframe

#renaming a specific column by specifying the name
colnames(df)[colnames(df) =="Anul Precipitation"] <- "Annual Precipitation"
View(df) #viewing the updated dataframe
