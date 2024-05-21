#loads birth control dataset in. read README.md for more info on the data used.
library(tidyverse)
library(dplyr)
library(stringr)

contraceptives <- read.csv("C:/Users/sowas/Downloads/INFO 201/birth_control_data.csv")

# SEDBC is whether they received sex education before age 18
# sex_ed_used is which participants received sex ed and have used contraceptives
sex_ed_used <- contraceptives %>%
  filter(SEDBC == 1) %>%
  filter(EVERUSED == 1) %>%
  group_by(SEDBC)

# participants that did not receive sex ed and have used contraceptives
no_sex_ed_used <- contraceptives %>%
  filter(SEDBC == 5) %>%
  filter(EVERUSED == 1) %>%
  group_by(SEDBC)

print(nrow(sex_ed_used))
print(nrow(no_sex_ed_used))
