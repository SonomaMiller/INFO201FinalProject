library(stringr)
library(ggplot2)

contraceptives <- read.csv("C:/Users/sowas/Downloads/INFO 201/birth_control_data.csv")

# most popular reasons people aren't using contraceptives

# MINI CODEBOOK (values are numerical):
# 1: You do not expect to have sex
# 2: You do not think you can get pregnant
# 3: You don't really mind if you get pregnant
# 4: You are worried about the side effects of birth control
# 5: Your male partner does not want you to use a birth control method
# 6: Your male partner himself does not want to use a birth control method

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

# Create the bar plot
barplot(reasons_data$Frequency, 
        main = "Reasons People Aren't Using Contraceptives",
        xlab = "Reason (Numerical Code)",
        ylab = "Frequency",
        names.arg = reasons_data$Reason_Code)

# Add reasons codebook
reasons_text <- c(
  "1: You do not expect to have sex",
  "2: You do not think you can get pregnant",
  "3: You don't really mind if you get pregnant",
  "4: You are worried about the side effects of birth control",
  "5: Your male partner does not want you to use a birth control method",
  "6: Your male partner himself does not want to use a birth control method"
)

print("Numerical Codebook:")
print(reasons_text)