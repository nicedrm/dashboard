library(shiny)
library(shinydashboard)
library(DT)
library(readr)


setwd("/srv/shiny-server/musel")
kpi_1113 <- read_rds("data/kpi.1113.rds")

# product_list <- pid %>%
#   collect() %>%
#   split(.$Product) %>%
#   map(~ .$PID)
# 
# month_list <- as.list(1:12) %>%
#   set_names(month.name)
# 
# month_list$`All Year` <- 99


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
  
  output$table1 <- DT::renderDataTable(kpi_1113, server = FALSE, filter = 'top',
                                       options = list(order = list(1, 'desc'),
    columnDefs = list(list(width = '200px', targets = "_all"))
  ))  
  
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
  output$vbox1 <- renderValueBox({ valueBox( "힐링패치","매출", width = 2, icon = icon("credit-card"))})
  output$vbox2 <- renderValueBox({ valueBox( "힐링패치","지출", width = 2, icon = icon("credit-card"))})
  output$vbox3 <- renderValueBox({ valueBox( "힐링패치","ROAS", width = 2, icon = icon("credit-card"))})
  output$vbox4 <- renderValueBox({ valueBox( "버블퐁","매출", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox5 <- renderValueBox({ valueBox( "버블퐁","지출", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox6 <- renderValueBox({ valueBox( "버블퐁","ROAS", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox7 <- renderValueBox({ valueBox( "씨솔트샴푸","매출", width = 2, icon = icon("list"))})
  output$vbox8 <- renderValueBox({ valueBox( "씨솔트샴푸","지출", width = 2, icon = icon("list"))})
  output$vbox9 <- renderValueBox({ valueBox( "씨솔트샴푸","ROAS", width = 2, icon = icon("list"))})
  output$vbox10 <- renderValueBox({ valueBox( "가벼운한잔","매출", width = 2, icon = icon("stethoscope"))})
  output$vbox11 <- renderValueBox({ valueBox( "가벼운한잔","지출", width = 2, icon = icon("stethoscope"))})
  output$vbox12 <- renderValueBox({ valueBox( "가벼운한잔","ROAS", width = 2, icon = icon("stethoscope"))})
  output$vbox13 <- renderValueBox({ valueBox( "굿바이찌든때","매출", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox14 <- renderValueBox({ valueBox( "굿바이찌든때","지출", width = 2, icon = icon("list"))})
  output$vbox15 <- renderValueBox({ valueBox( "굿바이찌든때","ROAS", width = 2, icon = icon("list"))})
  output$vbox16 <- renderValueBox({ valueBox( "버블토네이도","매출", width = 2, icon = icon("list"))})
  output$vbox17 <- renderValueBox({ valueBox( "버블토네이도","지출", width = 2, icon = icon("stethoscope"))})
  output$vbox18 <- renderValueBox({ valueBox( "버블토네이도","ROAS", width = 2, icon = icon("stethoscope"))})

  
}