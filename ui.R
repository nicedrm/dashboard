## app.R ##
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Musel dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
      # menuItem("1.SalesReport", tabName = "sales", icon = icon("list")),
      # menuItem("Update", tabName = "update", icon = icon("list")),
      # menuItem("Samples", tabName = "samples", icon = icon("list"))
      
    )
  ),
  
 
  
  dashboardBody(
    
    tabItems(
      
      tabItem(tabName = "dashboard",
    h3(textOutput("help_text")),
    
    #valuebox on top ----
    fluidRow(
      valueBoxOutput("weekbefore", width = 3),
      valueBoxOutput("monthbefore", width = 3),
      valueBoxOutput("commonth", width = 3),
      valueBoxOutput("premonth", width = 3)
    ),
    
    fluidRow(
      valueBoxOutput("salesBox", width = 3),
      valueBoxOutput("progressBox", width = 3),
      valueBoxOutput("approvalBox", width = 3),
      valueBoxOutput("mpibox", width = 3)
    ),
    
    #MPI valuebox ----
    h3(textOutput("mpi_text")),
    fluidRow(
      valueBoxOutput("mpibox1", width = 3),
      valueBoxOutput("mpibox2", width = 3),
      valueBoxOutput("mpibox3", width = 3),
      valueBoxOutput("mpibox4", width = 3),
      valueBoxOutput("mpibox5", width = 3),
      valueBoxOutput("mpibox6", width = 3),
      valueBoxOutput("mpibox7", width = 3)
    ),
    # fluidRow(
    #  
    # ), 
    # 
    #제품별 데이터----
    h3(textOutput("smr_text")),
    
    fluidRow(
      valueBoxOutput("vbox1", width = 2),
      valueBoxOutput("vbox2", width = 2),
      valueBoxOutput("vbox3", width = 2),
      valueBoxOutput("vbox4", width = 2),
      valueBoxOutput("vbox5", width = 2),
      valueBoxOutput("vbox6", width = 2)
      ),
    fluidRow(
      valueBoxOutput("vbox7", width = 2),
      valueBoxOutput("vbox8", width = 2),
      valueBoxOutput("vbox9", width = 2),
      valueBoxOutput("vbox10", width = 2),
      valueBoxOutput("vbox11", width = 2),
      valueBoxOutput("vbox12", width = 2)
    ),
    fluidRow(
      valueBoxOutput("vbox13", width = 2),
      valueBoxOutput("vbox14", width = 2),
      valueBoxOutput("vbox15", width = 2),
      valueBoxOutput("vbox16", width = 2),
      valueBoxOutput("vbox17", width = 2),
      valueBoxOutput("vbox18", width = 2)
    ),
    fluidRow(
      valueBoxOutput("vbox19", width = 2),
      valueBoxOutput("vbox20", width = 2),
      valueBoxOutput("vbox21", width = 2),
      valueBoxOutput("vbox22", width = 2),
      valueBoxOutput("vbox23", width = 2),
      valueBoxOutput("vbox24", width = 2)
    ),
    #채널별 매출----
    h3(textOutput("chs_text")),
    
    fluidRow(
      valueBoxOutput("chsbox1", width = 2),
      valueBoxOutput("chsbox2", width = 2),
      valueBoxOutput("chsbox3", width = 2),
      valueBoxOutput("chsbox4", width = 2),
      valueBoxOutput("chsbox5", width = 2),
      valueBoxOutput("chsbox6", width = 2)
    ),
    fluidRow(
      valueBoxOutput("chsbox7", width = 2),
      valueBoxOutput("chsbox8", width = 2),
      valueBoxOutput("chsbox9", width = 2)
    ),
    #채널별 비용----
    h3(textOutput("chm_text")),
    
    fluidRow(
      valueBoxOutput("chmbox1", width = 2),
      valueBoxOutput("chmbox2", width = 2),
      valueBoxOutput("chmbox3", width = 2),
      valueBoxOutput("chmbox4", width = 2),
      valueBoxOutput("chmbox5", width = 2),
      valueBoxOutput("chmbox6", width = 2)
    ),
    
    #채널별 비용----
    h3(textOutput("chr_text")),
    # 
    fluidRow(
      valueBoxOutput("chrbox1", width = 2),
      valueBoxOutput("chrbox2", width = 2),
      valueBoxOutput("chrbox3", width = 2),
      valueBoxOutput("chrbox4", width = 2),
      valueBoxOutput("chrbox5", width = 2)
      # valueBoxOutput("chmbox6", width = 2)
    ),

    
    fluidRow(
      box(DT::dataTableOutput("table1")),
      box(DT::dataTableOutput("table2"))
    )
  )
)
)
)

