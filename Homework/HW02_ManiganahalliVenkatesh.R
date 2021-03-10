###############
#IST 687, Data Analysis
#
#Student name: Nishitha Maniganahalli Venkatesh
#Homework number: 02
#Date due: 09/09/2019
#
#I did this work by myself, with the help of the book and the professor

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Homework") #set working directory

#creating a dataframe using the 'USArrests' dataset
myArrests <- USArrests

#exploring the myArrests dataframe
summary(myArrests) #obtaining summary of myArrests dataframe
View(myArrests) #viewing myArrests dataframe

#exploring the assault rate
#lower assault rate is the best
meanAssault <- mean(myArrests$Assault) #computing mean assault rate
meanAssault
lowAssault <- rownames(myArrests[which.min(myArrests$Assault),]) #determining the state with lowest assault rate
lowAssault

#exploring the murder rate
highMurder <- rownames(myArrests[which.max(myArrests$Murder),]) #determining the state with highest murder rate
highMurder
sortedMurder <- myArrests[order(myArrests$Murder, decreasing = TRUE),] #sorting myArrests dataframe in decreasing order of murder rate
rownames(head(sortedMurder, 10)) #displaying 10 states with highest murder rate

#safest state
#assault, murder and rape attributes can be used to determine the safest state
#add, average
#combining the attributes to determine safest state
myArrests$TotalCrime <- myArrests$Assault + myArrests$Murder + myArrests$Rape #calculating the total crime
View(myArrests) #viewing the new column
safestState <- rownames(myArrests[which.min(myArrests$TotalCrime),]) #finding the safest state based on total crime
safestState

#in depth look at the state with “best” combination of the arrest attributes
myArrests$SafeIndex <- 2*scale(myArrests$Murder) + scale(myArrests$Assault) + 2*scale(myArrests$Rape) #computing safe index
View(myArrests) #viewing the new column
sortedSafeIndex <- myArrests[order(myArrests$SafeIndex, decreasing = FALSE),] #sorting myArrests dataframe in increasing order of safe index
rownames(head(sortedSafeIndex, 5)) #displaying 5 safest states based on safe index

#step 3 output
sortedMurder <- myArrests[order(myArrests$Murder, decreasing = FALSE),] #sorting myArrests dataframe in increasing order of murder rate
rownames(head(sortedMurder,5)) #displaying 5 safest states based on murder rate

#step 4 output
sortedTotalCrime <- myArrests[order(myArrests$TotalCrime, decreasing = FALSE),] #sorting myArrests dataframe in increasing order of total crime
rownames(head(sortedTotalCrime,5)) #displaying 5 safest states based on total crime

#output of step 4 does not support output of step 3
#only the first value of the output is same for both the steps
#step 3 determines safest states based on murder rate only, while step 4 determines safest states based on total crime (sum of assault, murder, rape) in each state

#using scale is important as it brings all values to the same level of magnitude