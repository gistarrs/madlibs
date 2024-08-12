library(shiny)

cat(strrep("-", 100), "🐀 Initiating 🐁 \n", file = stderr()) 

generate_story <- function(noun, verb, adjective, adverb) {
  glue::glue("
    Once upon a time, there was a {adjective} {noun} who loved to
    {verb} {adverb}. It was the funniest thing ever!
  ")
}


ui <- fluidPage(
  titlePanel("Mad Libs Game"),
  sidebarLayout(
    sidebarPanel(
      textInput("noun1", "Enter a noun:", ""),
      textInput("verb", "Enter a verb:", ""),
      textInput("adjective", "Enter an adjective:", ""),
      textInput("adverb", "Enter an adverb:", ""),
      actionButton("submit", "Create Story")
    ),
    mainPanel(
      h3("Your Mad Libs Story:"),
      textOutput("story")
    )
  )
)

server <- function(input, output) {
  story <- eventReactive(input$submit, {
    generate_story(input$noun1, input$verb, input$adjective, input$adverb)
  })
  cat(strrep("-", 100), "🐁 Generating story! 🐀 \n", file = stderr())
  output$story <- renderText({
    story()
  })
}

cat(strrep("-", 100), "✨ Completed! ✨\n", file = stderr()) 

shinyApp(ui = ui, server = server)
