##load dependencies
library(shiny)
library(ggplot2)
library(shinyjs)

js <- '
$(document).on("keyup", function(e) {
  if(e.keyCode == 13){
    Shiny.onInputChange("keyPressed", Math.random());
  }
});
'

ui = bootstrapPage(
  tags$script(js),
  htmlTemplate("shiny_chat.html", name = "component1")
)

