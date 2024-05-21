library(ggplot2)
library(stringr)

contraceptives <- read.csv("C:/Users/sowas/Downloads/INFO 201/birth_control_data.csv")

# data about use of different contraceptives
# percent that have used pill ever
pill <- contraceptives$PILL
pill_yes <- sum(pill == 1) # yes
pill_no <- sum(pill == 5) # no
percent_pill <- pill_yes / (pill_yes + pill_no)

# percent that have used patch ever
patch <- contraceptives$PATCH
patch_yes <- sum(patch == 1) # yes
patch_no <- sum(patch == 5) # no
percent_patch <- patch_yes / (patch_yes + patch_no)

# percent that have used ring ever
ring <- contraceptives$RING
ring_yes <- sum(ring == 1) # yes
ring_no <- sum(ring == 5) # no
percent_ring <- ring_yes / (ring_yes + ring_no)

# percent that have used condoms ever
condoms <- contraceptives$CONDOM
# changing all N/A values (inapplicable) to 'refused' (8) for relevancy purposes
condoms <- replace(contraceptives$CONDOM, is.na(contraceptives$CONDOM), 8)
condoms_yes <- sum(condoms == 1) # have used condoms
condoms_no <- sum(condoms == 5)
percent_condoms <- condoms_yes / (condoms_yes + condoms_no)

# percent that have used withdrawal method
withdrawal <- contraceptives$WIDRAWAL
withdrawal <- replace(contraceptives$WIDRAWAL, is.na(contraceptives$WIDRAWAL
), 8)
withdrawal_yes <- sum(withdrawal == 1)
withdrawal_no <- sum(withdrawal ==5)
percent_withdrawal <- withdrawal_yes / (withdrawal_yes + withdrawal_no)


# prepare for visualization
contraceptives_data <- data.frame(
  method = factor(c("Condoms", "Pill", "Withdrawal", "Patch", "Ring"), levels = c("Condoms", "Pill", "Withdrawal", "Patch", "Ring")),
  percentage_used = c(percent_condoms, percent_pill, percent_withdrawal, percent_patch, percent_ring) * 100
)

# Create the bar chart
bar_chart <- ggplot(contraceptives_data, aes(x = method, y = percentage_used)) +
  geom_bar(stat = "identity") +
  labs(title = "Use of Contraceptive Methods",
       x = "Contraceptive Method",
       y = "Percentage Used (%)")
  
print(bar_chart)
