library(shiny)
library(shinydashboard)



server <- function(input, output) {
  
  #dashboard tab
  output$salesBox <- renderInfoBox({
    infoBox(
      "금일 총 매출", "25,000,000,000", icon = icon("list"),
      color = "yellow"
    )
  })
  
  output$progressBox <- renderInfoBox({
    infoBox(
      "금일 총 광고지출", "25,000,000", icon = icon("list"),
      color = "purple"
    )
  })

  output$approvalBox <- renderInfoBox({
    infoBox(
      "금일 총 ROAS", "800%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "blue"
    )
  })
  
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