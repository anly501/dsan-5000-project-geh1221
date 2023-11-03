#load data
data <- read.csv("../../data/00-raw-data/team_data.csv")
library(tidyverse)

#check for missing values
sum(is.na(data))


#remove unnecessary columns and change column names
data <- subset(data, select=c(situation, xGoalsPercentage,corsiPercentage,shotAttemptsFor,xGoalsFor,faceOffsWonFor,takeawaysFor,giveawaysFor,hitsFor,team,situation))

#filter non powerplay data
data<- data %>% filter(situation=="5on4")

#save cleaned data
write.csv(data, "../../data/01-modified-data/team_pp_data_clean.csv")
