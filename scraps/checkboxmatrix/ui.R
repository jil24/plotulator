library("shiny")

pageWithSidebar(
  headerPanel("Dynamic Checkbox Matrix"),
  
  sidebarPanel(
    sliderInput(inputId = "dimensions",
      label = "Dimensions:",
      min = 1, max = 10,
      value=1, step = 1,
      ticks = F),
    uiOutput("checkboxmatrix")
    ),
  
    mainPanel(
      tableOutput('datamatrix'))
  )