library(shiny)
library(shinydashboard)
library(DT)
library(readr)
library(purrr)

setwd("/srv/shiny-server/musel")
kpi_1113 <- read_rds("data/kpi.1113.rds")

product_list <- pid %>%
  collect() %>%
  split(.$Product) %>%
  map(~ .$PID)

month_list <- as.list(1:12) %>%
  set_names(month.name)

month_list$`All Year` <- 99


server <- function(input, output) {
  # options(shiny.fullstacktrace = TRUE)
  # options(shiny.error = browser)
  # options(shiny.trace=TRUE)
  # options(shiny.error = recover)
  # options(shiny.sanitize.errors = FALSE)
  
  #dashboard tab
  output$salesBox <- renderInfoBox({
    infoBox(
      "금일 총 매출", "55,338,500", icon = icon("list"),
      color = "yellow"
    )
  })
  
  output$progressBox <- renderInfoBox({
    infoBox(
      "금일 총 광고지출", "15,311,483", icon = icon("list"),
      color = "purple"
    )
  })

  output$approvalBox <- renderInfoBox({
    infoBox(
      "금일 총 ROAS", "361%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "blue"
    )
  })
  
  output$help_text <- renderText({
    paste("위의 데이터는", kpi_1113$날짜[375], "의 데이터입니다.")
  })
  
  output$table1 <- DT::renderDataTable(kpi_1113, server = FALSE, filter = 'top')  
  
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