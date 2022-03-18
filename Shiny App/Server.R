library(shiny)
library(ggplot2)
library(shinyjs)
library(ldatuning)
library(dplyr)
library(tidyr)
library(topicmodels)
require(devtools)
require(quanteda)
library("quanteda.dictionaries")
require(quanteda.textstats)
require(quanteda.textplots)
require(quanteda.corpora)

load('topic_name.rda')
load('topic_answer.rda')

my_model <- readRDS("lda.rds")

positive_bing <- scan("positive-words.txt", what = "char", sep = "\n", skip = 35, quiet = T)
negative_bing <- scan("negative-words.txt", what = "char", sep = "\n", skip = 35, quiet = T)

sentiment_bing <- dictionary(list(positive = positive_bing, negative = negative_bing))

sentimentOfText <- function(dict, text) {
  dfm_sentiment_text <- dfm(text, dictionary = dict)
  dfm_sentiment_df_text <- convert(dfm_sentiment_text, to = "data.frame")
  if(dfm_sentiment_df_text$positive - dfm_sentiment_df_text$negative < 0) {
    return('negative')
  }
  else {
    return('positive')
  }
}

topicOfText <- function(model, text) {
  text_token <- tokens(text, what = "word",
                       remove_numbers = TRUE, remove_punct = TRUE,
                       remove_symbols = TRUE)
  text_token_dfm<-text_token %>%
    tokens_remove(stopwords(source = "smart")) %>%
    tokens_wordstem() %>%
    tokens_tolower() %>%
    dfm()
  x <- posterior(model, text_token_dfm)$topics
  x <- as.data.frame(x)
  result <- colnames(x)[apply(x,1,which.max)]
  return(strtoi(result))
}

function(input, output, session) {
  observeEvent(input[["keyPressed"]], {
    k <- 0
    if (input$message != '') {
      print(input$message)
      k <- k + 1
      input_guy <- input$message
      id <- paste0('txt', k)
      print(id)
      insertUI(
        selector = '#messages',
        ## wrap element in a div with id for ease of removal
        ui = tags$div(class = "block",
                      tags$div(class = "message__item--name",
                               tags$div(class = "message__item--left",
                                        "User")),
                      tags$div(class = "message__item",
                               tags$p(class = "message__item--left",
                                      paste(input_guy))))
      )
      answer <- ''
      if(sentimentOfText(sentiment_bing, input_guy) == 'negative') {
        print('negative')
        topic_number<-topicOfText(review_lda, input_guy)
        print(topic_answer[topic_number])
        answer <- topic_answer[topic_number]
        
      }
      else {
        answer <- "Thank you for your review"
      }
      insertUI(
        selector = '#messages',
        ## wrap element in a div with id for ease of removal
        ui = tags$div(class = "block",
                      tags$div(class = "message__item--name",
                               tags$div(class = "message__item--right",
                                        "Bot")),
                      tags$div(class = "message__item",
                               tags$p(class = "message__item--right",
                                      paste(answer))))
      )
    }
  })
}
