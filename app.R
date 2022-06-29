## app.R ##
library(shinydashboard)

ui <- dashboardPage## app.R ##
library(shinydashboard)
library(highcharter)

ui <- dashboardPage(
  dashboardHeader(title = "Heart Attack Predict"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Visualisasi", tabName = "visual", icon = icon("dashboard")),
      menuItem("Prediksi", tabName = "model", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "visual",
              box(
                title = "ScatterPlot",
                highchartOutput("sp")
              ),
              box(
                title = "Histogram",
                highchartOutput("hist")
              )
      ),
      
      # Second tab content
      tabItem(tabName = "model",
              h2("Model tab content")
      )
    )
  )
)


server <- function(input, output) {
  data_ha <- read.csv("data/heart.csv")
  
  output$sp <- renderHighchart({
    #data vis 1
    hchart(data_ha, "scatter", hcaes(x = trtbps, y = chol, group = sex))
  })
  
  output$hist <- renderHighchart({
    hchart(data_ha$age, name = "data") 
  })
}

shinyApp(ui, server)
