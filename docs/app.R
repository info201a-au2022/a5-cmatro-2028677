library(tidyverse)
library(plotly)
library(ggplot2)
library(scales)
library(shiny)
library(dplyr)
library(stringr)
library(shinythemes)

source("app_server.r")
source("app_ui.r")

# Run the application
shinyApp(ui = ui, server = server)