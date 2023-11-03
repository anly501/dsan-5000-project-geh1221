#load data
data2022 <- read.csv("../../data/00-raw-data/team_data_2022.csv")
data2021 <- read.csv("../../data/00-raw-data/team_data_2021.csv")
data2020 <- read.csv("../../data/00-raw-data/team_data_2020.csv")
data2018 <- read.csv("../../data/00-raw-data/team_data_2018.csv")
library(tidyverse)

#check for missing values
sum(is.na(data2022))
sum(is.na(data2021))
sum(is.na(data2020))
sum(is.na(data2018))


#remove unnecessary columns and change column names
data2022 <- subset(data2022, select=c(team,situation, xGoalsPercentage,corsiPercentage,shotAttemptsFor,xGoalsFor,faceOffsWonFor,takeawaysFor,giveawaysFor,hitsFor,team,situation))
data2021 <- subset(data2021, select=c(team,situation, xGoalsPercentage,corsiPercentage,shotAttemptsFor,xGoalsFor,faceOffsWonFor,takeawaysFor,giveawaysFor,hitsFor,team,situation))
data2020 <- subset(data2020, select=c(team,situation, xGoalsPercentage,corsiPercentage,shotAttemptsFor,xGoalsFor,faceOffsWonFor,takeawaysFor,giveawaysFor,hitsFor,team,situation))
data2018 <- subset(data2018, select=c(team,situation, xGoalsPercentage,corsiPercentage,shotAttemptsFor,xGoalsFor,faceOffsWonFor,takeawaysFor,giveawaysFor,hitsFor,team,situation))

#filter non powerplay data
data2022<- data2022 %>% filter(situation=="5on4")
data2021<- data2021 %>% filter(situation=="5on4")
data2020<- data2020 %>% filter(situation=="5on4")
data2018<- data2018 %>% filter(situation=="5on4")

#add variable for playoff teams
playoff_teams_2018 <- c("T.B","BOS","TOR","WSH","NYI","PIT","CAR","CBJ","NSH","WPG","STL","DAL","COL","CGY","S.J","VGK")
playoff_teams_2020 <- c("CAR","FLA","T.B","NSH","PIT","WSH","BOS","NYI","TOR","EDM","WPG","MTL","COL","VGK","MIN","STL")
playoff_teams_2021 <- c("FLA","TOR","TBL","BOS","CAR","NYR","PIT","WSH","COL","MIN","STL","DAL","NSH","CGY","EDM","LAK")
playoff_teams_2022 <- c("BOS","TOR","TBL","FLA","CAR","NJD","NYR","NYI","COL","DAL","MIN","WPG","VGK","EDM","LAK","SEA")

data2022$playoff <- NA
data2021$playoff <- NA
data2020$playoff <- NA
data2018$playoff <- NA

data2022<-data2022 %>% mutate(playoff = ifelse(team %in% playoff_teams_2022,"Y","N"))
data2021<-data2021 %>% mutate(playoff = ifelse(team %in% playoff_teams_2021,"Y","N"))
data2020<-data2020 %>% mutate(playoff = ifelse(team %in% playoff_teams_2020,"Y","N"))
data2018<-data2018 %>% mutate(playoff = ifelse(team %in% playoff_teams_2018,"Y","N"))



#combine datasets
data <- rbind(data2022, data2021, data2020, data2018)

#remove non-numerical data
data <- subset(data, select=-c(team,situation,team.1,situation.1))

#normalize numerical data
data<-mutate(data, xGoalsPercentage=xGoalsPercentage/mean(xGoalsPercentage), corsiPercentage=corsiPercentage/mean(corsiPercentage), shotAttemptsFor=shotAttemptsFor/mean(shotAttemptsFor), xGoalsFor=xGoalsFor/mean(xGoalsFor), faceOffsWonFor=faceOffsWonFor/mean(faceOffsWonFor), takeawaysFor=takeawaysFor/mean(takeawaysFor),giveawaysFor=giveawaysFor/mean(giveawaysFor),hitsFor=hitsFor/mean(hitsFor))

#save cleaned data
write.csv(data, "../../data/01-modified-data/team_pp_data_clean.csv")
