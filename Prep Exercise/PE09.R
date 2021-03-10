###############
#IST 687, Associated Rules Mining
#
#Student name: Nishitha Maniganahalli Venkatesh
#Prep exercise number: 09
#Date due: 10/30/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Prep Exercise") #set working directory

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

#viewing the newly created dataframe
View(badboat)
