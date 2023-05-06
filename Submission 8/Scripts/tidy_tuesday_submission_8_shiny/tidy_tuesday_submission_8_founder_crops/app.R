# Tidy Tuesday Submission 8 - Founder Crops - Shiny app
# Mac Hein
# 2023-04-30

# Load Libraries

library(shiny)
library(tidyverse)
library(tidytuesdayR)
library(ggmap)

# Load Data

tuesdata <- tidytuesdayR::tt_load(2023, week = 16)

founder_crops <- tuesdata$founder_crops

# Process Data

site_coordinates <- unique(founder_crops[c("site_name", "latitude", "longitude")])

phase_times <- unique(founder_crops[c("phase", "phase_description", "phase_code", "age_start", "age_end")])

# Making a base map

base_map <- get_map(location = c(lon = 40, lat = 35), zoom = 5, maptype = "terrain")

# Make Page

ui <- fluidPage(
  
  # Application title
  
  titlePanel("Neolithic Founder Crops"),
  
  mainPanel(selectInput(inputId = "site",
                        label = "Choose Site:",
                        choices = site_coordinates$site_name),
            uiOutput("selectPhase"),
            plotOutput("siteMap"),
            h4(textOutput("phase_name")),
            h4(textOutput("phase_description")),
            h4(textOutput("timespan")),
            plotOutput("siteCrops"),
            dataTableOutput("cropTable")
            )
  )

server <- function(input, output){
  
  selected_site <- reactive({filter(founder_crops, site_name == input$site)})
  
  site_phases <- reactive({unique(selected_site()$phase_code)})
  
  output$selectPhase <- renderUI({selectInput(inputId = "phase",
                                              label = "Choose Phase",
                                              choices = site_phases())})
  
  phase_times_filtered <- reactive({filter(phase_times, phase_code == input$phase)})
  
  phase_name <- reactive({paste("Phase name:", phase_times_filtered()$phase)})
  
  phase_description <- reactive({paste("Phase description:", phase_times_filtered()$phase_description)})
  
  timespan <- reactive({paste("Phase timespan:", phase_times_filtered()$age_start, "to", phase_times_filtered()$age_end, "years before 1950 CE")})
  
  selected_phase <- reactive({filter(selected_site(), phase_code == input$phase)})
  
  category_counts <- reactive({selected_phase() %>%
      group_by(site_name, latitude, longitude, phase, phase_description, phase_code, age_start, age_end, category) %>%
      summarize(count = n())})
  
  output$siteMap <- renderPlot({
    
    site_coordinates_filtered <- filter(site_coordinates, site_name == input$site)
    
    ggmap(base_map) +
      geom_point(data = site_coordinates_filtered,
                 aes(x = longitude, y = latitude, color = "deeppink"),
                 alpha = 1,
                 size = 2,
                 stroke = 1) +
      ylim(25, 40) +
      theme(legend.position="none")
    })
  
  output$phase_name <- renderText({phase_name()})
  
  output$phase_description <- renderText({phase_description()})
  
  output$timespan <- renderText({timespan()})
  
  output$siteCrops <- renderPlot({
    ggplot() +
      geom_col(data = category_counts(),
               aes(x = category, y = count))
  })
  
  output$cropTable <- renderDataTable({
    
    founder_crops_filtered <- filter(founder_crops, site_name == input$site) %>%
      filter(phase_code == input$phase) %>%
      select(taxon, genus, family, category)
    })
  }

# Run the application

shinyApp(ui = ui, server = server)
