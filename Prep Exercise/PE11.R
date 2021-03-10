###############
#IST 687, Sentiment Analysis
#
#Student name: Nishitha Maniganahalli Venkatesh
#Prep exercise number: 11
#Date due: 11/13/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Prep Exercise") #set working directory

#installing and librarying tm package
#install.packages("tm")
library(tm)

#loading the data

#reading the speech.txt file into charVector vector
charVector <- scan("speech.txt", character(0), sep = "\n")

#reading the positive-words.txt file into posWords vector
posWords <- scan("positive-words.txt", character(0), sep = "\n")

#reading the negative-words.txt file into negWords vector
negWords <- scan("negative-words.txt", character(0), sep = "\n")

#removing header information from posWords
posWords <- posWords[-1:-34]

#removing header information from negWords
negWords <- negWords[-1:-34]

#condition the text file

#examining charVector
head(charVector)
summary(charVector)

#transforming charVector into a term document matrix

#creating a word corpus
words.vec <- VectorSource(charVector)
words.corpus <- Corpus(words.vec)
words.corpus <- tm_map(words.corpus, content_transformer(tolower))
words.corpus <- tm_map(words.corpus, removePunctuation)
words.corpus <- tm_map(words.corpus, removeNumbers)
words.corpus <- tm_map(words.corpus, removeWords, stopwords("english"))

#creating a TermDocumentMatrix
tdm <- TermDocumentMatrix(words.corpus)
tdm

#understanding the term document matrix

#inspecting the tdm
inspect(tdm)
