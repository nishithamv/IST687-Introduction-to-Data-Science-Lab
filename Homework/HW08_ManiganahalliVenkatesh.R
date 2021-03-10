###############
#IST 687, Linear Modeling
#
#Student name: Nishitha Maniganahalli Venkatesh
#Homework number: 08
#Date due: 10/21/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Homework") #set working directory

#installing and librarying readxl package
#install.packages("readxl")
library(readxl)

#installing ggplot2 package
#install.packages("ggplot2")
library(ggplot2)

#installing tidyverse package
#install.packages("tidyverse)
library(tidyverse)

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
colnames(df) <- c("SpringFawnCount", "AdultAntelopePopulation", "AnulPrecipitation", "WinterSeverityIndex")
View(df) #viewing the updated dataframe

#renaming a specific column by specifying the name
colnames(df)[colnames(df) =="AnulPrecipitation"] <- "AnnualPrecipitation"
View(df) #viewing the updated dataframe



#step 1: visualizing a linear model


#1A. creating a bivariate plot of the number of baby fawns versus adult antelope population


bivPop <- df %>% #piping df data frame using tidyverse
  ggplot() + #initializing a ggplot object for df dataframe
  aes(x = AdultAntelopePopulation, y = SpringFawnCount) + #setting x-axis to antelope population and y-axis to fawn count
  geom_point() #creating a scatter plot
bivPop #viewing the plot

#observations from the plot:
#number of baby fawns is low when adult antelope population is low
#number of baby fawns is high when adult antelope population is high
#number of baby fawns increases with increase in antelope population


#1B. creating a bivariate plot of the number of baby fawns versus precipitation


bivPrecipitation <- df %>% #piping df data frame using tidyverse
  ggplot() + #initializing a ggplot object for df dataframe
  aes(x = AnnualPrecipitation, y = SpringFawnCount) + #setting x-axis to precipitation and y-axis to fawn count
  geom_point() #creating a scatter plot
bivPrecipitation #viewing the plot

#observations from the plot:
#number of baby fawns is low when annual precipitation is low
#number of baby fawns is high when annual precipitation is high
#number of baby fawns increases with increase in annual precipitation


#1C. creating a bivariate plot of the number of baby fawns versus severity of the winter 


bivWinter <- df %>% #piping df data frame using tidyverse
  ggplot() + #initializing a ggplot object for df dataframe
  aes(x = WinterSeverityIndex, y = SpringFawnCount) + #setting x-axis to severity of winter and y-axis to fawn count
  geom_point() #creating a scatter plot
bivWinter #viewing the plot

#observations from the plot:
#number of baby fawns is high when severity of winter is low
#number of baby fawns is low when severity of winter is high
#number of baby fawns decreases with increase in severity of winter


#step 2: creating a regression model


#2A. creating single regression model using independent variables 
#(adult antelope pop., precipitation that year, severity of winter)
#and dependent variable number of baby fawns


regModel <- lm(formula =SpringFawnCount ~ AdultAntelopePopulation + AnnualPrecipitation + WinterSeverityIndex, data = df )
#fitting a linear model for df dataframe with fawn count as dependent vaiable and
#antelope population, precipitation and severity of winter as independent variable
summary(regModel) #viewing summary of the linear model


#2B. R-squared value of the model and its significance to the model


#R-squared: 0.955

#R-squared value represents the proportion of variability that is accounted for the dependent variable 
#by the whole set of independent variables

#in the model above, about 95.5% of variability in number of baby fawns is accounted by 
#adult antelope population, annual precipitation and severity of winter


#2C. predictor that is most statistically significant


#AnnualPrecipitation is the most statistically significant predictor

#a predictor with p-value less than 0.05 is more statistically significant 



#step 3: interpreting the model


#3A. overall interpretation of the model


#antelope population, annual precipitation and severity of winter accounts for about 
#95.5% variability in number of baby fawns
#annual precipitation is statistically more significant predictor of number of baby fawns as it has
#a p-value of 0.0217 and severity of winter is statistically the less significant predictor as
#it has a p-value of 0.0366
#as a whole the regression model is a good predictor of number of baby fawns as the R-squared value
#(0.995) is closer to one


#3B. full multiple regression equation and interpreting the equation


#multiple regression equation:
#predicted SpringFawnCount = -5.92201 + 0.33822 * AdultAntelopePopulation + 0.40150 * AnnualPrecipitation + 0.26295 * WinterSeverityIndex

#interpreting the equation:
#when antelope population is 9.4, annual precipitation is 12.1 inches and severity of winter is 3, then
#number of baby fawns is predicted to be 2.90426
