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

library(phyloseq)

if (interactive()) {
  
  ui <- fluidPage(
    sidebarLayout(
      sidebarPanel(
        fileInput("file1", "Choose Phyloseq File", accept = ".rds"),
        checkboxInput("header", "Header", TRUE)
      ),
      mainPanel(
        tableOutput("contents")
      )
    )
  )
  
  server <- function(input, output) {
    output$contents <- renderPrint({
      file <- input$file1
      ext <- tools::file_ext(file$datapath)
      
      req(file)
      validate(need(ext == "rds", "Please upload a csv file"))
      
      readRDS(file$datapath)
    })
  }
  
  shinyApp(ui, server)
}
