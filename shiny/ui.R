library(shiny)
library(datasets)
# Define UI for Car Ranking by Horse Power application
shinyUI(pageWithSidebar(
        
        # Application title
        headerPanel("Car Ranking by Horse Power"),
        
        # Sidebar with sliders to choose miles per galon and cylinder
        # and the choice between automatic and manual
        sidebarPanel(
                sliderInput("mpg", "Miles per Galon:", 
                            min=min(mtcars$mpg), max=max(mtcars$mpg),
                            value=c(min(mtcars$mpg), max(mtcars$mpg)),
                            step=0.5),
                sliderInput("cyl", "Cylinder:", 
                            min = 4, max = 8, value = 6, step = 2),
                selectInput("am", "Choose transmission:", 
                            choices = c("automatic", "manual"))
        ),
        
        # Show selection of cars sorted by horse power
        mainPanel(
                h3(textOutput("Statistics of selection")),
                tableOutput("statistics")
        )
))
