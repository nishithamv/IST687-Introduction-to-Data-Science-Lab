###############
#IST 687, Sentiment Analysis
#
#Student name: Nishitha Maniganahalli Venkatesh
#Homework number: 10
#Date due: 11/21/2019
#
#I did this work by myself, with the help of the book

dev.off() #clear the graph window
cat('\014')  #clear the console
rm(list=ls()) #clear all user objects from the environment

setwd("~/Desktop/IST687/Homework") #set working directory

#installing and librarying tm package
#install.packages("tm")
library(tm)

#installing and librarying ggplot package
#install.packages("ggplot2")
library(ggplot2)

#installing and librarying tidyverse
#install.packages("tidyverse")
library(tidyverse)

#loading the data

#reading the speech.txt file
charVector <- scan("speech.txt", character(0), sep = "\n")

#reading the positive-words.txt file
posWords <- scan("positive-words.txt", character(0), sep = "\n")

#reading the negative-words.txt file
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
#creating a vector source which interprets each element of the vector as a document
words.vec <- VectorSource(charVector)
#creating a bag of words
words.corpus <- Corpus(words.vec)
#converting the bag of words to lower case
words.corpus <- tm_map(words.corpus, content_transformer(tolower))
#removing punctuation marks, numbers and stop words in English from the bag of words
words.corpus <- tm_map(words.corpus, removePunctuation)
words.corpus <- tm_map(words.corpus, removeNumbers)
words.corpus <- tm_map(words.corpus, removeWords, stopwords("english"))

#creating a TermDocumentMatrix
tdm <- TermDocumentMatrix(words.corpus)

#understanding the term document matrix

#inspecting the tdm
inspect(tdm)
#provides information about non-sparse entries, sparsity and weighting of the term document matrix



#step 1: creating a list of word counts from the speech


#1A. creating a named list of word counts by frequency, then sorting it


#creating a matrix for the tdm
m <- as.matrix(tdm)
#computing frequency of all terms in different documents
wordCounts <- rowSums(m)
#sorting the wordCounts in descending order
wordCounts <- sort(wordCounts, decreasing = TRUE)


#1B. viewing the wordCounts


head(wordCounts)
#shows the top words along with their frequency of occurence in the documents
#"will" occured 58 times


#1C. unique words in the speech


uniqueWords <- length(wordCounts)
uniqueWords
#there are 1211 unique words in the speech




#1D. total words in the speech


totalWords <- sum(wordCounts)
totalWords
#the speech has a total of 2762 words




#step 2: matching the speech words with positive and negative words


#2A.matching the words from the speech to the list of positive words


matchedP <- match(names(wordCounts), posWords, nomatch = 0)
#finding the index in posWords that has the first occurrence of words in document 
#if there is no match 0 is returened


#2B. matching the speech to the negative words


matchedN <- match(names(wordCounts), negWords, nomatch = 0)
#finding the index in negWords that has the first occurrence of words in the document
#if there is no match 0 is returened


#2C. information about matchedP


#matchedP is a vector of indices in posWords 
length(matchedP)
#the vector has 1211 elements
#if the words in the document is present in posWords
#then the index of the first occurrence of the word is stored in matchedP, else 0 is stored



#step 3: making bar charts of the words that matched


#3A. making a bar chart of the positive matches using ggplot


#creating a dataframe of different words in the documents, wordCounts and matchedP value
posMatch <- data.frame(names(wordCounts), wordCounts, matchedP)
#renaming first column
names(posMatch)[1] <- "positiveWords"
#removing non-matched words
posMatch <-posMatch %>%
  filter(matchedP != 0)
#viewing the positive words in the documents along with their frequencies
View(posMatch)

#creating a bar graph of postive words in the documents and their frequency
posGraph <- posMatch %>% #piping posMatch dataframe using tidyverse
  ggplot() + #initializing a ggplot object
  aes(x = positiveWords, y = wordCounts) + #setting x-axis to positive words and y-axis to their frequency in the documents
  geom_col() + #creating a bar graph
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + #rotating x-axis labels by 90 degree and justifying them right horizontally
  ggtitle("Positive words frequency in the documents") #addng title to the plot
posGraph #viewing the graph


#3B. using ggplot to create a bar chart of the top 20 negative matches


negMatch <- data.frame(names(wordCounts), wordCounts, matchedN)
#renaming first column
names(negMatch)[1] <- "negativeWords"
#removing non-matched words
negMatch <-negMatch %>%
  filter(matchedN != 0)
#viewing the negative words in the documents along with their frequencies
View(negMatch)

#creating a bar graph of negative words in the documents and their frequency
negGraph <- negMatch %>% #piping negMatch dataframe using tidyverse
  slice(1:20) %>% #piping the top 20 negative words to ggplot
  ggplot() + #initializing a ggplot object
  aes(x = reorder(negativeWords, -wordCounts), y = wordCounts) + #setting x-axis to negative words and y-axis to their frequency in the documents
  geom_col() + #creating a bar graph
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + #rotating x-axis labels by 90 degree and justifying them right horizontally
  ggtitle("Top 20 negaitive words frequency in the documents") #addng title to the plot
negGraph #viewing the graph


#3C. creating bar charts that only shows the negative, and positive words, that occurred at least twice


#creating a bar graph of positive words that occurred at least twice
posGraph2 <- posMatch %>% #piping posMatch dataframe using tidyverse
  filter(wordCounts > 1) %>% #piping the words that occurred more than once
  ggplot() + #initializing a ggplot object
  aes(x = positiveWords, y = wordCounts) + #setting x-axis to pisitive words and y-axis to their frequency in the documents
  geom_col() + #creating a bar graph
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + #rotating x-axis labels by 90 degree and justifying them right horizontally
  ggtitle("Positive words that occurred at least twice") #addng title to the plot
posGraph2 #viewing the graph

#creating a bar graph of negative words that occurred at least twice
negGraph2 <- negMatch %>% #piping negMatch dataframe using tidyverse
  filter(wordCounts > 1) %>% #piping the words that occurred more than once
  ggplot() + #initializing a ggplot object
  aes(x = negativeWords, y = wordCounts) + #setting x-axis to negative words and y-axis to their frequency in the documents
  geom_col() + #creating a bar graph
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + #rotating x-axis labels by 90 degree and justifying them right horizontally
  ggtitle("Negaitive words that occurred at least twice") #addng title to the plot
negGraph2 #viewing the graph


#3D. calculating the proportion of positive and negative words relative to the total number of words in the speech


#positive words ratio is the sum of positive words frequency by total number of words in the speech
positiveRatio <- sum(posMatch$wordCounts)/totalWords
positiveRatio
#0.078 is the proportion of positive words in the speech

#negative words ratio is the sum of negative words frequency by total number of words in the speech
negativeRatio <- sum(negMatch$wordCounts)/totalWords
negativeRatio
# 0.039 is the proportion of negative words in the speech

#the speech is positive
#as the proportion of positive words is greater than the proportion of negative words in the speech
