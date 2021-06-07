library(shiny)

ui <- fluidPage(
  sliderInput(inputId = "year", label = "YEAR", min = 1900, max = 2000, value = c(1920, 1980), step = 5)
  ,
  plotOutput("plot")
)


server <- function(input, output, session) {
  main_data <- reactive({
    data.frame(a= 1900:2000, b=rnorm(101) )
  })
  
  output$plot <- renderPlot({
    df <- main_data()
    df <-  df[df$a>input$year[1] & df$a<input$year[2],]
    plot(df$a, df$b, type = "l")
  })
  
}
shinyApp(ui = ui, server = server)


