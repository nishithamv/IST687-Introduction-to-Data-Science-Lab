###############
#IST 687, Dataframes and Modeling
#
#Student name: Nishitha Maniganahalli Venkatesh
#Prep exercise number: 02
#Date due: 09/04/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Prep Exercise") #set working directory

#creating a dataframe using the 'USArrests' dataset
myArrests <- USArrests

View(myArrests) #viewing the contents of myArrests dataframe

summary(myArrests) #obtaining summary of myArrests dataframe

#creating own dataframe
myFamilyNames <- c("Mom", "Dad", "Brother", "Sister") #creating name vector
myFamilyAges <- c("48", "52" ,"9", "20") #creating age vector
myFamilyEyeColor <- c("Black", "Brown", "Black", "Blue") #creating eye color vector
myFamily <- data.frame(myFamilyNames, myFamilyAges, myFamilyEyeColor) #combining the vectors into a dataframe

str(myFamily) #determining the structure of myFamily dataframe
View(myFamily) #viewing the contents of myFamily dataframe

#removing rows and columns within a dataframe
myFamily <- myFamily[-3,] #removing third row in myFamily dataframe
myFamily <- myFamily[,-3] #removing eye color column in myFamily dataframe
View(myFamily) #viewing the contents of myFamily dataframe