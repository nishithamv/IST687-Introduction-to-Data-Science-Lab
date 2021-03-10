###############
#IST 687, Intro to R
#
#Student name: Nishitha Maniganahalli Venkatesh
#Homework number: 01
#Date due: 09/02/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/MyDesktop/IST687/Homework") #set working directory

#defining vectors
height <- c(59,60,61,58,67,72,70) #height in inches
weight <- c(150,140,180,220,160,140,130) #weight in pounds

#defining a variable
a <- 150

mean(height) #average height
mean(weight) #average weight

b <- length(height) #number of observations in height
c <- length(weight) #number of observations in weight
d <- sum(height) #sum of the heights
e <- sum(weight) #sum of the weights

d/b #average height
e/c #average weight

#using min/max function
maxH <- max(height) #maximum height
maxH
minW <- min(weight) #minimum weight
minW

#vector math
extraWeight <- weight + 25 #adding extra 25 pounds to each weight
extraWeight
mean(extraWeight) #average extra weight

#using conditional if statements
if (maxH > 70) "yes" else "no" #checking if maximum height is greater than 70
if(minW > a) "yes" else "no" #checking if minimum weight is greater than 150 (i.e.,a)

#practice with vectors
bigHT <- height[height>60] #height values greater than 60
bigHT
smallWT <- c(weight[2], weight[4]) #second and fourth weight values
smallWT
weight <- weight[-3] #removing the third weight value
weight
height(3) #this throws an error as there is no predefined function "height"