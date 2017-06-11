function(input,output){
  
  
  #-----recharts
  #-------天气可视化---
  #
  qingdaotq <- reactive({
    data0<-read.csv(input$filetq11$datapath,header = F,col.names = c("Date","MaxT","MinT","Weather","WD","WS"))
    data0$index1="Max(℃)"
    data0$index2<-"Min(℃)"
    data1<-data0%>%filter(as.Date(Date)==input$date1)
    
    data1$index1<-as.character(data1$index1)
    data1$index2<-as.character(data1$index2)
    data1$MaxT<-as.numeric(data1$MaxT)
    data1$MinT<-as.numeric(data1$MinT)
    data2<-data1[,c(1,2,7)]
    names(data2)<-c("Time","Tem","Index")
    data3<-data1[,c(1,3,8)]
    names(data3)<-c("Time","Tem","Index")
    data4<-bind_rows(data2,data3)
    data4$Index1<-as.factor(data4$Index)
    data4
    
  })
  
  output$cxunecharts<- renderEChart({
    if(is.null(input$filetq11))
      return(NULL)
    
    echartr(qingdaotq(),x=Index,y=Tem,facet=Index1,type="gauge")%>%setTheme("dark")%>%
      setSeries(min=-20,max=50,radius=c(0,"80%"))
    
  })
  
  
  #-----dygrahh
  
  temprature<-reactive({
    datatem<-read.csv(input$filetq12$datapath,header = F,col.names = c("Date","MaxT","MinT","Weather","WD","WS"))
    datatem1<-data.frame(cbind(datatem$MaxT,datatem$MinT),row.names=as.Date(datatem$Date))
    names(datatem1)<-c("Max","Min")
    datatem1
  })
  
  output$dygraph1<-renderDygraph({
    
    if(is.null(input$filetq12))
      return(NULL)
    
    
    dygraph(temprature()) %>%
      dySeries("Max", label = "Max") %>%
      dySeries("Min", label = "Min") %>%
      dyOptions(drawGrid = input$showgrid,stackedGraph = input$stacked) %>%
      dyRangeSelector()
    
  }) 
  
  
  
  
  
}