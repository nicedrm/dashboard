library(shiny)
library(shinydashboard)
library(DT)
library(readr)


setwd("/srv/shiny-server/musel")
# kpi_1113 <- read_rds("data/kpi.1127.rds")
# load("data/kpi.1127.RData")
# load("data/smr.RData")
load("data/1129.RData")

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
  options(shiny.fullstacktrace = TRUE)
  options(shiny.error = browser)
  # options(shiny.trace=TRUE)
  # options(shiny.error = recover)
  # options(shiny.sanitize.errors = FALSE)
  
  #dashboard tab
  output$salesBox <- renderInfoBox({
    infoBox(
      "금일 총 매출", "51,227,400", icon = icon("list"),
      color = "yellow"
    )
  })
  
  output$progressBox <- renderInfoBox({
    infoBox(
      "금일 총 광고지출", "12,985,146", icon = icon("list"),
      color = "purple"
    )
  })

  output$approvalBox <- renderInfoBox({
    infoBox(
      "금일 총 ROAS", "395%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "blue"
    )
  })
  
  output$help_text <- renderText({
    paste(datef, "데이터입니다.")
  })
  
  output$vbox1 <- renderValueBox({ valueBox( formatC(sr.hp, format = "d", big.mark = ","), "힐링패치 매출", width = 2, icon = icon("credit-card"))})
  output$vbox2 <- renderValueBox({ valueBox( formatC(mc.hp, format = "d", big.mark = ","), "힐링패치 지출", width = 2, icon = icon("credit-card"))})
  output$vbox3 <- renderValueBox({ valueBox( sprintf("%0.0f%%", sr.hp/mc.hp*100),"힐링패치 ROAS", width = 2, icon = icon("credit-card"))})
  output$vbox4 <- renderValueBox({ valueBox( formatC(sr.bp, format = "d", big.mark = ","),"버블퐁 매출", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox5 <- renderValueBox({ valueBox( formatC(mc.bp, format = "d", big.mark = ","), "버블퐁 지출", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox6 <- renderValueBox({ valueBox( sprintf("%0.0f%%", sr.bp/mc.bp*100),"버블퐁 ROAS", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox7 <- renderValueBox({ valueBox( formatC(sr.ss, format = "d", big.mark = ","),"씨솔트샴푸 매출", width = 2, icon = icon("list"))})
  output$vbox8 <- renderValueBox({ valueBox( formatC(mc.ss, format = "d", big.mark = ","), "씨솔트샴푸 지출", width = 2, icon = icon("list"))})
  output$vbox9 <- renderValueBox({ valueBox( sprintf("%0.0f%%", sr.ss/mc.ss*100),"씨솔트샴푸 ROAS", width = 2, icon = icon("list"))})
  output$vbox10 <- renderValueBox({ valueBox( formatC(sr.ls, format = "d", big.mark = ","),"가벼운한잔 매출", width = 2, icon = icon("stethoscope"))})
  output$vbox11 <- renderValueBox({ valueBox( formatC(mc.ls, format = "d", big.mark = ","), "가벼운한잔 지출", width = 2, icon = icon("stethoscope"))})
  output$vbox12 <- renderValueBox({ valueBox( sprintf("%0.0f%%", sr.ls/mc.ls*100),"가벼운한잔 ROAS", width = 2, icon = icon("stethoscope"))})
  output$vbox13 <- renderValueBox({ valueBox( formatC(sr.gd, format = "d", big.mark = ","),"굿바이찌든때 매출", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox14 <- renderValueBox({ valueBox( formatC(mc.gd, format = "d", big.mark = ","), "굿바이찌든때 지출", width = 2, icon = icon("list"))})
  output$vbox15 <- renderValueBox({ valueBox( sprintf("%0.0f%%", sr.gd/mc.gd*100),"굿바이찌든때 ROAS", width = 2, icon = icon("list"))})
  output$vbox16 <- renderValueBox({ valueBox( formatC(sr.bt, format = "d", big.mark = ","),"버블토네이도 매출", width = 2, icon = icon("list"))})
  output$vbox17 <- renderValueBox({ valueBox( formatC(mc.bt, format = "d", big.mark = ","), "버블토네이도 지출", width = 2, icon = icon("stethoscope"))})
  output$vbox18 <- renderValueBox({ valueBox( sprintf("%0.0f%%", sr.bt/mc.bt*100),"버블토네이도 ROAS", width = 2, icon = icon("stethoscope"))})
  output$vbox19 <- renderValueBox({ valueBox( formatC(sr.bt, format = "d", big.mark = ","),"릴렉스팟 매출", width = 2, icon = icon("list"))})
  output$vbox20 <- renderValueBox({ valueBox( formatC(mc.bt, format = "d", big.mark = ","), "릴렉스팟 지출", width = 2, icon = icon("stethoscope"))})
  output$vbox21 <- renderValueBox({ valueBox( sprintf("%0.0f%%", sr.bt/mc.bt*100),"릴렉스팟 ROAS", width = 2, icon = icon("stethoscope"))})
  
  output$table1 <- DT::renderDataTable(kpi, server = FALSE, filter = 'top',
                                       options = list(order = list(1, 'desc'),
    columnDefs = list(list(width = '200px', targets = "_all"))
  ))  
  
  output$table2 <- DT::renderDataTable(kpi, server = FALSE, filter = 'top',
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
}