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
  
  # dashboard tab
  output$weekbefore <- renderInfoBox({infoBox("직전주 매출(증가율)", "WIP", icon = icon("list"),color = "red")})
  output$monthbefore <- renderInfoBox({infoBox("직전달 매출(증가율)", "WIP", icon = icon("list"),color = "yellow")})
  output$commonth <- renderInfoBox({infoBox("누적매출","WIP", icon = icon("list"),color = "aqua")})
  output$premonth <- renderInfoBox({infoBox("예상매출", "WIP", icon = icon("list"),color = "blue")})

  output$salesBox <- renderInfoBox({
    infoBox(
      "금일 총 매출", prettyNum(t.sales, format = "d", big.mark = ","), icon = icon("list"),
      color = "yellow"
    )
  })
  
  output$progressBox <- renderInfoBox({
    infoBox(
      "금일 총 광고지출", prettyNum(t.mc, format = "d", big.mark = ","), icon = icon("list"),
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
  output$chs_text <- renderText({
    paste("채널별 매출")
  })
  output$chm_text <- renderText({
    paste("채널별 비용")
  })
  output$chr_text <- renderText({
    paste("채널별 ROAS")
  })
  
  # # MPI box ----
  output$mpibox1 <- renderValueBox({ valueBox( "힐링패치 MPI", "WIP", width = 3, icon = icon("credit-card"), color = "purple")})
  output$mpibox2 <- renderValueBox({ valueBox( "버블퐁 MPI", "WIP", width = 3, icon = icon("credit-card"))})
  output$mpibox3 <- renderValueBox({ valueBox( "씨솔트 MPI", "WIP", width = 3, icon = icon("credit-card"))})
  output$mpibox4 <- renderValueBox({ valueBox( "가벼운한잔 MPI", "WIP", width = 3, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$mpibox5 <- renderValueBox({ valueBox( "찌든때 MPI", "WIP", width = 3, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$mpibox6 <- renderValueBox({ valueBox( "토네이도 MPI", "WIP", width = 3, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$mpibox7 <- renderValueBox({ valueBox( "릴렉스팟 MPI", "WIP", width = 3, icon = icon("thumbs-up", lib = "glyphicon"))})

  
  # 제품별 SMR ----
  output$vbox1 <- renderValueBox({ valueBox( prettyNum(s.hp, format = "d", big.mark = ","), "힐링패치 매출", width = 2, icon = icon("credit-card"))})
  output$vbox2 <- renderValueBox({ valueBox( prettyNum(m.hp, format = "d", big.mark = ","), "힐링패치 광고비", width = 2, icon = icon("credit-card"))})
  output$vbox3 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.hp/m.hp*100),"힐링패치 ROAS", width = 2, icon = icon("credit-card"))})
  output$vbox4 <- renderValueBox({ valueBox( prettyNum(s.bp, format = "d", big.mark = ","),"버블퐁 매출", width = 2, color="blue",icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox5 <- renderValueBox({ valueBox( prettyNum(m.bp, format = "d", big.mark = ","), "버블퐁 광고비", width = 2, color="blue",icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox6 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.bp/m.bp*100),"버블퐁 ROAS", width = 2, color="blue",icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox7 <- renderValueBox({ valueBox( prettyNum(s.ss, format = "d", big.mark = ","),"씨솔트샴푸 매출", width = 2, icon = icon("list"))})
  output$vbox8 <- renderValueBox({ valueBox( prettyNum(m.ss, format = "d", big.mark = ","), "씨솔트샴푸 광고비", width = 2, icon = icon("list"))})
  output$vbox9 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.ss/m.ss*100),"씨솔트샴푸 ROAS", width = 2, icon = icon("list"))})
  output$vbox10 <- renderValueBox({ valueBox( prettyNum(s.ls, format = "d", big.mark = ","),"가벼운한잔 매출", width = 2,color="blue", icon = icon("stethoscope"))})
  output$vbox11 <- renderValueBox({ valueBox( prettyNum(m.ls, format = "d", big.mark = ","), "가벼운한잔 광고비", width = 2, color="blue",icon = icon("stethoscope"))})
  output$vbox12 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.ls/m.ls*100),"가벼운한잔 ROAS", width = 2, color="blue",icon = icon("stethoscope"))})
  output$vbox13 <- renderValueBox({ valueBox( prettyNum(s.gd, format = "d", big.mark = ","),"굿바이찌든때 매출", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$vbox14 <- renderValueBox({ valueBox( prettyNum(m.gd, format = "d", big.mark = ","), "굿바이찌든때 광고비", width = 2, icon = icon("list"))})
  output$vbox15 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.gd/m.gd*100),"굿바이찌든때 ROAS", width = 2, icon = icon("list"))})
  output$vbox16 <- renderValueBox({ valueBox( prettyNum(s.bt, format = "d", big.mark = ","),"버블토네이도 매출", width = 2, color="blue",icon = icon("list"))})
  output$vbox17 <- renderValueBox({ valueBox( prettyNum(m.bt, format = "d", big.mark = ","), "버블토네이도 광고비", width = 2, color="blue",icon = icon("stethoscope"))})
  output$vbox18 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.bt/m.bt*100),"버블토네이도 ROAS", width = 2, color="blue",icon = icon("stethoscope"))})
  output$vbox19 <- renderValueBox({ valueBox( prettyNum(s.rs, format = "d", big.mark = ","),"릴렉스팟 매출", width = 2, icon = icon("list"))})
  output$vbox20 <- renderValueBox({ valueBox( prettyNum(m.rs, format = "d", big.mark = ","), "릴렉스팟 광고비", width = 2, icon = icon("stethoscope"))})
  output$vbox21 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.rs/m.rs*100),"릴렉스팟 ROAS", width = 2, icon = icon("stethoscope"))})
  output$vbox22 <- renderValueBox({ valueBox( prettyNum(s.sp, format = "d", big.mark = ","),"속살패드 매출", width = 2,color="blue", icon = icon("list"))})
  # output$vbox23 <- renderValueBox({ valueBox( prettyNum(m.rs, format = "d", big.mark = ","), "릴렉스팟 광고비", width = 2, color="blue",icon = icon("stethoscope"))})
  # output$vbox24 <- renderValueBox({ valueBox( sprintf("%0.0f%%", s.rs/m.rs*100),"릴렉스팟 ROAS", width = 2, color="blue",icon = icon("stethoscope"))})
  
  # 채널별 매출 ----
  output$chsbox1 <- renderValueBox({ valueBox( prettyNum(c.med, format = "d", big.mark = ","), paste0("자사몰매출", sprintf("%0.0f%%",c.med/t.sales*100)), width = 2, color="blue",icon = icon("credit-card"))})
  output$chsbox2 <- renderValueBox({ valueBox( prettyNum(c.sf, format = "d", big.mark = ","), paste0("스토어팜매출", sprintf("%0.0f%%",c.sf/t.sales*100)), width = 2, icon = icon("credit-card"))})
  output$chsbox3 <- renderValueBox({ valueBox( prettyNum(c.tm, format = "d", big.mark = ","), paste0("티몬매출", sprintf("%0.0f%%",c.tm/t.sales*100)), icon = icon("credit-card"))})
  output$chsbox4 <- renderValueBox({ valueBox( prettyNum(c.cp, format = "d", big.mark = ","), paste0("쿠팡매출", sprintf("%0.0f%%",c.cp/t.sales*100)), width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$chsbox5 <- renderValueBox({ valueBox( prettyNum(c.gm, format = "d", big.mark = ","), paste0("지마켓매출", sprintf("%0.0f%%",c.gm/t.sales*100)), width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$chsbox6 <- renderValueBox({ valueBox( prettyNum(c.el, format = "d", big.mark = ","), paste0("11번가매출", sprintf("%0.0f%%",c.el/t.sales*100)), width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$chsbox7 <- renderValueBox({ valueBox( prettyNum(c.wm, format = "d", big.mark = ","), paste0("위메프매출", sprintf("%0.0f%%",c.wm/t.sales*100)), width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$chsbox8 <- renderValueBox({ valueBox( prettyNum(c.gs, format = "d", big.mark = ","), paste0("GS이숍매출", sprintf("%0.0f%%",c.gs/t.sales*100)), width = 2, icon = icon("credit-card"))})
  output$chsbox9 <- renderValueBox({ valueBox( prettyNum(c.au, format = "d", big.mark = ","), paste0("옥션매출", sprintf("%0.0f%%",c.au/t.sales*100)), width = 2, icon = icon("credit-card"))})

  # tsbc %>% filter(Site == "카페24(신)") %>% select(Totalsales)%>%pull()%>%as.integer()%>%prettyNum(big.mark=",")

  # 채널별 비용 ----
  output$chmbox1 <- renderValueBox({ valueBox( prettyNum(mc.fb, format = "d", big.mark = ","), "페이스북 광고비", width = 2, icon = icon("credit-card"))})
  output$chmbox2 <- renderValueBox({ valueBox( prettyNum(mc.nv, format = "d", big.mark = ","),"네이버광고비", width = 2, icon = icon("credit-card"))})
  output$chmbox3 <- renderValueBox({ valueBox( prettyNum(mc.sf, format = "d", big.mark = ","),"스토어팜광고비", icon = icon("credit-card"))})
  output$chmbox4 <- renderValueBox({ valueBox( prettyNum(mc.el, format = "d", big.mark = ","),"11번가 광고비", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$chmbox5 <- renderValueBox({ valueBox( prettyNum(mc.gm, format = "d", big.mark = ","),"G마켓광고비", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$chmbox6 <- renderValueBox({ valueBox( prettyNum(mc.au, format = "d", big.mark = ","),"옥션광고비", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  
  # output$chmbox6 <- renderValueBox({ valueBox( prettyNum(mc.kk, format = "d", big.mark = ","),"기타광고비", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  
  # 채널별 비용 ----
  output$chrbox1 <- renderValueBox({ valueBox( sprintf("%0.0f%%", c.med/(mc.fb+mc.nv)*100),"자사몰 ROAS", width = 2, icon = icon("credit-card"))})
  output$chrbox2 <- renderValueBox({ valueBox( sprintf("%0.0f%%", c.sf/mc.sf*100),"스토어팜 ROAS", width = 2, icon = icon("credit-card"))})
  output$chrbox3 <- renderValueBox({ valueBox( sprintf("%0.0f%%", c.el/mc.el*100),"11번가 ROAS", icon = icon("credit-card"))})
  output$chrbox4 <- renderValueBox({ valueBox( sprintf("%0.0f%%", c.gm/mc.gm*100),"G마켓 ROAS", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  output$chrbox5 <- renderValueBox({ valueBox( sprintf("%0.0f%%", c.au/mc.au*100),"옥션 ROAS", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  # output$chmbox6 <- renderValueBox({ valueBox( prettyNum(mc.au, format = "d", big.mark = ","),"옥션광고비", width = 2, icon = icon("thumbs-up", lib = "glyphicon"))})
  

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