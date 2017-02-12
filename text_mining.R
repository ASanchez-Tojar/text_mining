
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

# Install
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("wordcloud") # word-cloud generator 
install.packages("RColorBrewer") # color palettes

# Load
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")


# Clear memory and get to know where you are
rm(list=ls())
#getwd()
