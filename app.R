library(shiny)

ui <- fluidPage(
  titlePanel("iris veri seti"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "DEGISKEN",label = "bir degisken seciniz",
                     choices = c("Sepal.Length" = 1,
                                 "Sepal.Widht" = 2,
                                 "Petal.Lenght" = 3,
                                 "Petal.Widht" = 4)),
      sliderInput(inputId = "aralik",
                  label = "bir aralık seçiniz",
                  min = 5, max = 25 , value = 15),
      br(),
      radioButtons(inputId = "renk",
                   label = "grafik için bir renk seçiniz",
                   choices = c("red","yellow","blue"),
                   selected = "blue")
    ),
          mainPanel( tabsetPanel(
            type = "tab",
            tabPanel(title = "SUMMARY TABLE",
                     verbatimTextOutput("SUMMARY_TABLE")),
            tabPanel(title = "DATA STRUCTURE",
                     verbatimTextOutput("str")),
            tabPanel(title = "DATA",
                     tableOutput("data")),
            
            tabPanel(title = "HISTOGRAM",
                     plotOutput("histogram")),
            
            tabPanel(title = "BOXPLOT",
                     plotOutput("boxplot")),
            tabPanel(title = "CORRELATION PLOT",
                     plotOutput("crplot"))
          )
            
          )      )
  
)

server <- function(input, output, session) {
  output$SUMMARY_TABLE<- renderPrint({summary(iris)})
  output$str<- renderPrint({str(iris)})
  
  output$data<- renderTable({colm <- as.numeric(input$DEGISKEN)
  iris[,colm]
  })
  
  output$histogram<- renderPlot({
    colm<- as.numeric(input$DEGISKEN)
    hist(iris[,colm],
         breaks = seq(0, input$aralik),
         col = input$renk,
         xlab =  "aralik")
  })
  
  output$boxplot<- renderPlot({
    colm<- as.numeric(input$DEGISKEN)
    boxplot(iris[,colm],
            col = input$renk,
            xlab = "variable")
  })
  
}

shinyApp(ui, server)