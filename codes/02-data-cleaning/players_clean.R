#load data
data <- read.csv("../../data/00-raw-data/skaters.csv")
library(tidyverse)

#check for missing values
sum(is.na(data))

#remove unnecessary columns and rename columns
data <- subset(data, select=c(playerId,season,name,team,position,situation,games_played,icetime,shifts,iceTimeRank,onIce_xGoalsPercentage,onIce_corsiPercentage,I_F_shotAttempts,I_F_points,I_F_goals,I_F_faceOffsWon,I_F_takeaways,I_F_giveaways,I_F_hits))
colnames(data) <- c("ID","season","name","team","position","situation","games_played","icetime","shifts","iceTimeRank","expectedGoals","corsi","shotAttempts","points","goals","faceoffsWon","takeways","giveaways","hits")

#remove players who played in fewer than half of the games in the season
data <- filter(data, games_played>=41)

#separate dataframes for regular play, power plays, and penalty kills
regular_player_data <- filter(data, situation=="5on5")
pp_player_data <- filter(data, situation=="5on4")
pk_player_data <- filter(data, situation=="4on5")

#save cleaned data
write.csv(regular_player_data, "../../data/01-modified-data/skaters_clean.csv")
write.csv(pp_player_data, "../../data/01-modified-data/skaters_pp.csv")
write.csv(pk_player_data, "../../data/01-modified-data/skaters_pk.csv")
