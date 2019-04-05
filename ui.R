#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(RColorBrewer)

fieldList = list("Sepal Length" = "Sepal.Length",
                 "Sepal Width" = "Sepal.Width",
                 "Petal Length" = "Petal.Length",
                 "Petal Width" = "Petal.Width")

palettes = rownames(subset(brewer.pal.info, category == "qual"))

shinyUI(fluidPage(
  
  # Application title
  titlePanel("IRISPredictor: Predicting Iris Species"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        h3("Prediction Settings"),
        helpText("Predict the species based on the size"),
        sliderInput("petalWidth", "Petal Width", min(iris$Petal.Width),
                    max(iris$Petal.Width), mean(iris$Petal.Width)),
        sliderInput("petalLength", "Petal Length", min(iris$Petal.Length),
                    max(iris$Petal.Length), mean(iris$Petal.Length)),
        sliderInput("sepalWidth", "Sepal Width", min(iris$Sepal.Width),
                    max(iris$Sepal.Width), mean(iris$Sepal.Width)),
        sliderInput("sepalLength", "Sepal Length", min(iris$Sepal.Length),
                    max(iris$Sepal.Length), mean(iris$Sepal.Length)),
        h3("Plot Settings"),
        helpText("Configure the plot"),
        selectInput("xfield", "X-Axis Variable", fieldList),
        selectInput("yfield", "Y-Axis Variable", fieldList, selected = "Petal.Width"),
        selectInput("palette", "Color Palette", palettes, selected = "Dark2")
    ),
    
    mainPanel(
       p(paste0("To get started, change the petal and sepal sizes on the left-hand side to ",
                "see their effects on the species prediction. Change the plot axis variables ",
                "in order to fully visualize the effects. You can also change the color scheme ",
                "according to your preference.")),
       p("Note that the plot will take a short time to appear whilst the random forest model is trained."),
       h4("Your prediction is indicated by the cross in the below plot"),
       plotOutput("scatterPlot")
    )
  )
))
