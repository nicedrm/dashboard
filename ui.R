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
    fluidRow(
      # A static valueBox
      valueBoxOutput("salesBox"),
      
      # Dynamic valueBoxes
      valueBoxOutput("progressBox"),
      
      valueBoxOutput("approvalBox")
    ),
    fluidRow(
      column(2),
      column(8, textOutput("help_text")),
      column(2)
      ),
    fluidRow(
      box(DT::dataTableOutput("table1"))
    ),

    tabsetPanel(
      id ="tab",
      tabPanel(
        title = "detailed sales",
        value = "page1",
        #직전주 매출, 직전주 roas, 금월 예상매출
        # fluidRow(
        #   valueBoxOutput("weeksales"),
        #   valueBoxOutput("weekroas"),
        #   valueBoxOutput("monthsales")
        # ),
      
    fluidRow(
      selectInput(
        inputId = "product",
        label = "Product:",
        choices = product_list,
        selected = "1",
        selectize = FALSE
      ),
      selectInput(
        inputId = "month",
        label = "Month:",
        choices = month_list,
        selected = 99,
        size = 13,
        selectize = FALSE
      ),
      actionLink("remove", "Remove detail tabs")
    )
      )
    )
    # fluidRow(
    #   column(2),
    #   column(8, DT::dataTableOutput('total_sales')),
    #   column(2)
    # )
    
    # h2("매출 데이터는 29일(월)부터 4일(일)까지입니다.")
    
    
  )
)
)
)

