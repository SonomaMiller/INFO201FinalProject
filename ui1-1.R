library(shiny)
library(bslib)
library(ggplot2)
library(dplyr)
library(tidyr)

# Define the introduction content
introduction <- tagList(
  h3("Introduction"),
  p("- Does the popularity of different types of birth control change with age?"),
  p("- What is the most common reason that the use of a contraceptive is discontinued?"),
  p("- What is the most popular form of contraceptive?"),
  p("- Why are contraceptives used?"),
  p("This project is grounded in the analysis of extensive data concerning American women's utilization of birth control and contraceptives. By leveraging this dataset, we aim to delve deeply into the landscape of contraceptive methods, scrutinizing their efficacy, prevalence, and shortcomings. Our study seeks to unravel the intricate web of factors influencing contraceptive choices among women across different demographics and time periods."),
  p("Through rigorous analysis, we endeavor to not only identify the prevailing trends in contraceptive usage but also to probe the underlying reasons driving these patterns. By shedding light on the dynamic interplay between societal norms, healthcare access, and individual preferences, our research aspires to offer nuanced insights into the complexities of contraceptive decision-making."),
  p("Moreover, our examination extends beyond mere statistical analysis; it is underpinned by a broader commitment to advancing public health outcomes. Recognizing the pivotal role of contraceptives in safeguarding reproductive health and empowering individuals, we are driven by a sense of urgency to address existing gaps in our understanding of contraceptive behavior."),
  p("In doing so, we seek to pave the way for targeted interventions and policy initiatives aimed at optimizing contraceptive access, enhancing healthcare delivery, and fostering informed decision-making among women. By elucidating the nuanced dynamics of contraceptive usage and discontinuation, our research endeavors to catalyze positive change in healthcare practices and policy frameworks, ultimately contributing to improved reproductive health outcomes for women across the nation.")
)

# Define the page content for the "Implications" tab
page_three_content <- tagList(
  h3("Implications"),
  p("The stakeholders of this study include healthcare providers, women, and the general public that aim to advocate for women and promote awareness of women's rights."),
  p("Insights gleaned from our analysis can inform healthcare providers about the prevailing trends in contraceptive usage, enabling them to tailor counseling and intervention strategies to meet the diverse needs of their patients. By understanding the factors influencing contraceptive decisions and discontinuation, providers can offer more personalized care and support, ultimately enhancing patient satisfaction and health outcomes."),
  p("Nextly, policymakers can leverage the insights from this study to develop evidence-based policies aimed at improving contraceptive access and affordability. By addressing the barriers identified in our analysis, such as disparities in access to certain contraceptive methods or reasons for discontinuation, policymakers can enact targeted interventions to promote equitable access to reproductive healthcare services and reduce unintended pregnancies."),
  p("Finally, our findings can serve as a rallying point for public health advocates seeking to raise awareness about the importance of reproductive health and contraceptive education. By highlighting the societal attitudes and cultural norms influencing contraceptive behavior, advocates can work towards destigmatizing contraception, promoting comprehensive sex education, and empowering individuals to make informed choices about their reproductive health."),
  h3("Limitations & Challenges"),
  p("While this study offers valuable insights into contraceptive behavior among American women, several limitations should be acknowledged. The administration of this study was not consistent over time; for example, in the 2006-2010 surveys, the sexual orientation of the participants was not asked. Additionally, the timeframe of the dataset (2006-2015) may not capture recent developments in contraceptive technology, access, and usage patterns and while they are reflected in the research of additional studies, may not be included in the dataset given."),
  p("Moreover, my analysis focuses on trends in contraceptive usage over time; however, it does not account for the temporal dynamics of individual contraceptive decisions. Factors such as life events, changes in relationship status, or access to healthcare services may influence contraceptive choices on a more granular level. It is important to recognize the lack of nuance presented in numerical datasets, as depth and narrative are necessary to gain a full understanding of the participants of the study. However, the analysis of sensitive health data raises ethical considerations regarding participant privacy and informed consent. While efforts have been made to anonymize the dataset, ethical concerns surrounding data privacy and confidentiality remain paramount. Publishing narratives on a sensitive topic such as birth control, particularly amidst political disagreement, can place these women in an unintentionally vulnerable and public position.")
)

# Define the UI for the Shiny app
ui <- fluidPage(
  tags$head(
    tags$style(HTML("
      body {
        background-color: pink;
      }
    "))
  ),
  titlePanel("My App"),

  tabsetPanel(
    tabPanel("Introduction",
             introduction
    ),
    tabPanel("Chart 1",
             sidebarLayout(
               sidebarPanel(
                 h3("Birth Control Methods"),
                 p("Pill"),
                 p("Patch"),
                 p("Condom"),
                 p("Ring"),
                 p("Withdrawal"),
               ),
               mainPanel(
                 plotOutput("chart1")
               )
             )
    ),
    tabPanel("Chart 2",
             sidebarLayout(
               sidebarPanel(
                 h3("Reasons People Aren't Using Contraceptives:"),
                 p("1: You do not expect to have sex"),
                 p("2: You do not think you can get pregnant"),
                 p("3: You don't really mind if you get pregnant"),
                 p("4: You are worried about the side effects of birth control"),
                 p("5: Your male partner does not want you to use a birth control method"),
                 p("6: Your male partner himself does not want to use a birth control method")
               ),
               mainPanel(
                 plotOutput("chart2")
               )
             )
    ),
    tabPanel("Chart 3",
             sidebarLayout(
               sidebarPanel(
                 h3("Reasons for Contraceptive Pill Use Over Years:"),
                 p("1. Birth control"),
                 p("2. Cramps or pain during menstrual periods"),
                 p("3. Treatment for acne"),
                 p("4. Treatment for endometriosis"),
                 p("5. Other reasons"),
                 p("6. To regulate menstrual periods"),
                 p("7. To reduce menstrual bleeding")
               ),
               mainPanel(
                 plotOutput("chart3")
               )
             )
    ),
    tabPanel("Implications",
             page_three_content
    ),
    tabPanel("Dataset",
             p("You can download the dataset from the following link:"),
             a("Download Dataset", href = "https://github.com/the-pudding/data/blob/master/birth-control")
    )
  )
)
