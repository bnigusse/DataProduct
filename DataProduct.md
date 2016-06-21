DataProuct Project
========================================================
author: Nigusseba
date: Mon Jun 20 22:45:28 2016
width: 1440
height: 900
font-family: 'Helvetica'

Overview
========================================================
transition: rotate
This project demonstrates dynamic prediction of fuel consumptions of motor vehicles in ***mpg*** for number of cylinders selected. The prediction model uses motor vehicles performance data set **mtcars** available in RStudio. The shiny data product allow users to do the following:

- Select the number of cyclinders
- Dynamically subset the dataset
- Dynamicaly generate linear model
- Dynamiclly updates plots

Dynamically Subset DataSet and Fit Model
========================================================
Shiny server dynamically subsets the *mtcars* dataset for a the number of cycliners specified. The number of cyclinders choices available are 4, 6, or 8. Radio buttons are used to switch between the number of cyclinders. The default value is 4. The reactive function allow dynamically updating the dataset as shown in the psudo code below.


```r
NumOfCylinders <- reactive({
NumberOfCylinders <- as.numeric(input$nCyl)
return(NumberOfCylinders) })
```


```r
mydf <- reactive({
subset(mtcars, mtcars$cyl==NumOfCylinders()) })
```

The model predicts fuel consumptions in *mpg* for the number of cycliners selected uding linear regression model and displays the plot dynamically. The reactive function is used to update the linear model.


```r
lmFit <- reactive({
regress.exp <- "mpg ~ ."
lm(regress.exp, data=mydf()) })
```

Predicted MPG Plot for 4 Cyliners Cars
========================================================
Scatter plot of predicted and measured fuel consumption for 4 cylinder cars. If you select the **Four Cyclinders** radio button, then you should be able to reproduce the plot shown below.

<img src="DataProduct-figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

Residual MPG Plot for 4 Cyliners Cars
===
Residual *mpg* against predicted fuel consumption is shown for 4 cyclder cars. If you run the model and select the *Four Cylinders* and check the *Show Residual Plot* checkbox, then you should able to reproduce the plot shwon below. You may click the checkbox *Show Residual Plot* to display or remove the residual plot.


<img src="DataProduct-figure/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />


