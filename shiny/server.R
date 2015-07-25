library(shiny)
library(datasets)

# We factor the am variable and change the level names of am to make it more clear
mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("automatic", "manual"))

# Define server logic required to show ranking by horse power of selection
shinyServer(function(input, output) {
        # Reactive expression to compose a data frame containing the ranking
        statistics <- reactive({   
                # Build the subset from the data by the user selection
                submpgData <- mpgData[which( 
                                     mpgData$mpg <= max(input$mpg)
                                     & mpgData$mpg >= min(input$mpg)
                                     & mpgData$cyl == as.character(input$cyl)
                                     & mpgData$am == as.character(input$am)),]
                ranking <- submpgData[with(submpgData, order(-hp)), c(1,2,4,9)]
        }) 
        
        # Show the values using an HTML table
        output$statistics <- renderTable({
                statistics()
        })
})
