###############
#IST 687, Associated Rules Mining
#
#Student name: Nishitha Maniganahalli Venkatesh
#Homework number: 09
#Date due: 11/04/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Homework") #set working directory

#installing and librarying arules package
#install.packages("arules")
library(arules)

#installing and librarying arulesViz package
#install.packages("arulesViz")
library(arulesViz)

#loading and verifying the titanic dataset

#importing titanic dataset titanic data
load("titanic.raw.rdata")

#loading the imported data into a dataframe
badboat <- titanic.raw



#step 1: exploring the dataset


#1A. viewing the badboat dataframe


View(badboat)
#the dataframe contains the information about 
#class of travel, age, sex and survival of the traveler
#the dataframe is not a sparse matrix


#1B. counting the people in each category of the Survived variable


surviveTable <- table(badboat$Class, badboat$Survived)
surviveTable
#viewing the number of people of each class who survived and who did not 


#1C. expressing the results of part B as percentages 

prop.table(surviveTable)
#vieiwng the proportion of people of each class who survived 


#1D. showing the percentages for Class, Sex, and Age variables


#vieiwng the proportions for Class variable
prop.table(table(badboat$Class))
#shows the proportion of people of different travel class

#vieiwng the proportions for Sex variable
prop.table(table(badboat$Sex))
#shows the proportion of people of different gender

#vieiwng the proportions for Age variable
prop.table(table(badboat$Age))
#shows the proportion of people of diiferent age groups


#1E. contingency table of percentages for the Age and Sex variables together


table(badboat$Age, badboat$Sex)
#vieiwng the frequency for Age and Sex variables
#this shows the frequency of people of different gender based on age group 



#step 2: coercing the data frame into transactions


#2A. coercing the badboat dataframe into a sparse transactions matrix 


badboatX <- as(badboat, "transactions")
#as() function takes two arguments, data object and class
#it coerces the object to a given class
#in the code above it coerces badboat dataframe into transactions in sparse format and stores it in badboatX


#2B. using the inspect(), itemFrequncy(), and itemFrequencyPlot() commands to explore badboatX


#inspect() command
inspect(badboatX)
#displays each of the rows as items along with their transactionID

#itemFrequency() command
itemFrequency(badboatX)
#dispays the support for all categories of Class, Sex, Age and Survived values

#itemFrequencyPlot() command
itemFrequencyPlot(badboatX)
#creates an item frequency bar plot


#2C. exploring the spare matrix data object 


View(badboatX)
#shows the data, itemInfo and itemsetInfo
#itemInfo has the distinct values for each of the variables in the data
#itemsetInfo has a list of dataframe rows and transactionId


#2D. difference between “badboat” and “badboatX”


#badboat is a dataframe with 2201 observations for 4 variables
#badboatX is set of transactions as itemMatrix in sparse format with 2201 transcations and 10 items
#badboat contains the actual data which is stored as factors
#badboatX contains the itemsets



#step 3: discovering patterns using association rule mining


#3A. running block of code


#using apriori to obtain association rules for transactions in badboatX
ruleset <- apriori(badboatX, 
#setting the minumum value of supprt and confidence to 0.5% and 50% respectively
          parameter = list(support = 0.005, confidence = 0.5), 
#specifying default appearance for lhs and "Survived=Yes" on rhs
#i.e., lhs can contain all the items and rhs should contain only "Survived=Yes"
          appearance = list(default = "lhs", rhs = ("Survived=Yes")))


#3B. using inspect() command to review the ruleset


inspect(ruleset)
#displays 14 rules with the lhs, rhs, support, confidence and lift
#along with the count (number of transactions in which lhs and rhs occured together)


#3C. experimenting with the interactive ruleset interface


inspectDT(ruleset)
#creates a HTML table widget for rules which cna be interactively filtered and sorted


#3D. if you were to be onboard the titanic, what kind of person would you have wanted to be? 


#if I were to be onboard the titanic, I would have wanted to be a Female
#as the support is 15.6% and confidence 73.2% based on rule [3]
#because the itemset in rule [3] has the highest frequency and a good predictive power