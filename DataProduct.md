Dynamic Display of Plots using mtcars Dataset
===
author: Nigusseba
date: Tue Jun 21 22:27:23 2016
width: 1440
height: 900
font-family: 'Helvetica'

Overview of Shiny Datae Product
===
transition: rotate
This project demonstrates dynamic prediction of fuel consumptions of motor vehicles in ***mpg*** for number of cylinders selected by users. The prediction model uses motor vehicles performance data set **mtcars** available in RStudio. The shiny data product demonstrates the following capabilities:

- Select the number of cyclinders
- Dynamically subset the **mtcars** dataset
- Dynamicaly generate linear model
- Dynamiclly updates plots

Dynamically Subset DataSet and Fit Model
===
Shiny server dynamically subsets the *mtcars* dataset for a the number of cycliners specified. The number of cyclinders choices available are 4, 6, or 8. The radio buttons are used to switch between the number of cyclinders. The default choice is 4. The reactive function allow dynamically updating the dataset as shown in the psudo code below.


```r
NumOfCylinders <- reactive({
NumberOfCylinders <- as.numeric(input$nCyl)
return(NumberOfCylinders) })
```


```r
mydf <- reactive({
subset(mtcars, mtcars$cyl==NumOfCylinders()) })
```

The model predicts fuel consumption of motor vehicles in *mpg* for the number of cycliners selected using linear regression model and displays the result as a plot dynamically. A reactive function is used to update the linear model whenever the user clickes the radio button.


```r
lmFit <- reactive({
regress.exp <- "mpg ~ ."
lm(regress.exp, data=mydf()) })
```

Predicted MPG Plot for 4 Cyliners Cars
===
Scatter plot of predicted and measured fuel consumption for 4 cylinder cars. If you select the **Four Cyclinders** radio button, then you should be able to reproduce the plot shown below.

<img src="DataProduct-figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

Residual MPG Plot for 4 Cyliners Cars
===
Residual *mpg* against predicted fuel consumption is shown for 4 cyclder cars. If you run the model and select the *Four Cylinders* and check the *Show Residual Plot* checkbox, then you should able to reproduce the plot shwon below. You may click the checkbox *Show Residual Plot* to display or remove the residual plot.


<img src="DataProduct-figure/unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />


