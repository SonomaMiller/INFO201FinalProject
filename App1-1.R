library(shiny)
library(bslib)
library(ggplot2)
library(dplyr)
library(tidyr)
library(stringr)
library(rsconnect)

source("ui1-1.R")
source("server1-1.R")

shinyApp(ui = ui, server = server)