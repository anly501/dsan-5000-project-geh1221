#load data
data <- read.csv("../../data/00-raw-data/team_records.csv")
library(tidyverse)

#check for missing values
sum(is.na(data))


#remove unnecessary columns and change column names
data <- subset(data, select=c(X,PTS, PP, PPO, PP., PPA, PPOA, PK.))
colnames(data) <- c("team","points", "ppGoals","ppOpps","ppPercent","pkGoalsAgainst","pkOppsAgainst","pkPercent")

#change team names to match other datasets
data$team <- c("BOS","CAR","NJD","VGK","TOR","COL","EDM","DAL","NYR","LAK","MIN","SEA","TBL","WPG","CGY","NYI","FLA","NSH","BUF","PIT","OTT","VAN","STL","WSH","DET","PHI","ARI","MTL","SJS","CHI","CBJ","ANA")


#save cleaned data
write.csv(data, "../../data/01-modified-data/team_record_clean.csv")
