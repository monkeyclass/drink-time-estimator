# Load packages ----
library(shiny)
library(dplyr)


# Load data ----
thunderstruck <- readRDS("data/thunderstruck.rds")


# Source helper functions ----
source("helpers.R")


# User interface ----
ui <- fluidPage(
  titlePanel("Drink Time Estimator"),
  
  
  sidebarLayout(
    sidebarPanel(
      helpText('Estimating drinking time for the "Thunderstruck"
                drinking game based on starting position.'),
      
      
      selectInput("d", 
                  label = "Choose the song you want to estimate",
                  choices = list("AD/CD - Thunderstruck", 
                                 "placeholder"),
                  selected = "AD/CD - Thunderstruck"),
      
      
      sliderInput("p", 
                  label = "Number of Participants:",
                  min = 1, max = 20, value = 5),

      
      radioButtons("s",
                   label = "First participant starts:",
                   choices = list("Beginning of song",
                                  "from first keyword"),
                   selected = "Beginning of song")
    ),
    mainPanel(
      tableOutput("drink_time")
    )
  )
)
  

# Server logic
server <- function(input, output, session) {
  output$drink_time <- renderTable({
    
    
    start <- switch(input$s,
                    "Beginning of song" = 0,
                    "from first keyword" = 1
                    )
    
    
    data <- switch(input$d,
                   "AD/CD - Thunderstruck" = thunderstruck,
                   "placeholder" = thunderstruck
                   )
      
    
    participants <- input$p
    
    

    drink.time(data,participants,start)

  })
}


# Run app ----
shinyApp(ui, server)