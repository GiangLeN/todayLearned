library("shiny")

ui <- fluidPage(
  numericInput("abun", "Abundance", value = 0, min = 0, max = 100),
  numericInput("reva", "Prevalance", value = 0, min = 0, max = 100),
  plotOutput("plotFilter")

)

server <- function(input, output, session) {
  
  output$plotFilter <- 

}

shinyApp(ui, server)
