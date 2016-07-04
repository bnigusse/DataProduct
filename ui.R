library(UsingR)
#data(mtcars)

shinyUI(pageWithSidebar(
    
    #  Application title
    headerPanel("Motor Vehicle Performance Dynamic Display"),
    
    # Radio butten choices
    sidebarPanel(
        radioButtons("nCyl", "Select Number of Cylinders:",
                     list("Four Cylinders" = "4",
                          "Six Cylinders" = "6",
                          "Eight Cylinders" = "8"), selected = "4"),
        
        # date input function
        dateInput("date", "Enter Date:"),
        
        # checkbox input method
        checkboxInput("Show.Resid", "Show Residual Plot", FALSE),
        
        #textInput(inputId="text1", label = "Documentation: "),

        p(strong(em("Documentation:",a("Dynamic Display of Plots using mtcars Dataset",href="https://github.com/bnigusse/DataProduct/blob/gh-pages/README.md")))),
        
        p(strong(em("Github repository:",a("Data Products; Shiny App",href="https://github.com/bnigusse/DataProduct/tree/gh-pages"))))
        
        
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