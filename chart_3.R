library(dplyr)
library(tidyverse)
library(tidyr)
library(ggplot2)

contraceptives <- read.csv("C:/Users/sowas/Downloads/INFO 201/birth_control_data.csv")

# Add reasons codebook
reasons_text_2 <- c(
  "1: Birth control",
  "2: Cramps, or pain during menstrual periods",
  "3: Treatment for acne",
  "4: Treatment for endometriosis",
  "5: Other reasons",
  "6: To regulate your menstrual periods",
  "7: To reduce menstrual bleeding"
)

# Map the unique values to their corresponding year ranges
year_map <- function(yearRange) {
  case_when(
    yearRange == "610" ~ "2006-2010",
    yearRange == "1113" ~ "2011-2013",
    yearRange == "1315" ~ "2013-2015",
    TRUE ~ NA_character_
  )
}

# Apply the mapping function to create the "Year" column
contraceptives <- contraceptives %>%
  mutate(Year = year_map(yearRange)) %>%
  filter(YUSEPILL1 >= 1 & YUSEPILL1 <= 7)


# Create a pivot table
pivot_table <- contraceptives %>%
  group_by(Year, YUSEPILL1) %>%
  summarise(Frequency = n()) %>%
  pivot_wider(names_from = Year, values_from = Frequency, values_fill = 0)

# Reorder columns
pivot_table <- pivot_table[,c("2006-2010", "2011-2013", "2013-2015")]

# Display the pivot table
print(pivot_table)

pivot_table$YUSEPILL1 <- rownames(pivot_table)

# Reshape the data from wide to long format
pivot_long <- pivot_table %>%
  pivot_longer(cols = c("2006-2010", "2011-2013", "2013-2015"), names_to = "Year", values_to = "Frequency")

# Convert Year column to factor for correct ordering
pivot_long$Year <- factor(pivot_long$Year, levels = c("2006-2010", "2011-2013", "2013-2015"))

# Plot the line graph
ggplot(pivot_long, aes(x = Year, y = Frequency, group = YUSEPILL1, color = YUSEPILL1)) +
  geom_line(aes(group = YUSEPILL1)) +
  geom_point() +
  labs(title = "Reasons for Contraceptive Pill Use Over Years",
       x = "Year",
       y = "Frequency") +
  scale_color_manual(name = "Reasons for Use",
                     labels = reasons_text_2,
                     values = rainbow(length(reasons_text_2))) +
  theme_minimal()