#loads birth control dataset in. read README.md for more info on the data used.
library(tidyverse)
library(dplyr)
library(stringr)

contraceptives <- read.csv("C:/Users/sowas/Downloads/INFO 201/birth_control_data.csv")

summary_info <- list()
# number of data columns/questions asked
summary_info$num_observations <- ncol(contraceptives)
# number of participants
summary_info$num_participants <- nrow(contraceptives)
#average age of participants
summary_info$avg_age <- contraceptives %>%
  filter(!is.na(AGE_R)) %>%
  pull(AGE_R) %>%
  mean()
# percent of participants that have had sex
had_sex <- contraceptives$RHADSEX
sex_yes <- sum(had_sex == 1)
sex_no <- sum(had_sex == 5)
percent_had_sex <- (sex_yes / (sex_yes + sex_no))

summary_info$had_sex <- percent_had_sex
# percent that have used any contraception ever
ever <- contraceptives$EVERUSED
len_ever <- length(ever)
ever_yes <- sum(ever == 1) # have used contraception
ever_no <- sum(ever == 5) # have not
percent_ever <- ever_yes / (ever_yes + ever_no)

summary_info$used_ever <- percent_ever

print(summary_info)
