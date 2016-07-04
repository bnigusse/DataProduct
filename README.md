# Dynamic Display of Plots using mtcars Data Set

Link to shiny product app, presentation and github repository:

Shiny Application here: (https://nigusseba.shinyapps.io/DataProduct/). This link will take you to the shiny application web site.

Shiny Presentation here: (https://bnigusse.github.io/DataProduct/DataProduct.html#/). This link will take you to the data product pressentation web site.

Github Repository here: (https://github.com/bnigusse/DataProduct/tree/gh-pages). This link will take you to the github repository of this data product application.

### Overview of Shiny Data Product
This project demonstrates dynamic prediction of fuel consumption of motor vehicles in ***mpg*** for number of cylinders selected by users. The prediction model uses motor vehicles performance data set **mtcars** available in R Studio. The shiny data product demonstrates the following capabilities:

- Select number of cylinders
- Dynamically subset the **mtcars** data set
- Dynamically generate linear model
- Dynamically update plots

### Dynamically Subset Data Set and Fit Model
Shiny server dynamically subsets the *mtcars* data set for the number of cylinders specified. The number of cylinders choices available are 4, 6, or 8. The radio buttons are used to dynamically switch between the number of cylinders. The default choice is 4. The reactive function allow dynamically updating the sub data set for the selected number cylinders as shown in the pseudo code below.

```
NumOfCylinders <- reactive({
NumberOfCylinders <- as.numeric(input$nCyl) # update number of cylinders
return(NumberOfCylinders) })
```

```
mydf <- reactive({
subset(mtcars, mtcars$cyl==NumOfCylinders()) }) # update subset data
```

The linear model predicts fuel consumption of motor vehicles in *mpg* for the number of cylinders selected using linear regression fit and displays the result as a plot dynamically. A reactive function is used to update the linear model whenever the user switches the number cylinders using the radio button.

```
lmFit <- reactive({
regressionModelExp <- "mpg ~ ." # linear model expression
lm(regressionModelExp, data=mydf()) }) # update the linear model
```

### Predicted MPG Plot for 4 Cylinder Cars
Scatter plot of predicted and measured fuel consumption for 4 cylinder cars. If you select the **Four Cylinder** radio button, then you should be able to reproduce the plot shown in the R presentation slides.

```
library(UsingR)
data(mtcars)
par(mfrow=c(1,1), cex.main=1.6, cex.lab=1.2, cex.axis=2, mar=c(5,5,3,3))
mydf <- subset(mtcars, mtcars$cyl == 4)
lmFit <- lm(mpg ~ ., data=mydf)
predicted <- predict(lmFit)
plot(predicted ~ mydf$mpg, 
main="Miles per Gallon Comparison for 4 Cylinder Cars", 
xlab="Measured, mpg", ylab="Predicted, mpg", pch=16,
col="blue", bg="blue", cex=2.0, xlim=c(20, 36), ylim=c(20, 36)) 
```

### Residual MPG Plot for 4 Cylinder Cars
Residual *mpg* against predicted fuel consumption is shown for 4 cylinder cars. If you run the model and select the *Four Cylinders* and check the *Show Residual Plot* check-box, then you should able to reproduce the plot shown in the R presentation slides. You may click the check-box *Show Residual Plot* to display or remove the residual plot.


```
library(UsingR)
data(mtcars)
par(mfrow=c(1,1), cex.main=1.6, cex.lab=1.2, cex.axis=2, mar=c(4,5,2,2))
mydf <- subset(mtcars, mtcars$cyl == 4)
lmFit <- lm(mpg ~ ., data=mydf)
predicted <- predict(lmFit)
residual <- mydf$mpg - predicted
plot(residual ~ predicted, 
main="Residuals versus Predicted for 4 Cylinder Cars", xlab="Predicted, mpg", 
ylab="Residuals, mpg",pch=16, col="blue", bg="blue", cex=2.0, xlim=c(20, 36), ylim=c(-4, 4))
```