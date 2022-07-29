library(readr)
library(tidyverse)
library(ggplot2)
library(here)
library(shiny)
library(lubridate)

source("R/get_data.R")
source("R/get_top_n.R")
source("R/get_plot.R")

datasetInput <- readRDS(here("nobel.RDS"))
categories <- datasetInput %>% 
  select(category) %>% 
  unique()
countries <- datasetInput %>% 
  select(birth_country) %>% 
  unique() %>% 
  arrange(birth_country)


ui <- 
  
navbarPage("Most Nobel of Prizes!",
           tabPanel("Prize Analysis",
                    sidebarLayout(
                      sidebarPanel(
                        sliderInput(inputId="topn", 
                                    label="Top n",
                                    min = 5, 
                                    max = 12,
                                    value = 10),
                        selectInput(inputId="category", 
                                    label="Category",
                                    c(categories,"All"),
                                    selected="All"),
                        selectInput(inputId="gender", 
                                  label="Gender",
                                  c("Male","Female","Both"),
                                  selected="Both")),
                    mainPanel(
                      h4("Observations"),
                      tableOutput(outputId="tableview"))
                                  )
                    ),
           tabPanel("Country Dominance",
                    sidebarLayout(
                      sidebarPanel(
                        selectInput(inputId="country", 
                                    label="Country",
                                    c(countries),
                                    selected="United States of America")),
                      mainPanel(
                        h4("Dominance Plot"),
                        plotOutput(outputId="pctplot"))
                    )
           )
           )

server <- function(input, output) {
  
  output$tableview <- renderTable({
    get_top_n(datasetInput,input$topn,input$category,input$gender)
  })
  
  output$pctplot <- renderPlot({
    get_percent(datasetInput,input$country)
  })
  
  
}


shinyApp(ui = ui, server = server)
