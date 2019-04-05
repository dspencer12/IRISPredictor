#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(caret)
library(ggplot2)
library(shiny)

model <- train(iris[1:4], iris$Species)

shinyServer(function(input, output) {
    
  output$scatterPlot <- renderPlot({
      df <- data.frame(Sepal.Length = input$sepalLength,
                       Sepal.Width = input$sepalWidth,
                       Petal.Length = input$petalLength,
                       Petal.Width = input$petalWidth)
      df <- cbind(df, Species = predict(model, df))
      
      ggplot(iris, aes_string(x = input$xfield, y = input$yfield, color = "Species")) +
          geom_point() +
          labs(x = sub("\\.", " " , input$xfield),
               y = sub("\\.", " " , input$yfield)) +
          scale_color_brewer(palette = input$palette) +
          geom_point(data = df, size = 8, shape = 4)
  })
  
})
