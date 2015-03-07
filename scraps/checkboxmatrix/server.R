library("shiny")

function(input,output) {
  
  output$checkboxmatrix <- renderUI({
    checkboxlist <- vector("list",input$dimensions)    
    if (input$dimensions > 1) {
      for (i in 1:(input$dimensions)) {
        if (i == 1) {
            checkboxlist[[i]] <- tags$tr(lapply(c("vs",2:input$dimensions),tags$td))
          } else {
            checkboxlist[[i]] <- tags$tr(lapply(1:input$dimensions,function(j) {
              if (j >= i) {
                tags$td(div(checkboxInput(
                  paste("comp",i-1,"v",j,sep=""),label=NULL,value = FALSE), 
                    style="display:inline-block;overflow:hidden;height:20pt;margin-top:-10pt;"))
              } else if (j==1) {
                tags$td(i-1)
              } else {tags$td()}
            }))
          }
        
      }    
    }
    
    
    return(tags$table(checkboxlist,style="table-layout:fixed;",width="100%",height=(input$dimensions+1)*5))})
  
    datamatrix <- reactive({
      dm <- matrix(rep(NA,input$dimensions * input$dimensions),nrow=input$dimensions)
      (row(dm)<col(dm))
      dm=matrix(paste0("comp",row(dm),"v",col(dm)),nrow=input$dimensions)
      dm=matrix(sapply(dm,function(x) {if (x %in% names(input)) input[[x]] else ""}),nrow=input$dimensions)})
  
    output$datamatrix <- renderTable(datamatrix())
  }
