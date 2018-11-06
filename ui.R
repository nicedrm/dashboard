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
    )
    
    
  )
)
)
)

