#load data
data2022 <- read.csv("../../data/00-raw-data/team_data_2022.csv")
library(tidyverse)

#check for missing values
sum(is.na(data2022))



#remove unnecessary columns and change column names
data2022 <- subset(data2022, select=c(team,situation, xGoalsPercentage,corsiPercentage,shotAttemptsFor,xGoalsFor,faceOffsWonFor,takeawaysFor,giveawaysFor,hitsFor,team,situation))

#filter non powerplay data
data2022<- data2022 %>% filter(situation=="5on4")


#add variable for points bracket
points_bracket <- c("mid_tier","over100","under80","under80","mid_tier","mid_tier","over100","mid_tier","mid_tier","over100","mid_tier","under80","mid_tier","mid_tier","over100","over100","over100","over100","under80","over100","over100","under80","under80","under80","over100","mid_tier","mid_tier","over100","over100","mid_tier","mid_tier","mid_tier")
data <- data2022 %>% mutate(points_cat=points_bracket)



#remove non-numerical data
data <- subset(data, select=-c(team,situation,team.1,situation.1))

#normalize numerical data
data<-mutate(data, xGoalsPercentage=xGoalsPercentage/mean(xGoalsPercentage), corsiPercentage=corsiPercentage/mean(corsiPercentage), shotAttemptsFor=shotAttemptsFor/mean(shotAttemptsFor), xGoalsFor=xGoalsFor/mean(xGoalsFor), faceOffsWonFor=faceOffsWonFor/mean(faceOffsWonFor), takeawaysFor=takeawaysFor/mean(takeawaysFor),giveawaysFor=giveawaysFor/mean(giveawaysFor),hitsFor=hitsFor/mean(hitsFor))

#save cleaned data
write.csv(data, "../../data/01-modified-data/team_pp_data_point_bracket_clean.csv")
