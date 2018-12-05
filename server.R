library(shiny)
library(shinydashboard)
library(DT)
library(readr)

setwd("/srv/shiny-server/musel")
load("data/all.RData")

server <- function(input, output) {
  options(shiny.fullstacktrace = TRUE)
  options(shiny.error = browser)
  # options(shiny.trace=TRUE)
  # options(shiny.error = recover)
  # options(shiny.sanitize.errors = FALSE)
  
  #dashboard tab
  # output$weekbefore <- renderInfoBox({infoBox("직전주 매출.증가율", "WIP", icon = icon("list"),color = "yellow")})
  # output$monthbefore <- renderInfoBox({infoBox("전달 매출.증가율", "WIP", icon = icon("list"),color = "yellow")})
  # output$commonth <- renderInfoBox({infoBox("누적매출","WIP", icon = icon("list"),color = "yellow")})
  # output$premonth <- renderInfoBox({infoBox("예상매출", "WIP", icon = icon("list"),color = "yellow")})
  
  output$salesBox <- renderInfoBox({
    infoBox(
      "금일 총 매출", formatC(t.sales, format = "d", big.mark = ","), icon = icon("list"),
      color = "yellow"
    )
  })
  
  output$progressBox <- renderInfoBox({
    infoBox(
      "금일 총 광고지출", formatC(t.mc, format = "d", big.mark = ","), icon = icon("list"),
      color = "purple"
    )
  })

  output$approvalBox <- renderInfoBox({
    infoBox(
      "금일 총 ROAS", sprintf("%0.0f%%", t.sales/t.mc*100), icon = icon("thumbs-up", lib = "glyphicon"),
      color = "blue"
    )
  })
  output$mpibox <- renderInfoBox({
    infoBox(
      "총MPI", "WIP", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "blue"
    )
  })
  
  
  output$help_text <- renderText({
    paste(datef, "데이터입니다.")
  })
  output$smr_text <- renderText({
    paste("제품별 데이터")
  })
  output$mpi_text <- renderText({
    paste("제품별 MPI")
  })
  
  # MPI box ----
  output$mpibox1 <- renderValueBox({ valueBox( "힐링패치 MPI", "WIP", width = 2, icon = icon("credit-card"))})
  output$mpibox2 <- renderValueBox({ valueBox( "버블퐁 MPI", "WIP", width = 2, icon = icon("credit-card"))})
  output$mpibox3 <- renderValueBox({ valueBox( "씨솔트 MPI", "WIP", icon = icon("credit-card"))})
  output$mpibox4 <- renderValueBox({ valueBox( "가벼운한잔 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$mpibox5 <- renderValueBox({ valueBox( "찌든때 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$mpibox6 <- renderValueBox({ valueBox( "토네이도 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$mpibox7 <- renderValueBox({ valueBox( "릴렉스팟 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  
  
  # 제품별 SMR ----
  output$vbox1 <- renderValueBox({ valueBox( formatC(s.hp, format = "d", big.mark = ","), "힐링패치 매출", width = 2, icon = icon("credit-card"))})
  output$vbox2 <- renderValueBox({ valueBox( formatC(m.hp, format = "d", big.mark = ","), "힐링패치 광고비", width = 2, icon = icon("credit-card"))})
  output$vbox3 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.hp/m.hp*100),"힐링패치 ROAS", width = 2, icon = icon("credit-card"))})
  output$vbox4 <- renderValueBox({ valueBox( formatC(s.bp, format = "d", big.mark = ","),"버블퐁 매출", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox5 <- renderValueBox({ valueBox( formatC(m.bp, format = "d", big.mark = ","), "버블퐁 광고비", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox6 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.bp/m.bp*100),"버블퐁 ROAS", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox7 <- renderValueBox({ valueBox( formatC(s.ss, format = "d", big.mark = ","),"씨솔트샴푸 매출", width = 2, icon = icon("list"))})
  output$vbox8 <- renderValueBox({ valueBox( formatC(m.ss, format = "d", big.mark = ","), "씨솔트샴푸 광고비", width = 2, icon = icon("list"))})
  output$vbox9 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.ss/m.ss*100),"씨솔트샴푸 ROAS", width = 2, icon = icon("list"))})
  output$vbox10 <- renderValueBox({ valueBox( formatC(s.ls, format = "d", big.mark = ","),"가벼운한잔 매출", width = 2, icon = icon("stethoscope"))})
  output$vbox11 <- renderValueBox({ valueBox( formatC(m.ls, format = "d", big.mark = ","), "가벼운한잔 광고비", width = 2, icon = icon("stethoscope"))})
  output$vbox12 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.ls/m.ls*100),"가벼운한잔 ROAS", width = 2, icon = icon("stethoscope"))})
  output$vbox13 <- renderValueBox({ valueBox( formatC(s.gd, format = "d", big.mark = ","),"굿바이찌든때 매출", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox14 <- renderValueBox({ valueBox( formatC(m.gd, format = "d", big.mark = ","), "굿바이찌든때 광고비", width = 2, icon = icon("list"))})
  output$vbox15 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.gd/m.gd*100),"굿바이찌든때 ROAS", width = 2, icon = icon("list"))})
  output$vbox16 <- renderValueBox({ valueBox( formatC(s.bt, format = "d", big.mark = ","),"버블토네이도 매출", width = 2, icon = icon("list"))})
  output$vbox17 <- renderValueBox({ valueBox( formatC(m.bt, format = "d", big.mark = ","), "버블토네이도 광고비", width = 2, icon = icon("stethoscope"))})
  output$vbox18 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.bt/m.bt*100),"버블토네이도 ROAS", width = 2, icon = icon("stethoscope"))})
  output$vbox19 <- renderValueBox({ valueBox( formatC(s.rs, format = "d", big.mark = ","),"릴렉스팟 매출", width = 2, icon = icon("list"))})
  output$vbox20 <- renderValueBox({ valueBox( formatC("0", format = "d", big.mark = ","), "릴렉스팟 광고비", width = 2, icon = icon("stethoscope"))})
  output$vbox21 <- renderValueBox({ valueBox( sprintf("%0.0f%%", 0),"릴렉스팟 ROAS", width = 2, icon = icon("stethoscope"))})
  
  # 채널별 매출 ----
  # output$chsbox1 <- renderValueBox({ valueBox( "힐링패치 MPI", "WIP", width = 2, icon = icon("credit-card"))})
  # output$chsbox2 <- renderValueBox({ valueBox( "버블퐁 MPI", "WIP", width = 2, icon = icon("credit-card"))})
  # output$chsbox3 <- renderValueBox({ valueBox( "씨솔트 MPI", "WIP", icon = icon("credit-card"))})
  # output$chsbox4 <- renderValueBox({ valueBox( "가벼운한잔 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  # output$chsbox5 <- renderValueBox({ valueBox( "찌든때 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  # output$chsbox6 <- renderValueBox({ valueBox( "토네이도 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  # output$chsbox7 <- renderValueBox({ valueBox( "릴렉스팟 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  # 
  # # 채널별 비용 ----
  # output$chmbox1 <- renderValueBox({ valueBox( "힐링패치 MPI", "WIP", width = 2, icon = icon("credit-card"))})
  # output$chmbox2 <- renderValueBox({ valueBox( "버블퐁 MPI", "WIP", width = 2, icon = icon("credit-card"))})
  # output$chmbox3 <- renderValueBox({ valueBox( "씨솔트 MPI", "WIP", icon = icon("credit-card"))})
  # output$chmbox4 <- renderValueBox({ valueBox( "가벼운한잔 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  # output$chmbox5 <- renderValueBox({ valueBox( "찌든때 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  # output$chmbox6 <- renderValueBox({ valueBox( "토네이도 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  # output$chmbox7 <- renderValueBox({ valueBox( "릴렉스팟 MPI", "WIP", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  
  output$table1 <- DT::renderDataTable(
    kpi, server = FALSE, filter = 'top',
    options = list(order = list(1, 'desc'),
    columnDefs = list(list(width = '200px', targets = "_all"))
  ))
  
  output$table2 <- DT::renderDataTable(
    mclong, server = FALSE, filter = 'top',
    options = list(order = list(1, 'desc'),
    columnDefs = list(list(width = '200px', targets = "_all"))
  ))
  
}