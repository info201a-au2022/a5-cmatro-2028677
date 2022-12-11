# co2_data <- read.csv("co2_data.csv")

co2_sources <- co2_data %>% 
  select(year, country, co2, gas_co2, oil_co2) %>% 
  group_by(year, country)

# Value 1: World Total CO2 Emission Increase from 1750 to 2021
world_co2_1750 <- co2_data %>% 
  select(year, country, co2) %>% 
  filter(year == "1750",
         country == "World") %>% 
  pull(co2) # 9.351 tonnes

world_co2_2021 <- co2_data %>% 
  select(year, country, co2) %>% 
  filter(year == "2021",
         country == "World") %>% 
  pull(co2) # 37,123.85 tonnes

co2_1750_2021 <- (world_co2_2021 - world_co2_1750) # 37,114.50 tonnes

# Value 2: Country with Highest Gas CO2 Emission
high_gas_co2 <- co2_data %>% 
  select(country, gas_co2) %>% 
  filter(country != "World",
         country != "High-income countries") %>% 
  filter(gas_co2 == max(gas_co2, na.rm = TRUE)) %>%
  pull(country) # Asia

# Value 3: Asia's Highest Oil CO2 Emission
asia_high_oil_co2 <- co2_data %>% 
  select(country, oil_co2) %>% 
  filter(country == "Asia") %>% 
  filter(oil_co2 == max(oil_co2, na.rm = TRUE)) %>%
  pull(oil_co2) # 4,806.57 tonnes
  
server <- function(input, output) {
  
  output$photo <- renderImage({
    list(src = "gas_em.jpg",
         width = "50%",
         height = "100%")
  }, deleteFile = FALSE)
  
  # Scatterplot
  output$scatterplot <- renderPlotly({
    if(input$source == "Total CO2 Emissions") {
      choice <- co2_sources %>%
        filter(year >= input$year[1] & year <= input$year[2])
      choice <- choice %>% 
        filter(country == input$ctry)
      scatter <- ggplot(data = choice, mapping = aes(x = year, y = co2)) +
        geom_line() +
        geom_point(mapping = aes(text = paste0("Emission: ", co2, "\nCountry: ", country,
                                               "\nYear: ", year))) +
        labs(title = "Worldwide CO2 Emission", x = "Year", y = "CO2 Emission (million tonnes)") +
        scale_y_continuous(labels = scales::comma) +
        scale_x_continuous()
      scatter <- scatter + theme(legend.title = element_blank())
      scatter <- scatter + theme(legend.position='none')
      # plotly
      scatter_plotly <- ggplotly(scatter, tooltip = "text")
      return(scatter_plotly)
    } else if(input$source == "Gas CO2 Emissions"){
      choice <- co2_sources %>%
        filter(year >= input$year[1] & year <= input$year[2])
      choice <- choice %>% 
        filter(country == input$ctry)
      gas_scatter <- ggplot(data = choice, mapping = aes(x = year, y = gas_co2)) +
        geom_line() +
        geom_point(mapping = aes(text = paste0("Emission: ", gas_co2, "\nCountry: ", country,
                                               "\nYear: ", year))) +
        labs(title = "Worldwide Gas CO2 Emission", x = "Year", y = "Gas CO2 Emission (million tonnes)") +
        scale_y_continuous(labels = scales::comma) +
        scale_x_continuous()
      gas_scatter <- gas_scatter + theme(legend.title = element_blank())
      gas_scatter <- gas_scatter + theme(legend.position='none')
      # plotly
      gas_scatter_plotly <- ggplotly(gas_scatter, tooltip = "text")
      return(gas_scatter_plotly)
    } else {
      choice <- co2_sources %>%
        filter(year >= input$year[1] & year <= input$year[2])
      choice <- choice %>% 
        filter(country == input$ctry)
      oil_scatter <- ggplot(data = choice, mapping = aes(x = year, y = oil_co2)) +
        geom_line() +
        geom_point(mapping = aes(text = paste0("Emission: ", oil_co2, "\nCountry: ", country,
                                               "\nYear: ", year))) +
        labs(title = "Worldwide Oil CO2 Emission", x = "Year", y = "Oil CO2 Emission (million tonnes)") +
        scale_y_continuous(labels = scales::comma) +
        scale_x_continuous()
      oil_scatter <- oil_scatter + theme(legend.title = element_blank())
      oil_scatter <- oil_scatter + theme(legend.position='none')
      # plotly
      oil_scatter_plotly <- ggplotly(oil_scatter, tooltip = "text")
      return(oil_scatter_plotly)
    }
  })
}