library("shiny")
library("tidyverse")
library("phyloseq")
library("BiocManager")
options(repos = BiocManager::repositories())

taxLevel <- c("domain","phylum", "class", "order")

fluidPage(
  
  titlePanel("Taxa filtering"),
  
  sidebarPanel(
    
    textInput("name", "Project's name?", value = 'phyloseq'),
    fileInput("file1", "Choose Phyloseq File", accept = ".rds"),
    radioButtons("taxaLevel", "Select taxonomic level", selected = "phylum", taxLevel),
    numericInput("prevaTaxa", "Prevalance, % of samples with ASVs", value = 5, min = 0, max = 100),
    numericInput("abunTaxa", "Abundance, % of ASV overall", value = 0.01, min = 0, max = 100),
    sliderInput("pointSize", "Sample's size", value = 1.5, min = 1, max = 15),
    sliderInput("pointTrans", "Transparent", value = 0.5, min = 0, max = 1),
    downloadButton("downloadTable", "Download table"),
    downloadButton("downloadData", "Download phyloseq")
    
  ),
  
  mainPanel(
    verbatimTextOutput("inPs"),
    textOutput("summary"),
    textOutput("filterSummary"),
    plotOutput("taxaFilter", height=1000),
    tableOutput("taxaTable")
    
  )
  
)