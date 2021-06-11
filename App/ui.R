library("shiny")
library("tidyverse")
library("phyloseq")
library("BiocManager")
library("DT")
options(repos = BiocManager::repositories())

taxLevel <- c("domain","phylum", "class", "order")

fluidPage(
  
  titlePanel("Taxa filtering"),
  
  sidebarPanel(
    
    textInput("name", "Project's name", value = 'phyloseq'),
    fileInput("file1", "Choose Phyloseq File", accept = ".rds"),
    radioButtons("taxaLevel", "Select taxonomic level", selected = "phylum", taxLevel),
    numericInput("prevaTaxa", "Prevalance, % of samples with ASVs", value = 5, min = 0, max = 100),
    numericInput("abunTaxa", "Abundance, % of ASV overall", value = 0.01, min = 0, max = 100),
    sliderInput("pointSize", "Sample's size", value = 1.5, min = 1, max = 15),
    sliderInput("pointTrans", "Transparent", value = 0.5, min = 0, max = 1),
    h4("How to Exclude Taxa:"),
    h5("Advance option: Do not use unless you know what you are doing."),
    h5("Type in the taxa names seperate by | without any space"),
    h5("eg: Fusobacteriota|Cyanobacteria "),
    textInput("excludeTaxa", "Exclude taxa"),
    downloadButton("downloadTable", "Download table"),
    downloadButton("downloadData", "Download phyloseq")
    
  ),
  
  mainPanel(
    verbatimTextOutput("inPs"),
    textOutput("summary"),
    textOutput("filterSummary"),
    verbatimTextOutput("test"),
    plotOutput("taxaFilter", height=1000),
    DT::dataTableOutput("taxaTable")
    
  )
  
)