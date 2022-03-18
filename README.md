# Customer-Service-AI
A chatbot that will answer to client inquiries about the quality of a specific product(in our case the product is a guitar). It was build on R, and uses Sentiment Analysis and Latent Dirichlet Allocation algorisms to categorize data into several topics. This bot helps clients to get an immediate response to their questions and concerns which will of-course result in a better client experience. I also created a [Shiny App](https://best-ever-shiny-app-deserves-high-grade.shinyapps.io/project/) to demonstrate the responses in action.

# Sentiment Analysis and LDA techniques in product reviews

## Introduction

Before buying a new musical instrument, we frequently consult look at the reviews of the product read comments from users. Reading those reviews helps to make more informed decisions and can lead to a deeper understanding of the product. Besides that, businesses that sell those products want to have someone to reply to those reviews which cannot be done by a human if there are thousands of reviews. Thus, it is in interest of the company to have an automated system to reply to these reviews.

In this project we try to focus one specific types of products – musical instruments. The data that we use is from We will use the musical instruments reviews from Amazon ([Here is the link](https://utah.instructure.com/courses/693618/files/117113754?wrap=1)). There are three steps we will use create an automated review response system. First, we will perform sentiment analysis to determine which reviews are positive and which are negative. We do this to address only negative reviews as positive ones are usually don&#39;t need a response. Second, we will perform a Latent Dirichlet Analysis on the negative reviews to divide these reviews into several groups. We do this to build a more intelligent response system that gives different answers based on the content of the given review. Finally, we build a chat bot that will answer to client inquiries. This will help clients to get an immediate response to their questions and concerns which will of-course result in a better client experience. We also created a [ Shiny App](https://best-ever-shiny-app-deserves-high-grade.shinyapps.io/project/) to demonstrate the responses in action.

## Methods and Discussion

In this section we will talk about how we solved our business problem by showing each step-in detail. Also, we will discuss other possible approaches and methods.

Step 1 – Sentiment Analysis

Before we talk about sentiment analysis a few words about data preparation. After loading data, we removed numbers, punctuation hyphens and symbols. Then we removed stop words stemmed the words and lowercased our tokens. Finally, we turned that into document feature matrix. We also did some analysis on the frequency of different tokens and did some research about distribution of tokens in documents. Finally, we visualized this with a word cloud (see picture below). This helps us determine the most important tokens in our dataset as well as understand the general structure of documents.

![](RackMultipart20220318-4-12dxcvc_html_125c43b82886aa7d.png)

Let&#39;s now talk about sentiment analysis. For our model the positive and negative tokens we used are from Bing&#39;s dictionary [1]. After loading this dataset, we used it to calculate the number of positive and negative tokens in our reviews and based on that calculate net difference between them (positive - negative = net). We used -2 as the threshold for a given review being negative as this number proves to result in a better performance in the future when we create our chatbot. Finally, we plotted the share of positive and negative reviews. We can see from the picture below that there are generally more positive reviews than negative ones. We saved our negative reviews in a separate variable to use in the next step

![](RackMultipart20220318-4-12dxcvc_html_44fbd6d45a165054.png)

Step 2 – Latent Dirichlet Analysis

For LDA we sampled only 200 of the negative reviews that we obtained from step 1. This is done in order to increase speed of computations as well as to add some randomness to our LDA. For our LDA we used Gibbs method and we used number of iterations - 200. To determine the best number of topics we used the perplexity function over range 2:50. It turns out the number of topics resulting from this method is 42 which is of course too large. This might result from the fact that we choose only 200 reviews for our sample. For convenience we choose number 4 but of course in practice we would pay more attention to this number and try to find the most suitable one either using perplexity or other methods [2]. After that we calculate term to topic and document to topic probabilities. We also plotted the top 10 terms in each topic.

![](RackMultipart20220318-4-12dxcvc_html_552873e32994c9db.png)

We also printed top 10 documents in each topic. Using those two tables we were able to determine which is every single topic about and were able to give names to different topics and create sample answers for them.

topic\_name[1] =&#39;pedal\_issues&#39;

topic\_answer[1] =&quot;Please read carefully the manual before using the product, use a different pedal or contact us for a refund or a techical assistance.&quot;

topic\_name[2] =&#39;noice\_issue&#39;

topic\_answer[2] =&quot;If you experiencing noice issue while using our product that means there is an installation problem. Please refer to this manual https://www.howtononoice.com/angry/customer for a detailed instruction.&quot;

topic\_name[3] =&quot;problem\_with\_strings&quot;

topic\_answer[3] =&quot;This is a common problem. A system of strongly interacting strings can, in some cases, behave as a system of weakly interacting strings which results in a bad sound. Please contant one of our representatives - Ashoke Sen((801)122 2888) for details.&quot;

topic\_name[4] =&quot;bad\_quality\_cable&quot;

topic\_answer[4] =&quot;Sorry for hearing that. For now, we will do our best to sell as much product as possible but if quality becomes something that affects our sales we promise to focus on that.&quot;

Step 3 – ChatBot functions

In this step we created two main functions – sentimentOfText and topicOfText which basically return the sentiment and the topic of a given text. sentimentOfText takes two arguments - dictionary and the text while topicOfText takes the lda model for the first argument and text for the second. After that the inner work of functions is the same as we did with our review data.

Step 4 – Creating the Shiny app

This step is an extra step to demonstrate how our app might look like in real world. We used shiny and shinyjs libraries to create a simple app for use. When user types a review the app will evaluate the reviews sentiment and if it&#39;s a negative one it will also determine its topic. After that our bot will answer to the user with a specific answer for that particular topic. Visit our app here : [ Shiny App](https://best-ever-shiny-app-deserves-high-grade.shinyapps.io/project/).

## Conclusion

In this project we learned on how to do a basic sentiment analysis and lda modeling in order to evaluate user input more specifically – user review. We used different techniques to achieve this and we different visualizations to get a better insight in our data. Finally, we created a real-time chat bot to generate responses to different reviews based on their content.

## Bibliography

Resources

1) Bing Liu Tutorial: [https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html#lexicon](https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html#lexicon)

2) [https://www.cs.uic.edu/~liub/FBS/NLP-handbook-sentiment-analysis.pdf](https://www.cs.uic.edu/~liub/FBS/NLP-handbook-sentiment-analysis.pdf)

3) [http://sentiment.christopherpotts.net/index.html](http://sentiment.christopherpotts.net/index.html)

4) Dependency Parsing: [https://web.stanford.edu/~jurafsky/slp3/15.pdf](https://web.stanford.edu/~jurafsky/slp3/15.pdf)

5) [https://tm4ss.github.io/docs/Tutorial\_6\_Topic\_Models.html](https://tm4ss.github.io/docs/Tutorial_6_Topic_Models.html)

6) [https://cfss.uchicago.edu/notes/topic-modeling/#importing-our-own-lda-model](https://cfss.uchicago.edu/notes/topic-modeling/#importing-our-own-lda-model)

7) [https://stat.ethz.ch/CRAN/web/packages/ldatuning/vignettes/topics.html](https://stat.ethz.ch/CRAN/web/packages/ldatuning/vignettes/topics.html)

8) [http://jjacobs.me/tad/04\_Topic\_Modeling\_ggplot2.html](http://jjacobs.me/tad/04_Topic_Modeling_ggplot2.html)

9) [https://knowledger.rbind.io/post/topic-modeling-using-r/](https://knowledger.rbind.io/post/topic-modeling-using-r/)

10) [https://www.tidytextmining.com/topicmodeling.html](https://www.tidytextmining.com/topicmodeling.html)

References

Scherer, Klaus R. 1984. Emotion as a Multicomponent Process: A model and some crosscultural data. In P. Shaver, ed., Review of Personality and Social Psych 5: 37-63.

Ekman, Paul. 1985. Telling Lies: Clues to Deceit in the Marketplace, Politics, and Marriage. New York:

Norton.

Sanjiv Das and Mike Chen. 2001. Yahoo! for Amazon: extracting market sentiment from stock message

boards. In Proceedings of the 8th Asia Pacific Finance Association Annual Conference.

Pang, Bo; Lillian Lee; and Shivakumar Vaithyanathan. 2002. Thumbs up? sentiment classification using

machine learning techniques. In Proceedings of the Conference on Empirical Methods in Natural Language

Processing. ACL.

Plutchik, Robert. 2002. Emotions and Life. Washington, D.C.: American Psychological Association.

V. Metsis, I. Androutsopoulos, G. Paliouras. 2006. Spam Filtering with Naive Bayes – Which Naive Bayes?

CEAS 2006 -Third Conference on Email and AntiSpam.
