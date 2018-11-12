library(shiny)
library(shinydashboard)
library(DT)
library(readr)

setwd("/srv/shiny-server/musel")
tsbd <- read_rds("data/tsbd.rds")
tsbd$총매출 <- format(tsbd$총매출, big.mark = ",")

server <- function(input, output) {
  # options(shiny.fullstacktrace = TRUE)
  # options(shiny.error = browser)
  # options(shiny.trace=TRUE)
  # options(shiny.error = recover)
  # options(shiny.sanitize.errors = FALSE)
  
  #dashboard tab
  output$salesBox <- renderInfoBox({
    infoBox(
      "금일 총 매출", "69,539,700", icon = icon("list"),
      color = "yellow"
    )
  })
  
  output$progressBox <- renderInfoBox({
    infoBox(
      "금일 총 광고지출", "31,151,659", icon = icon("list"),
      color = "purple"
    )
  })

  output$approvalBox <- renderInfoBox({
    infoBox(
      "금일 총 ROAS", "223%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "blue"
    )
  })
  
  output$table1 <- DT::renderDataTable(tsbd[,-1], server = FALSE, filter = 'top')  
  
  # #creating the valueBoxOutput content
  # output$value1 <- renderValueBox({
  #   valueBox(
  #     formatC(w42$Totalsales, format="d", big.mark=','),
  #     'w42 총 매출'
  #   
  #   )
  # })
  
  # output$value2 <- renderValueBox({
  #   
  #   valueBox(
  #     formatC(w42$Marketingcost, format="d", big.mark=','),
  #     'w42 총 마케팅 지출'
  #     
  #   )
  # })
  # 
  # 
  # 
  # output$value3 <- renderValueBox({
  #   
  #   valueBox(
  #     paste(w42$ROAS, "%"),
  #     'w42 총 ROAS'
  #     
  #   )
  # })
  
}