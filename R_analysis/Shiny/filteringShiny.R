library("shiny")
library("tidyverse")

ps <- readRDS("Work/Heike/finps_DECIPHER.RDS")

## Filter out controls
fltps.noContrl <- subset_samples(ps, Sample_or_Control != "Control")

## Compute number of sample for each ASV, store as data.frame
abunfltdf = apply(X = otu_table(fltps.noContrl),
                  MARGIN = ifelse(taxa_are_rows(fltps.noContrl), yes = 1, no = 2),
                  FUN = function(x){sum(x > 0)})



taxLevel <- c("domain","phylum", "class", "order")

ui <- fluidPage(
  
  titlePanel("Taxa filtering"),
  
  sidebarPanel(
    
    radioButtons("taxaLevel", "Select taxonomic level", selected = "phylum", taxLevel),
    numericInput("prevaTaxa", "Prevalance, percentage of samples with ASVs", value = 5, min = 0, max = 100),
    numericInput("abunTaxa", "Abundance, percentage of ASV overall", value = 0.01, min = 0, max = 100),
    sliderInput("pointSize", "Point Size", value = 1, min = 1, max = 15),
    sliderInput("pointTrans", "Point transparency", value = 0.5, min = 0, max = 1),
    actionButton("click", "Save new phyloseq !"),
    actionButton("loadps", "check new phyloseq !"),

  ),
  
  mainPanel(
    textOutput("summary"),
    plotOutput("taxaFilter", height=900),
    textOutput("filterSummary"),
    tableOutput("taxaTable"),
    verbatimTextOutput("filteredPs")
    
  )
  
)

server <- function(input, output, session) {
  
  ## Add taxonomy and total read counts to this data.frame
  abunfltdata <- reactive({
    data.frame(Prevalence = abunfltdf,
               TotalAbundance = taxa_sums(fltps.noContrl),
               tax_table(fltps.noContrl)[, input$taxaLevel])
  })
  

  totalReads <- reactive({sum(abunfltdata()$TotalAbundance)})
  
  output$summary <- renderText(
    paste0("There are ", nsamples(fltps.noContrl), " samples, with ", totalReads(), " reads, across ", ntaxa(fltps.noContrl), " ASVs")
    
  )
  
  output$taxaFilter <- renderPlot({
    
    ggplot(abunfltdata(), aes(TotalAbundance, Prevalence / nsamples(fltps.noContrl),color=get(input$taxaLevel))) +
      geom_hline(yintercept = input$prevaTaxa/100, alpha = 0.7, linetype = 2) +
      geom_vline(xintercept = input$abunTaxa * totalReads() / 100, alpha = 0.7, linetype = 3) +
      geom_point(size = input$pointSize, alpha = input$pointTrans) +
      scale_x_log10() +  xlab("Total Abundance") + ylab("Prevalence [Frac. Samples]") +
      facet_wrap(~get(input$taxaLevel), ncol = 2) + theme(legend.position="none")
      ## input$taxaLevel is a constant characters string, so need to have get.
      
    })
  
  prevaContamFreeTable <- reactive(
    abunfltdata() %>% rownames_to_column("ASVs") %>% 
      mutate(Prevalence_percentage = Prevalence/nsamples(fltps.noContrl) * 100, Abundance_percentage = TotalAbundance/totalReads()*100) %>%
      select(ASVs,input$taxaLevel,Prevalence,Prevalence_percentage,TotalAbundance,Abundance_percentage) %>%
      filter(Prevalence_percentage >= input$prevaTaxa & Abundance_percentage >= input$abunTaxa)
  )
  
  output$filterSummary <- renderText(
    paste0("Filter ASVs with reads below ", ceiling(input$abunTaxa * totalReads() / 100), " and appeared in less than " , ceiling(input$prevaTaxa * nsamples(fltps.noContrl) / 100), " samples. After filtering there are ", nrow(prevaContamFreeTable ()), " ASVs left (", (ntaxa(fltps.noContrl) - nrow(prevaContamFreeTable ())) / ntaxa(fltps.noContrl) *100, " % was filtered out)." )
    
  )
  
  output$taxaTable <- renderTable(
    prevaContamFreeTable ()
  )
  
  saveData <- function(data) {
    keeptaxa <- data$ASVs
    finps <- prune_taxa(keeptaxa, fltps.noContrl)
    saveRDS(finps, "./finps.RDS")

  }
    
  loadData <- function() {
    newps <- readRDS("./finps.RDS")
    newps
    }
  
  observeEvent(input$click, {
    saveData(prevaContamFreeTable())
    
  })
  
  observeEvent(input$loadps, {
    loadData()
    output$filteredPs <- renderPrint(loadData())
  })     
  
}

shinyApp(ui, server)



