library(shiny)
library(shinydashboard)
library(DT)
library(dygraphs)
library(recharts)

dashboardPage(
  dashboardHeader(title = "recharts VS dygraphs"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("数据导入",tabName = "Retention-rate",icon = icon("table")),
      menuItem("温度可视化",tabName="hot",icon=icon("thermometer-half")),
      menuItem("天气查询",tabName="find",icon=icon("search"))
      
    )
  ),
  dashboardBody(
    tabItems(
      
      
      # tabItem(tabName = "find",
      #         fileInput("filetq11", label = h3(tagList(icon=icon("sign-in"), "重新导入天气数据"))),
      #         dateInput("date1", label = h3(tagList(icon=icon("list"),"选择时间：")), value = "2017-05-31"),
      #         eChartOutput("cxunecharts")
      #         
      #         
      #         
      # ),#第4个tabItem
      # 
      
      
      tabItem(tabName = "hot",
              fileInput("filetq12", label = h3(tagList(icon=icon("sign-in"), "重新导入天气数据"))),
              checkboxInput("showgrid", label = "grid", value = TRUE),
              checkboxInput("stacked", label = "stacked", value = FALSE),
              dygraphOutput("dygraph1")
              
      )#第5个tabItem
      
    )
  )
)