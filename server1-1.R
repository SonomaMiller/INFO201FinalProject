library(ggplot2)
library(stringr)
library(dplyr)
library(tidyr)

contraceptives <- read.csv("C:/Users/sowas/Downloads/INFO201/INFO201FinalProject/birth_control_data.csv")


# Server logic for chart 1
server_chart1 <- function(input, output, session) {
  contraceptives <- read.csv("C:/Users/sowas/Downloads/INFO201/INFO201FinalProject/birth_control_data.csv")
  
  output$chart1 <- renderPlot({
    # Data about use of different contraceptives
    # Percent that have used pill ever
    pill <- contraceptives$PILL
    pill_yes <- sum(pill == 1, na.rm = TRUE) # yes
    pill_no <- sum(pill == 5, na.rm = TRUE) # no
    percent_pill <- pill_yes / (pill_yes + pill_no)
    
    # Percent that have used patch ever
    patch <- contraceptives$PATCH
    patch_yes <- sum(patch == 1, na.rm = TRUE) # yes
    patch_no <- sum(patch == 5, na.rm = TRUE) # no
    percent_patch <- patch_yes / (patch_yes + patch_no)
    
    # Percent that have used ring ever
    ring <- contraceptives$RING
    ring_yes <- sum(ring == 1, na.rm = TRUE) # yes
    ring_no <- sum(ring == 5, na.rm = TRUE) # no
    percent_ring <- ring_yes / (ring_yes + ring_no)
    
    # Percent that have used condoms ever
    condoms <- contraceptives$CONDOM
    condoms <- replace(contraceptives$CONDOM, is.na(contraceptives$CONDOM), 8)
    condoms_yes <- sum(condoms == 1, na.rm = TRUE) # have used condoms
    condoms_no <- sum(condoms == 5, na.rm = TRUE)
    percent_condoms <- condoms_yes / (condoms_yes + condoms_no)
    
    # Percent that have used withdrawal method
    withdrawal <- contraceptives$WIDRAWAL
    withdrawal <- replace(contraceptives$WIDRAWAL, is.na(contraceptives$WIDRAWAL), 8)
    withdrawal_yes <- sum(withdrawal == 1, na.rm = TRUE)
    withdrawal_no <- sum(withdrawal == 5, na.rm = TRUE)
    percent_withdrawal <- withdrawal_yes / (withdrawal_yes + withdrawal_no)
    
    # Prepare for visualization
    contraceptives_data <- data.frame(
      method = factor(c("Condoms", "Pill", "Withdrawal", "Patch", "Ring"), levels = c("Condoms", "Pill", "Withdrawal", "Patch", "Ring")),
      percentage_used = c(percent_condoms, percent_pill, percent_withdrawal, percent_patch, percent_ring) * 100
    )
    
    # Create the bar chart
    ggplot(contraceptives_data, aes(x = method, y = percentage_used)) +
      geom_bar(stat = "identity") +
      labs(title = "Use of Contraceptive Methods",
           x = "Contraceptive Method",
           y = "Percentage Used (%)")
  })
}

# Server logic for chart 2
server_chart2 <- function(input, output, session) {
  contraceptives <- read.csv("C:/Users/sowas/Downloads/INFO201/INFO201FinalProject/birth_control_data.csv")
  
  output$chart2 <- renderPlot({
    # most popular reasons people aren't using contraceptives
    
    why_not_using <- paste(contraceptives$WHYNOUSING1, contraceptives$WHYNOUSING2, 
                           contraceptives$WHYNOUSING3, contraceptives$WHYNOUSING4,
                           contraceptives$WHYNOUSING5)
    
    split_elements <- strsplit(why_not_using, " ")
    
    # Remove NA values from each split element
    why_not_using <- lapply(split_elements, function(x) {
      x <- x[!x %in% c("7", "8", "9", "98", "99", "NA")]
      return(x)
    })
    
    cleaned_vector <- unlist(why_not_using)
    frequency_table <- table(cleaned_vector)
    frequency_dict <- as.list(frequency_table)
    
    
    # visualize data
    reasons_data <- data.frame(
      Reason_Code = 1:6,
      Frequency = as.numeric(unname(frequency_dict))
    )
    
    reasons_data <- reasons_data[order(-reasons_data$Frequency), ]
    
    # Create the bar plot using ggplot2
    ggplot(reasons_data, aes(x = factor(Reason_Code), y = Frequency)) +
      geom_bar(stat = "identity") +
      labs(title = "Reasons People Aren't Using Contraceptives",
           x = "Reason (Numerical Code)",
           y = "Frequency") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}

# Server logic for chart 3
server_chart3 <- function(input, output, session) {
  contraceptives <- read.csv("C:/Users/sowas/Downloads/INFO201/INFO201FinalProject/birth_control_data.csv")
  
  output$chart3 <- renderPlot({
    # Map the unique values to their corresponding year ranges
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
  })
}

server <- function(input, output, session) {
  callModule(server_chart1, "chart1")
  callModule(server_chart2, "chart2")
  callModule(server_chart3, "chart3")
}