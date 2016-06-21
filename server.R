library(UsingR)
library(chron)
data(mtcars)

mydf <- mtcars
input <- list(rseed=1)

# A function for subsetting the data by number of cylinders
shinyServer(  
    function(input, output,session) {
        
        ## dynamically update the number cyclinders selected        
        NumOfCylinders <- reactive({
            NumberOfCylinders <- as.numeric(input$nCyl)
            return(NumberOfCylinders)
        })  
        
        output$outnCyl <- renderPrint({as.numeric(input$nCyl)})

        ## dynamically subset the data set bsed on the number cyclinders selected
        mydf <- reactive({
            subset(mtcars, mtcars$cyl == NumOfCylinders())
        })
        
        ## dynamically update the inear model fir coefficients
        lmFit <- reactive({
            regress.exp <- "mpg ~ ."
            lm(regress.exp, data=mydf())
        })
        
        output$dateSelected <- renderText({
            paste(strftime(as.Date(input$date, format="%Y %m %d"), format="%B %d %Y"))
        })
        
        ## dynamically update the residual plot status based the checkbox
        output$ResidualPlotStatus <- renderText({
            if(input$Show.Resid){
                paste("To remove the residual plot uncheck the checkbox on the left.")
            } else {
                paste("To see the residual plot check the checkbox on the left.")
            }
        })
        
        ## dynamically update the x-axis limits
        xlimts <- reactive({
            if ( NumOfCylinders() == 4 ){
               c(20, 36) 
            } else if (NumOfCylinders() == 6) {
               c(16, 22) 
            } else if (NumOfCylinders() == 8) {
               c(10, 20)  
            } else {
               c(20, 36) 
            }
        })        
        ## dynamically update the y-axis limits
        ylimts <- reactive({
            if ( NumOfCylinders() == 4 ){
                c(20, 36) 
            } else if (NumOfCylinders() == 6) {
                c(16, 22) 
            } else if (NumOfCylinders() == 8) {
                c(10, 20)  
            } else {
                c(20, 36) 
            }
        })
        ## dynamically update the scatter mpg plot
        output$scatterplot <- renderPlot({
            par(mfrow=c(1,1), cex.main=2, cex.lab=2, cex.axis=2, mar=c(4,5,2,2) )
            predicted = predict(lmFit())
            plot(predicted ~ mydf()$mpg, 
                 main="Miles per Gallon Comparison", xlab="Measured, mpg", ylab="Predicted, mpg", 
                 pch=16, col="blue", bg="blue", cex=2.5, xlim=xlimts(), ylim=ylimts() )
        }, height=400 )
        
        ## dynamically update the residual plot
        output$residualplot <- renderPlot({
            par(mfrow=c(1,1), cex.main=2, cex.lab=2, cex.axis=2, mar=c(4,5,2,2) )
            predicted = predict(lmFit())
            residual = mydf()$mpg - predicted
            if(input$Show.Resid){
                plot(residual ~ predicted, 
                main="Residuals versus Predicted", xlab="Predicted, mpg", ylab="Residuals, mpg", 
                pch=16, col = "blue", bg="blue", cex=2.5, xlim=xlimts(), ylim=c(-4, 4) )
           }
           }, height=400 )
})