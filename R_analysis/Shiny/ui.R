library(shiny)

animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")
ui <- fluidPage(
  ## Text input
  textInput("name", "What's your name?"),
  passwordInput("password", "What's your password?"),
  textAreaInput("story", "Tell me about yourself", rows = 3),
  ## Numeric input
  numericInput("num", "Number one", value = 0, min = 0, max = 100),
  sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
  sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100),
  ## Date input
  dateInput("dob", "When were you born?"),
  dateRangeInput("holiday", "When do you want to go on vacation next?"),
  ## Choice input
  selectInput("state", "What's your favourite state?", state.name),
  radioButtons("animal", "What's your favourite animal?", animals),
  ## Radio choice
  radioButtons("rb", "Choose one:",
               choiceNames = list(
                 icon("angry"),
                 icon("smile"),
                 icon("sad-tear")
               ),
               choiceValues = list("angry", "happy", "sad")
  ),
  
  ## Dropdown
  selectInput(
    "state", "What's your favourite state?", state.name,
    multiple = TRUE
  ),
  ## Check boxes
  checkboxGroupInput("animal", "What animals do you like?", animals),
  ## Check boxes for yes and no
  checkboxInput("cleanup", "Clean up?", value = TRUE),
  checkboxInput("shutdown", "Shutdown?"),
  ## FIle input
  fileInput("upload", NULL),
  ## Action bottom
  actionButton("click", "Click me!"),
  actionButton("drink", "Drink me!", icon = icon("cocktail"))
  
)

server <- function(input, output, session) {
}

shinyApp(ui, server)






ui <- fluidPage(
  fluidRow(
    actionButton("click", "Click me!", class = "btn-danger"),
    actionButton("drink", "Drink me!", class = "btn-lg btn-success")
  ),
  fluidRow(
    actionButton("eat", "Eat me!", class = "btn-block")
  )
)

server <- function(input, output, session) {
}


shinyApp(ui, server)


## Output
ui <- fluidPage(
  textOutput("text"),
  verbatimTextOutput("code")
)

server <- function(input, output, session) {
  ## Output regular text with textOutput()
  ## renderText combines the result into a single string
  output$text <- renderText("Hello friend!")
  ## Fixed code and console output with verbatimTextOutput().
  ## renderPrint prints the result, as if you were in an R console
  output$code <- renderPrint( summary(1:10) )
  # Test line
  #output$code <- renderPrint("Hellow friend")
  ## output print like a console
}

shinyApp(ui, server)



## Table

ui <- fluidPage(
  tableOutput("static"),
  dataTableOutput("dynamic")
)
server <- function(input, output, session) {
  output$static <- renderTable(head(mtcars))
  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))
}

shinyApp(ui, server)

## Plot
ui <- fluidPage(
  plotOutput("plot", width = "400px")
)
server <- function(input, output, session) {
  output$plot <- renderPlot(plot(1:5), res = 96)
}

shinyApp(ui, server)


ui <- fluidPage(
  # front end interface
)

server <- function(input, output, session) {
  # back end logic
}

shinyApp(ui, server)

ui <- fluidPage(
  numericInput("count", label = "Number of values", value = 100)
)

server <- function(input, output, session) {
  # back end logic
  
  ## input objects are read-only.
  ## Cannot modify an input inside the server function
  input$count <- 10
}

shinyApp(ui, server)

ui <- fluidPage(
  textOutput("greeting")
)

server <- function(input, output, session) {
  output$greeting <- renderText("Hello human!")
  ## render function does two things:
  ## Sets up a special reactive context that automatically tracks what inputs the output uses.
  ## Converts the output of your R code into HTML suitable for display on a web page
}

shinyApp(ui, server)

ui <- fluidPage(
  textInput("name", "What's your name?"),
  textOutput("greeting")
)

server <- function(input, output, session) {
  output$greeting <- renderText({
    paste0("Hello ", input$name, "!")
  })
}
shinyApp(ui, server)
