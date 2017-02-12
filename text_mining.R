
# Author: Alfredo Sanchez-Tojar, MPIO (Seewiesen) and ICL (Silwood Park), alfredo.tojar@gmail.com
# Github profile: https://github.com/ASanchez-Tojar

# Script created on the 12th of February, 2017

########################################################################################################
# Description of script and Instructions
########################################################################################################

# This script is to do text mining on my JAB paper. This script is adapted from:

#https://www.r-bloggers.com/text-mining-and-word-cloud-fundamentals-in-r-5-simple-steps-you-should-know/


########################################################################################################
# Packages needed
########################################################################################################

# packages needed

# # Install
# install.packages("tm")  # for text mining
# install.packages("SnowballC") # for text stemming
# install.packages("wordcloud") # word-cloud generator 
# install.packages("RColorBrewer") # color palettes

# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")


# Clear memory and get to know where you are
rm(list=ls())
#getwd()

#importing text file
#text <- readLines(file.choose())
#text <- readLines("the_origin_of_species_Charles_Darwin.txt")
text <- readLines("Sanchez-Tojar_et_al_2016_Winter_territory_prospecting.txt")

#loading the data as a corpus
docs <- Corpus(VectorSource(text))

#inspect content
inspect(docs)


#transforming text: replacing special characters
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))

docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

#cleaning text

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# # Remove your own stop word
# # specify your stopwords as a character vector
# docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
# Remove punctuations
docs <- tm_map(docs, removePunctuation)
# Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)
# Text stemming
# docs <- tm_map(docs, stemDocument)

#building a term-document matrix
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
head(d, 10)


#generate the word cloud


tiff(#"Word_cloud_Origin_species_Darwin.tiff",
     "Sanchez-Tojar_et_al_2016_Winter_territory_prospecting.tiff",
     height=10, width=10,
     units='cm', compression="lzw", res=600)

set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=120, 
          #max.words=180, 
          random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

dev.off()

#exploring frequent terms
findFreqTerms(dtm, lowfreq = 20)

# finding associations between frequent terms, e.g. species
#findAssocs(dtm, terms = "selection", corlimit = 0.3)
findAssocs(dtm, terms = "territory", corlimit = 0.55)


# histogram of words
tiff(#"Word_count_Origin_species_Darwin.tiff",
     "Word_count_Sanchez-Tojar_et_al_2016_Winter_territory_prospecting.tiff", 
     height=10, width=10,
     units='cm', compression="lzw", res=600)

barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col ="chocolate1", 
        #main ="Most frequent words of:\nThe origin of the species\nCharles Darwin",
        main ="Most frequent words of:\nWinter territory prospecting is associated with\nlife-history stage but not activity in a passerine",
        ylab = "Frequency")

dev.off()