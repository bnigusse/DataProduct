library(UsingR)
#data(mtcars)

shinyUI(pageWithSidebar(
    
    #  Application title
    headerPanel("Motor Vehicle Performance"),
    
    # Radio butten choices
    sidebarPanel(
        radioButtons("nCyl", "Select Number of Cylinders:",
                     list("Four Cylinders" = "4",
                          "Six Cylinders" = "6",
                          "Eight Cylinders" = "8"), selected = "4"),
        
        # date input function
        dateInput("date", "Enter Date:"),
        
        # checkbox input method
        checkboxInput("Show.Resid", "Show Residual Plot", FALSE)
        ),
    

    mainPanel(
        
        h3('Illustrating Inputs'),
        h5('Number of Cylinders Selected:'),
        verbatimTextOutput("outnCyl"),
        h5("Date Specified:"),
        verbatimTextOutput("dateSelected"),
        h5("Residual Plot Status:"),
        verbatimTextOutput("ResidualPlotStatus"),
        br(),
        br(),
        plotOutput("scatterplot"),
        plotOutput("residualplot")
    )
    
))