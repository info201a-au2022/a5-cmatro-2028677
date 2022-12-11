# This file contains all of the UI code used to build the multi-page shiny app

# Page 1
intro_panel <- tabPanel(
  "Introduction",
  imageOutput("photo"),
  h3("About"),
  p("CO2 Emission is one of the main contributors to climate change. In this 
  project, data from Our World in Data will be explored and analyzed to 
  understand the impacts of CO2 and Greenhouse Gas emissions on our world. Using 
  data from 1750 to 2021, the focus will be on the annual total 
  production-based CO2 emissions - overall, from gas, and from
  oil - which is measured in tonnes."),
  h3("Selected Variables"),
  strong("1. co2"), p("- annual total production-based emissions of carbon 
                       dioxide (CO2), excluding land-use change, measured in 
                       million tonnes."),
  strong("2. gas_co2"), p("- annual production-based emissions of carbon dioxide 
                           (CO2) from gas, measured in million tonnes."),
  strong("3. oil_co2"), p("- annual production-based emissions of carbon dioxide
                           (CO2) from oil, measured in million tonnes."),
  p(""),
  em(""),
  h3("Relevant Values"),
  strong("Value 1: What is the world's total CO2 emission increase from 1750 to 2021?"),
  p("37,114.50 million tonnes"),
  p("In 1750, the total count was 9.35 million tonnes."),
  p("In 2021, the total count was 37,123.85 tonnes."),
  strong("Value 2: Which country has the highest gas CO2 emission?"),
  p("Asia"),
  strong("Value 3: What is Asia's highest oil CO2 emission?"),
  p("4,806.57 million tonnes")
)

# Page 2
year_select <- unique(co2_data$year)
country_select <- unique(co2_data$country)

interactive_panel <- tabPanel(
  "CO2 Production",
  
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "source", label = "Select a variable:",
                  choices = list("Total CO2 Emissions", "Gas CO2 Emissions", 
                                 "Oil CO2 Emissions"), selected = "CO2"),
      selectInput(inputId = "ctry", label = "Select a country:",
                  choices = unique(co2_data$country), selected = country_select[1]),
      sliderInput(inputId = "year", label = "Select a year range:", min = 1750, max = 2021,
                  step = 1, value = c(1750, 2021), sep = "")
    ),
    
    mainPanel(
      plotlyOutput(outputId = "scatterplot")
    )
  ),
  
  # Caption
  h3("Findings"),
  p("The line chart above shows the trend in the total CO2 emission in all 
    countries from 1750 to 2021. The information presented is relevant because
    it reveals the increasing amounts of CO2 being released, which causes the
    global temperature to rise. We can use visualizations like this to call out
    regions that greatly contribute to global warming in order to take action."),
  strong("From Total CO2 Emissions"),
  p("Looking at the World CO2 data, a spike can be
    seen from around 1950. From then on, the emission count has grown exponentially.
    In the United States, the peak was in 2005, then decreased slightly since then."),
  strong("From Gas CO2 Emissions"),
  p("Similar to the previous chart, the World Gas CO2 data also spiked around
    1945. One significant finding was that Asia had the highest gas CO2 emission
    at 3,242.85 million tonnes in 2021."),
  strong("From Oil CO2 Emissions"),
  p("From 1973, the U.S. oil CO2 emission started to fluctuate but remained high. 
  Asia's highest oil CO2 emission was 4,806.57 million tonnes, and the world's highest
    total was 12,345.65 million tonnes.")
)

# Define UI
ui <- navbarPage(
    theme = shinytheme("superhero"),
    "CO2 Emissions",
    intro_panel,
    interactive_panel
)